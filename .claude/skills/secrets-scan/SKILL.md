---
name: secrets-scan
description: Scan staged git changes for real IPs, hostnames, usernames, or private keys before committing. Use before every commit in this repo, or when asked to check for leaked secrets.
---

# Secrets Scan

This repo's hard rule (see CLAUDE.md): no IP, hostname, user, or key gets
committed.

1. Run the bundled script:
   ```
   bash .claude/skills/secrets-scan/scan.sh
   ```
2. It scans `git diff --cached` (staged changes), skipping `*.example` files,
   for IPv4 addresses, `ansible_host`/`ansible_user` assignments, and private
   key headers.
3. If it reports matches, show them to the user and do not proceed with the
   commit until each one is either confirmed as a safe placeholder (e.g. an
   `.example` file, or a documentation IP already covered by the script's
   exclusion) or removed/replaced with a placeholder.
4. If it reports clean, proceed with the commit as normal.
