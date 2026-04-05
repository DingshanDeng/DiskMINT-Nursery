SKILL_NAME := diskmint-nursery
SKILL_DIR  := $(HOME)/.claude/skills/$(SKILL_NAME)

.PHONY: all install uninstall check help

all: check install

## check: Verify DiskMINT is importable and AI Features docs exist
check:
	@echo "--- Checking DiskMINT installation ---"
	@python3 -c "import diskmint" 2>/dev/null \
		&& echo "[OK] DiskMINT importable" \
		|| (echo "[FAIL] Cannot import diskmint. Install DiskMINT first:"; \
		    echo "       https://github.com/DingshanDeng/DiskMINT"; exit 1)
	@python3 -c "\
import diskmint, os; \
ref = os.path.join(os.path.dirname(os.path.dirname(diskmint.__file__)), 'docs', 'source', 'AI Features'); \
exit(0) if os.path.isdir(ref) else exit(1)" 2>/dev/null \
		&& echo "[OK] AI Features docs found" \
		|| (echo "[WARN] AI Features docs not found in your DiskMINT install."; \
		    echo "       The skill will still install but may not find reference files."; \
		    echo "       Update DiskMINT to a version that includes AI Features docs.")
	@echo "--- Check done ---"

## install: Install the DiskMINT-Nursery skill into ~/.claude/skills/
install:
	@echo "--- Installing $(SKILL_NAME) ---"
	@mkdir -p "$(HOME)/.claude/skills"
	@cp -r diskmint-nursery "$(HOME)/.claude/skills/"
	@echo "[OK] Skill installed to: $(SKILL_DIR)"
	@echo ""
	@echo "Restart Claude Code to load the skill."
	@echo "It activates automatically when you mention DiskMINT,"
	@echo "or invoke it directly with: /diskmint-nursery"

## uninstall: Remove the skill from ~/.claude/skills/
uninstall:
	@echo "--- Removing $(SKILL_NAME) ---"
	@rm -rf "$(SKILL_DIR)"
	@echo "[OK] Removed: $(SKILL_DIR)"

## help: Show available targets
help:
	@grep -E '^## ' Makefile | sed 's/## /  make /'
