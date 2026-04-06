SKILL_NAME := diskmint-nursery
CLAUDE_SKILL_ROOT ?= $(HOME)/.claude/skills
CODEX_SKILL_ROOT ?= $(HOME)/.codex/skills
SKILL_ROOTS := $(CLAUDE_SKILL_ROOT) $(CODEX_SKILL_ROOT)

.PHONY: all install install-claude install-codex uninstall uninstall-claude uninstall-codex check help

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

## install: Install the DiskMINT-Nursery skill into Claude Code and Codex skill directories
install:
	@$(MAKE) _install SKILL_ROOTS='$(SKILL_ROOTS)'

## install-claude: Install the skill into ~/.claude/skills/
install-claude:
	@$(MAKE) _install SKILL_ROOTS='$(CLAUDE_SKILL_ROOT)'

## install-codex: Install the skill into ~/.codex/skills/
install-codex:
	@$(MAKE) _install SKILL_ROOTS='$(CODEX_SKILL_ROOT)'

_install:
	@echo "--- Installing $(SKILL_NAME) ---"
	@for root in $(SKILL_ROOTS); do \
		mkdir -p "$$root"; \
		cp -r diskmint-nursery "$$root/"; \
		echo "[OK] Skill installed to: $$root/$(SKILL_NAME)"; \
	done
	@echo ""
	@echo "Restart Claude Code or Codex to load the skill."
	@echo "It activates automatically when you mention DiskMINT,"
	@echo "and in Claude Code you can also invoke it directly with: /diskmint-nursery"

## uninstall: Remove the skill from Claude Code and Codex skill directories
uninstall:
	@$(MAKE) _uninstall SKILL_ROOTS='$(SKILL_ROOTS)'

## uninstall-claude: Remove the skill from ~/.claude/skills/
uninstall-claude:
	@$(MAKE) _uninstall SKILL_ROOTS='$(CLAUDE_SKILL_ROOT)'

## uninstall-codex: Remove the skill from ~/.codex/skills/
uninstall-codex:
	@$(MAKE) _uninstall SKILL_ROOTS='$(CODEX_SKILL_ROOT)'

_uninstall:
	@echo "--- Removing $(SKILL_NAME) ---"
	@for root in $(SKILL_ROOTS); do \
		rm -rf "$$root/$(SKILL_NAME)"; \
		echo "[OK] Removed: $$root/$(SKILL_NAME)"; \
	done

## help: Show available targets
help:
	@grep -E '^## ' Makefile | sed 's/## /  make /'
