---
name: research-log
description: Append a structured log entry to the active research topic and update state.json. Run after every significant research action and always before ending a session.
license: MIT
metadata:
    skill-author: John
---

# research-log

Appends a JSONL entry to `log.jsonl` and updates `state.json`.

## When to Use

- After every significant research action (search, experiment, reading, API call, finding)
- Before ending a session — a `session_summary` entry is required by the session-end hook

## Entry Types

| type | use when |
|------|----------|
| `web_search` | searched the web |
| `code_run` | executed code or ran an experiment |
| `paper_read` | read a paper, doc, or source |
| `api_call` | queried an external API or database |
| `hypothesis` | formed or updated a hypothesis |
| `finding` | reached a significant conclusion |
| `dead_end` | confirmed an approach doesn't work |
| `session_summary` | end-of-session summary (required before stopping) |

## Usage

```bash
SESSION_ID=$(cat .session 2>/dev/null || echo "unknown")
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Append log entry (fill in the fields)
echo "{\"session_id\":\"$SESSION_ID\",\"ts\":\"$TS\",\"type\":\"<type>\",\"summary\":\"<what you did>\",\"outcome\":\"<what you found>\",\"follow_up\":\"<next question or null>\"}" >> log.jsonl

# Update last_updated in state.json (also update other fields as appropriate)
python3 -c "
import json
with open('state.json') as f: s = json.load(f)
s['last_updated'] = '$TS'
# Modify s fields as needed before writing:
# s['current_hypothesis'] = '...'
# s['open_questions'] = [...]
# s['tried'].append('...')
# s['blockers'] = [...]
# s['next_steps'] = [...]
with open('state.json', 'w') as f: json.dump(s, f, indent=2)
"
```

## state.json Fields to Keep Current

- `current_hypothesis` — update whenever your working theory changes
- `open_questions` — add new questions, remove answered ones
- `tried` — append a brief string per approach attempted (high-level, detail is in the log)
- `blockers` — replace with current blockers; clear when resolved
- `next_steps` — replace with current planned actions

## Auto-Report on Session End

When writing a `session_summary` entry, **always** run the `research-report` skill immediately after, unless the user explicitly generated a report already in this session. This ensures a fresh `report.md` is always committed alongside the log.
