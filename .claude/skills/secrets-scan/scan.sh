#!/usr/bin/env bash
set -euo pipefail

diff=$(git diff --cached --unified=0 -- . ':!*.example' ':!.claude/**')

if [ -z "$diff" ]; then
  echo "No staged changes to scan."
  exit 0
fi

added=$(echo "$diff" | grep -E '^\+' | grep -vE '^\+\+\+')

found=0

check() {
  local label="$1"
  local pattern="$2"
  local matches
  matches=$(echo "$added" | grep -inE "$pattern" || true)
  if [ -n "$matches" ]; then
    echo "=== $label ==="
    echo "$matches"
    found=1
  fi
}

# IPv4 addresses, excluding documentation/test ranges (RFC 5737 + example placeholders)
check "Possible IP address" '([0-9]{1,3}\.){3}[0-9]{1,3}'
check "ansible_host / real hostname assignment" 'ansible_host\s*[:=]'
check "Private key header" 'BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY'
check "ansible_user assignment" 'ansible_user\s*[:=]'

if [ "$found" = "1" ]; then
  echo
  echo "Review the matches above. Documentation/example IPs (192.0.2.0/24, 198.51.100.0/24, 203.0.113.0/24) and *.example files are expected to be clean; anything else should not be committed."
  exit 1
fi

echo "No obvious secrets/real host data found in staged changes."
