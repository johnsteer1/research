---
name: research-status
description: Load the current state of the active research topic to orient the agent. Run at the start of every session and any time re-orientation is needed mid-session.
license: MIT
metadata:
    skill-author: John
---

# research-status

Loads state.json and recent log entries to orient the agent for the current research topic.

## When to Use

- At the start of every research session (also enforced by the session-start hook)
- Any time re-orientation is needed mid-session

## Usage

Run from within the topic directory:

```bash
echo "=== STATE ==="
cat state.json
echo ""
echo "=== RECENT LOG (last 20 entries) ==="
tail -20 log.jsonl 2>/dev/null || echo "(no entries yet)"
echo ""
echo "=== SESSION ID ==="
cat .session 2>/dev/null || echo "(no active session)"
```

## Searching Older Log Entries

```bash
# All entries of a specific type
grep '"type":"web_search"' log.jsonl

# Entries mentioning a keyword
grep -i "keyword" log.jsonl

# All entries from a specific session
grep "2026-03-15" log.jsonl

# Count entries by type
cat log.jsonl | python3 -c "
import sys, json
from collections import Counter
types = Counter(json.loads(l)['type'] for l in sys.stdin if l.strip())
print(types)
"
```
