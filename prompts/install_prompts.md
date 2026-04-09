# Installation & Onboarding Prompts

Prepared prompts for **Feature 1 — Installation & Onboarding**.
Copy a prompt into your AI assistant (Claude Code, Codex, etc.) to get guided help setting up your DiskMINT environment.

---

## P-I-1 — First-time install on a new machine

```
I want to install DiskMINT on this machine for the first time.
Please check my environment and install everything I need —
conda, the DiskMINT Python package and Fortran chemistry network,
RADMC-3D, gfortran, and optool.
```

---

## P-I-2 — Verify an existing install

```
I already have DiskMINT installed. Please run through the full
environment check and tell me if anything is missing or broken.
```

---

## P-I-3 — Setting up DiskMINT on an HPC cluster

```
I want to set up DiskMINT on a Linux HPC cluster where I do not
have sudo access. Please walk me through a user-level install of
conda, the DiskMINT Python package, the Fortran chemistry network,
and RADMC-3D.
```

---

## P-I-4 — Fix a broken chemistry network

```
My DiskMINT chemistry network is not working. The binary
disk_main is missing or DISKMINT_BIN_DIR is not set.
Please check my gfortran version, patch the Makefile if needed,
recompile the network, and set DISKMINT_BIN_DIR correctly.
```

---

## P-I-5 — Fix a broken gfortran / ARM Mac

```
I am on an Apple Silicon Mac and gfortran is not working correctly
for DiskMINT. Please diagnose whether I have the system stub or
a real gfortran, install the correct version if needed, and make
sure the chemistry network compiles.
```
