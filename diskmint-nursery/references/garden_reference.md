# GARDEN Reference

Reference for DiskMINT-GARDEN, DiskMINT's predict-only machine-learning inference API for
estimating disk properties from observed fluxes. Available since DiskMINT v1.7.0.

Unlike a full DiskMINT model run, GARDEN does not call RADMC-3D or the Fortran chemistry
network — it loads a bundled XGBoost surrogate trained on the DiskMINT-GARDEN model grid
and predicts physical parameters directly from observed continuum and $\mathrm{C^{18}O}$
fluxes.

---

## When To Use

Activate this mode when the user wants a **fast estimate** of disk gas mass, dust mass,
gas-to-dust ratio, or characteristic radius from **observed fluxes** — not from running a
model. If the user wants to run a full thermochemical model instead, use Mode 2 (Runtime
Assistant).

---

## Install

GARDEN dependencies are optional and separate from the core DiskMINT install:

```bash
pip install "diskmint[garden]"
```

This adds `pandas`, `astropy`, `scikit-learn`, `xgboost`, and `joblib`. If the user hits an
`ImportError` or `GardenDependencyError` mentioning these packages when calling
`diskmint.garden.infer`, this is the fix — no RADMC-3D, gfortran, or optool setup is needed.

---

## Required Observed Inputs

| Input | Units | Description |
|---|---|---|
| `flux_mm` | mJy | Millimeter continuum flux density |
| `flux_c18o` | mJy km/s | $\mathrm{C^{18}O}$ integrated line flux |
| `distance` | pc | Source distance |
| `mstar` | M_sun | Stellar mass |
| `rdust_90` | au | 90 percent dust radius |
| `band` | — | `"band6"` ($\mathrm{C^{18}O}$ J=2-1) or `"band7"` ($\mathrm{C^{18}O}$ J=3-2) |

The default continuum wavelength is 1.3 mm; pass `wavelength=` or `frequency=` to override.

---

## Single-Target Inference

```python
import diskmint.garden.infer as infer

result = infer.from_observations(
    flux_mm=120.0,
    flux_c18o=850.0,
    distance=140.0,
    mstar=0.8,
    rdust_90=80.0,
    band="band6",
)

print(result["Mgas_pred_Msun"], result["gtd_pred_dimless"], result["Rc_pred_au"])
```

## Table Inference

```python
import diskmint.garden.infer as infer

result_df = infer.from_dataframe(
    observations_df,
    band="band6",
    continuum_flux_col="flux_mm_mjy",
    c18o_flux_col="flux_c18o_mjy_kms",
    distance_col="distance_pc",
    mstar_col="mstar_msun",
    rdust_col="Rdust_90_au",
)
```

Returned columns: `Mgas_pred_Msun`, `Mdust_pred_Msun`, `gtd_pred_dimless`, `Rc_pred_au`,
`is_outside_grid`, `outside_features`, `nn_dist`.

---

## Domain Check — Always Report This

Every prediction includes a grid-domain diagnostic:

- `is_outside_grid` — `True` if any input feature falls outside the training domain
- `outside_features` — which feature(s) triggered the flag
- `nn_dist` — distance to the nearest training point

**If `is_outside_grid` is `True`, tell the user explicitly**: the prediction is an
extrapolation and should not be treated as a precise physical constraint. Never present a
flagged prediction as equivalent to an in-domain one.

---

## Bundled Models

| Model | Line | Validation |
|---|---|---|
| `band6` | $\mathrm{C^{18}O}$ J=2-1 | test R² ≈ 0.9824 |
| `band7` | $\mathrm{C^{18}O}$ J=3-2 | test R² ≈ 0.9835 |

---

## Example

See `$DISKMINT_REPO/examples/example_diskmint_garden/` for a runnable script
(`run_garden_example.py`) and an annotated notebook (`diskmint_garden_quickstart.ipynb`).
