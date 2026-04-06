# Getting Started — First-Time Guide

This guide is for users who are new to DiskMINT, new to AI-assisted coding, or both.
It explains what this skill does, how agentic coding assistants work, and how to start a
DiskMINT project from scratch.

---

## What is this skill?

DiskMINT-Nursery is a skill — a set of structured instructions — loaded into an AI coding
assistant such as [Claude Code](https://claude.ai/code) or
[OpenAI Codex CLI](https://github.com/openai/codex). When you mention DiskMINT, the
assistant automatically reads these instructions and acts as a DiskMINT expert: it knows
the parameters, file formats, install steps, and common failure modes. It looks things up
from the actual DiskMINT documentation rather than guessing.

---

## What is an AI coding assistant?

An AI coding assistant is a program you run in your terminal. You have a conversation with
it — describe what you want to do, ask questions, report errors — and it reads and edits
files, runs shell commands, and walks you through complex workflows alongside you.

Two popular choices that support this skill:

| Assistant | Website |
|---|---|
| Claude Code | https://claude.ai/code |
| OpenAI Codex CLI | https://github.com/openai/codex |

Install either one according to the instructions on their official pages, then come back
here. Once installed, you start the assistant from the command line inside your project
folder.

---

## What is a "skill"?

A skill is a file (or folder of files) that tells the assistant how to handle a specific
domain. For Claude Code, skills live in `~/.claude/skills/` and are loaded automatically.
You invoke this one by typing `/diskmint-nursery` in the chat, or simply by mentioning
"DiskMINT" in your message.

Other agents have equivalent mechanisms — refer to their documentation for how to install
and invoke skills or plugins.

You do not need to understand the internals of the skill to use it. Just talk to the
assistant naturally about DiskMINT.

---

## How memory works

The assistant can store facts between sessions using a memory system. For this skill, it
saves two key facts the first time you set up DiskMINT:

- **Your conda environment name** (e.g. `diskmint_stable`, or whatever you choose)
- **The path to your DiskMINT git repository** (e.g. `/home/alice/repos/DiskMINT`)

These are saved to a small file called `diskmint_env.md` in the project memory directory.
After the first session the assistant remembers them automatically — you will not be asked
again.

If you ever move the repo or switch environments, just tell the assistant:
> "I moved DiskMINT to `/new/path` and renamed the conda env to `myenv`."
It will update the memory file.

---

## Starting a new DiskMINT project — step by step

### 1. Install an AI coding assistant
Follow the official install guide for Claude Code or Codex CLI (links above).

### 2. Install DiskMINT (if not already done)
If you have not installed DiskMINT yet, create a project folder, open the assistant CLI
inside it, and tell it:
> "Help me install DiskMINT from scratch."

The assistant will activate the Installation & Onboarding mode and walk you through every
step — conda environment, Python package, Fortran chemistry binary, RADMC-3D, and
gfortran.

### 3. Create your working directory and open the assistant
```bash
mkdir my_disk_model
cd my_disk_model
claude          # or: codex
```

### 4. Invoke this skill and describe your science target
Once the assistant is running, type:
```
/diskmint-nursery help me set up a model for RU Lup
```

The assistant will:
1. Ask for your conda env name and DiskMINT repo path (once, then save to memory)
2. Read the DiskMINT parameter reference
3. Walk you through creating a parameter CSV for your target

### 5. Run the model and interpret output
Once your setup is ready, the assistant can help you run the model and check results:
```
what does the output look like for a run I just finished in ./output_RULup/?
```

---

## Safety rules for this skill

The assistant will **never**:
- Edit files inside the installed `diskmint` Python package
- Edit files in your DiskMINT git repository, *except* the chemistry `Makefile` when a
  compiler fix is needed (and only after showing you the diff and asking for confirmation)
- Run `sudo` commands on your behalf — it will print them for you to run yourself
- Change your parameter CSV without showing you a diff first

If you are the DiskMINT developer and want to improve the package with the assistant's
help, say: *"I am the DiskMINT developer — enable developer mode for this session."*

---

## Useful links

| Resource | URL |
|---|---|
| Claude Code | https://claude.ai/code |
| OpenAI Codex CLI | https://github.com/openai/codex |
| DiskMINT repository | https://github.com/DingshanDeng/DiskMINT |
| DiskMINT documentation | https://diskmint.readthedocs.io |
| DiskMINT AI Features docs | https://diskmint.readthedocs.io/en/latest/AI%20Features/ai_ref_index.html |
| DiskMINT-Nursery repository | https://github.com/DingshanDeng/DiskMINT-Nursery |
