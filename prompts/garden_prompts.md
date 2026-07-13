# DiskMINT-GARDEN Prompts

Prepared prompts for **Feature 4 — DiskMINT-GARDEN ML Inference**.
Copy a prompt into your AI assistant (Claude Code, Codex, etc.) to get a fast disk-property
estimate from observed fluxes, without running a full model.

---

## P-G-1 — Estimate disk properties from observed fluxes

```
I have ALMA continuum and C18O flux measurements for a disk and want a
quick estimate of gas mass, dust mass, gas-to-dust ratio, and characteristic
radius using DiskMINT-GARDEN. My values are:
- continuum flux density: [VALUE] mJy
- C18O integrated flux: [VALUE] mJy km/s
- distance: [VALUE] pc
- stellar mass: [VALUE] Msun
- 90% dust radius: [VALUE] au
- band: [band6 or band7]
```

---

## P-G-2 — Run inference on a table of sources

```
I have a table of disk sources with continuum flux, C18O flux, distance,
stellar mass, and dust radius columns. Please help me run DiskMINT-GARDEN
inference on the whole table with infer.from_dataframe() and flag any
sources that fall outside the training grid domain.
```

---

## P-G-3 — Set up the GARDEN dependencies

```
I want to use DiskMINT-GARDEN for ML-based disk property inference but
haven't installed the optional dependencies yet. Please check what's
missing and install them.
```
