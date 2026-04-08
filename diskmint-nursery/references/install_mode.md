# Installation Mode — Step-by-Step Procedure

## Step 0 — Collect environment facts (once per machine)

Before running any install commands, make sure you have `DISKMINT_ENV` and `DISKMINT_REPO`
in memory (see Setup → Step A in SKILL.md).

If they are already saved, confirm them with the user:

> "I'll use conda environment **`<DISKMINT_ENV>`** and DiskMINT repo at
> **`<DISKMINT_REPO>`**. Is that correct?"

If not saved yet, ask:

1. *"What conda environment should I use for DiskMINT? (leave blank to create a new one
   called `diskmint_stable`)"*
2. *"Where is the DiskMINT git repository on this machine? (full path, e.g.
   `/home/alice/repos/DiskMINT`)"*

Save both answers to memory as `diskmint_env.md` before continuing.

---

## Step 1 — Run the Checklist

Run each command and report results as a status table:

```bash
python3 -c "import diskmint; print(diskmint.__version__)"
echo $DISKMINT_BIN_DIR
ls $DISKMINT_BIN_DIR/disk_main 2>/dev/null || echo "NOT FOUND"
radmc3d info 2>/dev/null | head -3 || echo "NOT FOUND"
python3 -c "import radmc3dPy; print('radmc3dPy OK')" 2>/dev/null || echo "NOT FOUND"
which optool 2>/dev/null && optool --version || echo "NOT FOUND (optional)"
gfortran --version 2>/dev/null | head -1 || echo "NOT FOUND"
```

| Tool | Status | Notes |
|---|---|---|
| DiskMINT Python | ✅ / ❌ | version |
| DISKMINT_BIN_DIR | ✅ / ❌ | path |
| chemistry binary (disk_main) | ✅ / ❌ | |
| RADMC-3D | ✅ / ❌ | |
| radmc3dPy | ✅ / ❌ | required for SED analysis |
| optool | ✅ / ❌ | optional |
| gfortran | ✅ / ❌ | version number |

---

## Step 2 — Act on Each ❌

### Decision rule
- **No sudo needed** (installing to `~/`, `~/.local/`, conda env, or user-writable path):
  run install commands directly with the Bash tool.
- **Sudo needed** (writing to `/usr/local`, `/usr/bin`, or system paths):
  print the exact commands, explain why sudo is required, and wait for the user to confirm
  before re-checking.

### DiskMINT Python package
```bash
cd YourPath/DiskMINT && make install_python
python3 -c "import diskmint; print('OK')"
```

### Fortran chemistry network + DISKMINT_BIN_DIR

**Check gfortran version first:**
```bash
gfortran --version | head -1
```

**ARM Mac guard:** if output contains `Apple clang` or `Darwin`, warn the user —
that is the system stub. Run `brew install gcc` instead (no sudo needed with Homebrew).

**If version < 10:**
- macOS: `brew install gcc` (no sudo)
- Linux: `sudo apt install gfortran-10` (needs sudo — print and wait)

**After correct gfortran is available**, find the versioned binary:
```bash
which gfortran-13   # or gfortran-12, gfortran-11, gfortran-10 — whatever was installed
```

**Patch the Makefile** using the Edit tool — replace `FC = gfortran` with the versioned
binary (e.g. `FC = gfortran-13`). Do not use sed. This is the **only** file in
`DISKMINT_REPO` that this skill is permitted to edit; show the diff and confirm before
writing.

**Compile:**
```bash
cd YourPath/DiskMINT/chemistry/src
rm -f *.o *.mod        # clear old artifacts
make
```

**Set DISKMINT_BIN_DIR:**
```bash
# Detect shell config file
echo $SHELL   # → /bin/zsh or /bin/bash
# Append to the right file:
echo 'export DISKMINT_BIN_DIR="YourPath/DiskMINT/chemistry/bin"' >> ~/.zshrc   # zsh
# or
echo 'export DISKMINT_BIN_DIR="YourPath/DiskMINT/chemistry/bin"' >> ~/.bashrc  # bash
source ~/.zshrc   # or ~/.bashrc
```

Verify: `ls $DISKMINT_BIN_DIR/disk_main`

### RADMC-3D
```bash
git clone https://github.com/dullemond/radmc3d-2.0.git
cd radmc3d-2.0/src && make
echo 'export PATH="$PATH:/your/path/to/radmc3d-2.0/bin"' >> ~/.zshrc
source ~/.zshrc
radmc3d info
```

### radmc3dPy (Python interface — required for SED analysis)

The `radmc3dPy` package is already inside the RADMC-3D repository cloned above — no extra download needed. Install it into the active conda environment with:

```bash
pip install -e /your/path/to/radmc3d-2.0/python/radmc3dPy
```

Replace `/your/path/to/` with the actual clone path stored in memory as `RADMC3D_PATH` (or ask the user where they cloned RADMC-3D if unknown).

**ARM Mac / Linux note:** radmc3dPy may warn about a missing Fortran Mie module on import — this is harmless, the Python fallback is used automatically.

Verify:
```bash
python3 -c "import radmc3dPy; print('radmc3dPy OK')"
```

### optool (optional)
```bash
git clone https://github.com/cdominik/optool.git
cd optool && make
echo 'export PATH="$PATH:/your/path/to/optool"' >> ~/.zshrc
source ~/.zshrc
optool --version
```

---

## Step 3 — Final Verification

Re-run the full checklist from Step 1. All required items must be ✅ before exiting.
If optool is still ❌ but the user does not need custom opacities, that is acceptable.
