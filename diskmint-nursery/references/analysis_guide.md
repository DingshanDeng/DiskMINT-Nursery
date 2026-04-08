# Analysis Guide

Reference for reading, reconstructing, and visualising DiskMINT output files after a model run.
Read `$DISKMINT_REF/output_format_reference.md` alongside this guide for column definitions and file formats.

---

## Three Analysis Workflows

| Workflow | Notebooks | Entry point |
|---|---|---|
| 1. Thermal / density structure | notebook 1 | `modelgrid.readData()` |
| 2. SED | notebook 2 | `radmc3dPy.analyze.readSpectrum()` |
| 3. Chemical network output | notebook 3 | `utils.read_model()` pipeline |

---

## Workflow 1 — Thermal and Density Structure

**Required files:** `dust_density.inp`, `dust_temperature.dat`, `gas_temperature.inp`, `ratio_g2d_grid.dat`

### Load data

```python
import numpy as np
import diskmint.constants as const
import diskmint.modelgrid as modelgrid

d = modelgrid.readData(dtemp=True, ddens=True, gtemp=True)
# d.rhodust   shape: (nr, ntheta, nphi, n_dust)   [g/cm³]
# d.dusttemp  shape: (nr, ntheta, nphi, n_dust)   [K]
# d.gastemp   shape: (nr, ntheta, nphi, 1)         [K]
```

### Reconstruct gas density

Gas density is not stored directly — reconstruct from dust + spatially-varying g2d ratio:

```python
rhodust_all = d.rhodust.sum(axis=3)

ratio_g2d_grid = np.loadtxt("ratio_g2d_grid.dat").reshape(rhodust_all.shape)
ratio_g2d_grid[ratio_g2d_grid == np.inf] = np.nan

rhogas = rhodust_all * ratio_g2d_grid
rhogas[rhogas <= const.mu] = const.mu   # floor at mean molecular weight
```

### Coordinate system

RADMC-3D uses spherical (r, θ) coordinates. θ is co-latitude (0 = pole, π/2 = midplane):

```python
rc     = d.grid.x   # radii [cm]
thetac = d.grid.y   # co-latitude [rad]

rc_2D, theta_2D, _ = np.meshgrid(rc, thetac, d.grid.z, indexing='ij')
zr_2D = np.pi/2 - theta_2D   # opening angle z/r (dimensionless)
```

For 2D structure maps: x-axis = `rc / au`, y-axis = `zr_2D`.

### Surface density

```python
au = 1.496e13  # cm per au
trapz = np.trapezoid if hasattr(np, "trapezoid") else np.trapz

zz_2D = np.sin(zr_2D) * rc_2D   # z [cm]
sigma_gas = 4.0 * np.pi * trapz(rhogas[:, :, 0], x=-zz_2D[:, :, 0], axis=1)
# sigma_gas  shape: (nr,)   units: g/cm²
```

---

## Workflow 2 — SED

**Required files:** `spectrum.out` (produced when `bool_SED = True`)

**Requires:** radmc3dPy — see `install_reference.md` section 3b if not yet installed.

```python
import radmc3dPy.analyze as ra
import numpy as np

s   = ra.readSpectrum("spectrum.out")
lam = s[:, 0]   # wavelength [μm]
fnu = s[:, 1]   # flux density [Jy] at 1 pc

distance_pc   = 150.0
fnu_scaled    = fnu / distance_pc**2   # [Jy] at source distance
nu            = 3e14 / lam             # frequency [Hz]  (c in μm/s = 3×10¹⁴)
nufnu         = nu * fnu_scaled        # νFν [Jy·Hz = erg/s/cm²]
```

---

## Workflow 3 — Chemical Network Output

**Required files:** `COinitgrid-{name}.dat`, `COendgrid-{name}.chem`

**Helper module:** `examples/example_utils/diskmint_utils.py` — not part of the installed `diskmint` namespace. It lives inside the DiskMINT git repository (`DISKMINT_REPO`), not in the pip-installed package. Add its directory to `sys.path` using the actual repo path from memory:

```python
import sys
# Replace with the value of DISKMINT_REPO from memory
sys.path.append("/your/path/to/DiskMINT/examples/example_utils")
import diskmint_utils as utils
```

When generating this snippet for a user, substitute `DISKMINT_REPO` (stored in memory during Setup Step A) for `/your/path/to/DiskMINT`.

### Step 1 — Load init + end grids

```python
df = utils.read_model(
    chem_save_name    = "mymodel_name",
    data_dir_init     = "output/mymodel_name/",
    data_dir_chemical = "output/mymodel_name/",
    have_CO2          = 'reducedRGH22'
)
```

### Step 2 — Extract 2D arrays

```python
(rr_2D, zrr_2D), (rr_grid, zrr_grid), (tauv_star_2D, tauv_zup_2D), \
nH_2D, Tgas_2D, nH2_2D, nC18O_2D = utils.name_modelpara(df, nr_LIME=215, nz_LIME=200)
```

| Variable | Description |
|---|---|
| `rr_grid`, `zrr_grid` | 2D radius [au] and z/r arrays on the cylindrical chemistry grid |
| `nH_2D` | H nuclei number density [cm⁻³] (from `COinitgrid`) |
| `Tgas_2D` | Gas temperature [K] |
| `tauv_star_2D` | UV optical depth from the star |
| `nC18O_2D` | log₁₀(n_C¹⁸O / n_H) (from `COendgrid`) |

### Step 3 — C¹⁸O luminosities and emitting layer

```python
whole_data = utils.compute_emittinglayer(df, dv_set=0.0, nr=215, nz=200)
# prints C¹⁸O J=2-1 and J=3-2 luminosities in L☉

r_au_2D, z_au_2D, dlum21_2D, dlum32_2D, tauup_CO_2D = \
    utils.read_emittinglayer(wholedata=whole_data, nr=215, nz=200)
```

| Variable | Description |
|---|---|
| `dlum21_2D` | Differential C¹⁸O J=2-1 luminosity per cell [L☉/cell] |
| `dlum32_2D` | Differential C¹⁸O J=3-2 luminosity per cell [L☉/cell] |
| `tauup_CO_2D` | C¹⁸O vertical optical depth from above |

### Step 4 — Diagnostic plot

```python
import matplotlib.pyplot as plt
fig, axes = plt.subplots(1, 4, figsize=(16, 3))
utils.plot_density_emitting_layer(
    fig, axes,
    rr_grid, zrr_grid,
    nH_2D, Tgas_2D, tauv_star_2D, nC18O_2D, dlum21_2D
)
```

Produces a 4-panel plot: H nuclei density, gas temperature, UV optical depth, and C¹⁸O abundance with the J=2-1 emitting layer overlaid.
