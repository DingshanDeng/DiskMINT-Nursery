# Support Escalation Prompts

Prepared prompts for **Feature 3 — Support Escalation**.
Copy a prompt into your AI assistant (Claude Code, Codex, etc.) when something goes
wrong and you need help diagnosing an error or contacting the DiskMINT author.

---

## P-E-1 — Diagnose an error I cannot fix

```
I am getting the following error running my DiskMINT model and
I cannot resolve it:

[PASTE ERROR MESSAGE OR LOG HERE]

Please check the error reference, suggest fixes, and try to
resolve this step by step.
```

*Replace the bracketed text with the actual error message or the
contents of your model log file.*

---

## P-E-2 — Draft a support email to the DiskMINT author

```
I have an unresolved error with DiskMINT that I cannot fix.
Please collect my full environment details (DiskMINT version, OS,
gfortran version, conda environment, error log), then draft a
support email to the DiskMINT author at dingshandeng@gmail.com
with everything needed to reproduce the issue.
```

---

## P-E-3 — Format a GitHub issue report

```
I want to open a GitHub issue for a DiskMINT bug. Please collect
my environment details and error log, then format everything as a
well-structured GitHub issue report I can paste into
https://github.com/DingshanDeng/DiskMINT/issues/new
```
