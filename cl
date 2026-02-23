#!/usr/bin/env bash
set -euo pipefail

# Launch Claude Code, optionally in a specific directory.
#   cl [dir]         - start claude in dir (or current dir)
#   cl -y [dir]      - start claude with --dangerously-skip-permissions
#   cly [dir]        - same as cl -y (when invoked as cly)

bypass_permissions=false

# If invoked as "cly", enable bypass mode
if [[ "$(basename "$0")" == "cly" ]]; then
  bypass_permissions=true
fi

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -y) bypass_permissions=true; shift ;;
    *)  break ;;
  esac
done

dir="${1:-.}"
dir="$(cd "$dir" 2>/dev/null && pwd || echo "$dir")"

cd "$dir"

if $bypass_permissions; then
  exec claude --dangerously-skip-permissions
else
  exec claude
fi
