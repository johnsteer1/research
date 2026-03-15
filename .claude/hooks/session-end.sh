#!/bin/bash
# Fires on Stop. Blocks stopping if inside a research topic dir and no
# log entry has been written for the current session.

if [ ! -f "state.json" ] || [ ! -f ".session" ]; then
  exit 0
fi

SESSION_ID=$(cat .session)

if ! grep -q "\"session_id\":\"$SESSION_ID\"" log.jsonl 2>/dev/null; then
  echo "BLOCKED: No research-log entry found for session $SESSION_ID."
  echo "Run research-log (type: session_summary) before ending this session."
  exit 1
fi

exit 0
