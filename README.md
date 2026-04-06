# DiskMINT-Nursery

**An AI agent skill for [DiskMINT](https://github.com/DingshanDeng/DiskMINT) — helping users install, run, and understand thermochemical disk models.**

> [!WARNING]
> **DiskMINT-Nursery is in early development. All features listed below are experimental and subject to change.**

DiskMINT-Nursery is a companion skill for AI agents such as [Claude Code](https://claude.ai/code) and [OpenAI Codex](https://developers.openai.com/codex/cli) that guides users through the full DiskMINT workflow — from first install to scientific results. It works by reading structured reference files from the DiskMINT documentation and using them to navigate and assist in the user's own project.

---

## Features

### 🌱 Feature 1 — Installation & Onboarding
`Status: Experimental`

The skill checks your environment for all required tools, installs what is missing (where no `sudo` is needed), and generates copy-paste commands for anything that requires elevated permissions. It also handles platform-specific issues such as gfortran version requirements and ARM Mac compatibility.

Checks and installs:
- DiskMINT Python package + Fortran chemistry network
- RADMC-3D v2.0
- optool (for dust opacity generation)
- gfortran 10+ (patches `chemistry/src/Makefile` automatically if needed)
- `DISKMINT_BIN_DIR` environment variable

### 🌿 Feature 2 — Runtime Assistant
`Status: Experimental`

The skill answers questions about DiskMINT, helps set up and run models, and interprets outputs. It reads the structured AI reference files from the [DiskMINT documentation](https://diskmint.readthedocs.io/en/latest/AI%20Features/ai_ref_index.html) to ground its answers in the actual code — parameters, file formats, pipeline steps, and known failure modes.

Capabilities:
- Explain and set up parameter CSV files for a new target
- Help configure dust opacities and stellar spectra
- Guide through the VHSE iteration and chemistry network steps
- Interpret model output files and `.chem` abundance grids

### 🍃 Feature 3 — Support Escalation
`Status: Experimental`

When something goes wrong, the skill diagnoses the error against a known error reference, suggests fixes, and — if the problem cannot be resolved automatically — guides the user to collect the right log files and drafts a support email to the DiskMINT author.

---

## Prepared Prompts

A set of ready-to-use prompts for each feature is maintained in the [`prompts/`](prompts/) directory of this repository, and documented in the [DiskMINT AI Features documentation](https://diskmint.readthedocs.io/en/latest/AI%20Features/ai_ref_index.html).

| Prompt file | Feature |
|---|---|
| [`prompts/install_prompts.md`](prompts/install_prompts.md) | Installation & onboarding |
| [`prompts/assistant_prompts.md`](prompts/assistant_prompts.md) | Runtime assistant |
| [`prompts/escalation_prompts.md`](prompts/escalation_prompts.md) | Support escalation |

---

## Installation

> [!WARNING]
> The skill is experimental. Install at your own discretion.

**Prerequisites:** DiskMINT must already be installed and importable (`import diskmint`).

```bash
git clone https://github.com/DingshanDeng/DiskMINT-Nursery.git
cd DiskMINT-Nursery
make install
```

`make install` will:
1. Detect your local DiskMINT installation and find the AI reference files
2. Make the skill available to Claude Code and Codex
3. Copy the skill to `~/.claude/skills/diskmint-nursery/` and `~/.codex/skills/diskmint-nursery/`

If you only want one platform, use `make install-claude` or `make install-codex` instead.

Then restart Claude Code or Codex. The skill activates automatically when you mention DiskMINT.
In Claude Code, you can also invoke it directly with `/diskmint-nursery`.

To remove the skill:
```bash
make uninstall
```

---

## Requirements

- [DiskMINT](https://github.com/DingshanDeng/DiskMINT) installed on your machine
- [Claude Code](https://claude.ai/code)
- [OpenAI Codex](https://developers.openai.com/codex/cli)

---

## Links

- DiskMINT repository: https://github.com/DingshanDeng/DiskMINT
- DiskMINT documentation: https://diskmint.readthedocs.io
- AI Features documentation: https://diskmint.readthedocs.io/en/latest/AI%20Features/ai_ref_index.html
- Issues & feedback: https://github.com/DingshanDeng/DiskMINT-Nursery/issues

---

## Citation

If DiskMINT-Nursery helps your research, please cite the DiskMINT papers:

- [Deng et al. (2025), ApJ 995, 98](https://ui.adsabs.harvard.edu/abs/2025ApJ...995...98D)
- [Deng et al. (2023), ApJ 954, 165](https://ui.adsabs.harvard.edu/abs/2023ApJ...954..165D)
