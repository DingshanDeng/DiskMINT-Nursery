# Runtime Assistant Prompts

Prepared prompts for **Feature 2 — Runtime Assistant**.
Copy a prompt into your AI assistant (Claude Code, Codex, etc.) to get help running
and interpreting DiskMINT models.

---

## P-A-1 — Run my first DiskMINT model (new user)

```
I am new to DiskMINT and want to run my very first model.
Please help me set up and run the simple example that ships
with the DiskMINT repository, explain each section of the
script so I understand what it does, and tell me what output
files to expect.
```

---

## P-A-2 — Run my first DiskMINT model (advanced user)

```
I am comfortable with Python and want to set up a first
DiskMINT model run. Please help me build a run script with
a command-line interface, walk me through the key parameter
choices, and set up logging so I can track the run.
```

---

## P-A-3 — Set up a parameter CSV for a new target

```
I want to set up a DiskMINT parameter CSV for a new protoplanetary
disk target. Please walk me through the key parameters I need to
set (stellar properties, disk mass, characteristic radius, dust
opacities, boolean flags), explain what each controls, and help
me write the CSV file.
```

---

## P-A-4 — Explain a parameter

```
What does the DiskMINT parameter [PARAMETER NAME] control?
What are typical values, valid range, and what other parameters
does it interact with?
```

*Replace `[PARAMETER NAME]` with the parameter you want to understand,
for example `visc_alpha`, `ratio_g2d_global`, `n_vhse_loop`, or `nphot`.*

---

## P-A-5 — Configure dust opacities

```
I want to configure dust opacities for my DiskMINT model.
I don't have custom grain files — please explain the two options
(DSHARP pre-computed files vs. optool) and help me set up
whichever is appropriate for my case.
```

---

## P-A-6 — VHSE not converging

```
My DiskMINT VHSE iterations are not converging. I have set
n_vhse_loop to [N] but the density structure keeps changing.
Please check my grid resolution, photon count, and VHSE
settings, and suggest what to adjust.
```

*Replace `[N]` with your current loop count.*

---

## P-A-7 — Load and plot thermal / density structure

```
My DiskMINT model run finished. Please help me load and
plot the dust and gas temperature structure and the gas
surface density profile from the output files.
```

---

## P-A-8 — Load and plot C18O abundance from a .chem file

```
I have a DiskMINT .chem output file and want to visualise
the C18O and H2 abundance structure. Please help me load
the file and produce a 2D abundance map.
```

---

## P-A-9 — Compute and plot C18O luminosities and emitting layer

```
I want to compute the C18O J=2-1 and J=3-2 luminosities
from my DiskMINT chemical network output and plot the
emitting layer. Please walk me through the full analysis
workflow using diskmint_utils.
```

---

## P-A-10 — Load and plot the SED

```
My DiskMINT model produced a spectrum.out file. Please help
me load it with radmc3dPy, scale it to my source distance,
and plot the SED as nuFnu vs wavelength.
```
