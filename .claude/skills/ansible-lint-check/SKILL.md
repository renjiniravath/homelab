---
name: ansible-lint-check
description: Run ansible-lint across the whole playbooks/ and roles/ tree and report violations. Use before committing Ansible changes, or when asked to check/lint the playbooks or roles.
---

# Ansible Lint Check

Run a full-repo lint pass, not just the single-file check the PostToolUse hook
already does on every edit.

1. Run:
   ```
   PYTHONWARNINGS=ignore uvx ansible-lint --nocolor -f pep8 playbooks roles
   ```
2. If there is no output, report that the tree is clean.
3. If there are violations, list them grouped by file, then fix them one at a
   time, incrementally, re-running the command after each fix to confirm it is
   resolved before moving to the next.
4. Do not suppress or disable a rule to make a violation disappear unless the
   user explicitly asks for that — fix the underlying playbook/role instead.
