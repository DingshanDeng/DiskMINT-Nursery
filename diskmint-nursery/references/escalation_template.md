# Support Escalation — Procedure and Email Template

## Step 1 — Collect Environment Info

Run these commands and save the output:

```bash
python3 -c "import diskmint; print(diskmint.__version__)"
uname -a
python3 --version
gfortran --version | head -1
radmc3d info | head -5
echo $DISKMINT_BIN_DIR
```

Also collect:
- The full error message (ask the user to paste it if not already visible)
- The parameter CSV file for the failing model
- Last 50 lines of the RADMC-3D log (usually `radmc3d.out` or similar in the model directory)
- Last 50 lines of the chemistry log (usually `chemistry_run.log` or printed to stdout)

---

## Step 2 — Draft the Support Email

```
To: dingshandeng@gmail.com
Subject: DiskMINT support request — [one-line description of the error]

Hi Dingshan,

I am encountering the following issue with DiskMINT:

--- ERROR MESSAGE ---
[paste the full error here]
---------------------

Environment:
- DiskMINT version : [output of diskmint.__version__]
- Platform         : [uname -a output]
- Python           : [python3 --version]
- gfortran         : [gfortran --version]
- RADMC-3D         : [radmc3d info first line]
- DISKMINT_BIN_DIR : [echo $DISKMINT_BIN_DIR]

What I was doing:
[brief description of the step that failed]

Attached:
- parameter CSV (pasted below or as attachment)
- relevant log excerpts (pasted below)

--- PARAMETER CSV ---
[paste contents here]
---------------------

--- LOG EXCERPT ---
[paste last 50 lines here]
------------------

Thank you,
[user name]
```

---

## Step 3 — Review Before Sending

Show the complete draft to the user. Ask them to:
1. Confirm the error description in the subject line is accurate
2. Fill in their name at the bottom
3. Attach or paste the parameter CSV and log if not already included

Do not send on the user's behalf — present the draft for them to copy and send manually.
