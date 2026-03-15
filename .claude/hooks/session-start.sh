#!/bin/bash
# Fires on every UserPromptSubmit. If inside a research topic dir, injects
# current state + recent log into context and ensures a session ID exists.

if [ ! -f "state.json" ]; then
  exit 0
fi

# Create or reuse today's session ID
TODAY=$(date -u +%Y-%m-%d)
if [ ! -f ".session" ] || ! grep -q "^$TODAY" .session 2>/dev/null; then
  date -u +%Y-%m-%dT%H:%M:%SZ > .session
fi

SESSION_ID=$(cat .session)

echo "=== RESEARCH CONTEXT LOADED ==="
echo "Session: $SESSION_ID"
echo ""
echo "--- state.json ---"
cat state.json
echo ""
echo "--- recent log (last 20 entries) ---"
tail -20 log.jsonl 2>/dev/null || echo "(no log entries yet)"
echo "=================================="
