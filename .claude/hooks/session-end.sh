#!/bin/bash
# Fires on Stop. Blocks stopping if inside a research topic dir and no
# log entry has been written for the current session.
# On successful exit, auto-commits and pushes all research changes.

if [ ! -f "state.json" ] || [ ! -f ".session" ]; then
  exit 0
fi

SESSION_ID=$(cat .session)

if ! grep -q "\"session_id\":\"$SESSION_ID\"" log.jsonl 2>/dev/null; then
  echo "BLOCKED: No research-log entry found for session $SESSION_ID."
  echo "Run research-log (type: session_summary) before ending this session."
  exit 1
fi

# Auto-commit and push all research changes
TOPIC=$(basename "$PWD")
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)

cd "$(git rev-parse --show-toplevel)" 2>/dev/null || exit 0

if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  exit 0
fi

git add -A
git commit -m "research($TOPIC): session $SESSION_ID [$TS]" --no-gpg-sign 2>/dev/null || \
git commit -m "research($TOPIC): session $SESSION_ID [$TS]" 2>/dev/null

git push 2>/dev/null &

exit 0
