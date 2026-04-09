# DiskMINT-Nursery

**An AI agent skill for [DiskMINT](https://github.com/DingshanDeng/DiskMINT) — helping users install, run, and understand thermochemical disk models.**

> [!WARNING]
> **DiskMINT-Nursery is in early development. All features listed below are experimental and subject to change.**

DiskMINT-Nursery is a companion skill for AI agents such as [Claude Code](https://claude.ai/code) and [OpenAI Codex](https://developers.openai.com/codex/cli) that guides users through the full DiskMINT workflow — from first install to scientific results. It works by reading structured reference files from the DiskMINT documentation and using them to navigate and assist in the user's own project.

DiskMINT-Nursery works the best with the command line interface (CLI).

> [!TIP]
> A useful link for students/educators is the [GitHub Edication](https://github.com/education), where you can register and have access (free as in March 2026) to [GitHub Copilot](https://github.com/features/copilot/cli) that provide access to the latest models by both Claude and Codex.

---

DiskMINT-Nursery is described inside the DiskMINT [Documentation](https://diskmint.readthedocs.io/en/latest/). Check the `AI Features` section in the documentation for more information.

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

```bash
git clone https://github.com/DingshanDeng/DiskMINT-Nursery.git
cd DiskMINT-Nursery
make install
```

> [!TIP]
> You can open your agent CLI inside the cloned repo, 
> and just ask your code agent to install the DiskMINT-Nursery skill
> say something like "Install DiskMINT-Nursery that is inside this repo"

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

- An code agent with a command line interface (CLI), for example:
  - [Claude Code](https://claude.ai/code)
  - [OpenAI Codex](https://developers.openai.com/codex/cli)
  - [GitHub Copilot CLI](https://github.com/features/copilot/cli)
- Preferred: A integrated development environment (IDE) that can work well with the agent CLI, for example:
  - [Visual Studio Code](https://code.visualstudio.com/)
  - [JupyterLab](https://jupyter.org/install) with Jupyter AI extension (https://github.com/jupyterlab/jupyter-ai)
  - [Cursor](https://www.cursor.com/)

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
