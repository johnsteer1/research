---
name: research-report
description: Generate a human-readable markdown report from the active research topic. Use when the user wants to review, share, or export research findings.
license: MIT
metadata:
    skill-author: John
---

# research-report

Renders a human-readable markdown report from `state.json` and `log.jsonl`.

## When to Use

When the user wants a readable summary or export of the research topic. This is a derived artifact — the source of truth is always `state.json` + `log.jsonl`.

## Usage

First, load the full research data:

```bash
echo "=== STATE ==="
cat state.json
echo ""
echo "=== FULL LOG ==="
cat log.jsonl
```

Then generate a markdown report with these sections:

1. **Topic & Status** — topic name, created, last updated
2. **Current Hypothesis** — working hypothesis
3. **Key Findings** — entries with `type: finding`
4. **Approaches Tried** — from the `tried` array + `type: dead_end` entries
5. **Open Questions** — current open questions
6. **Next Steps** — planned next actions
7. **Session Timeline** — one paragraph per session ID summarizing the arc

Always save the report:

```bash
cat > report.md << 'EOF'
<generated report here>
EOF
echo "Saved to report.md"
```

Then commit and push:

```bash
TOPIC=$(basename "$PWD")
cd "$(git rev-parse --show-toplevel)"
git add -A
git commit -m "research($TOPIC): report updated [$(date -u +%Y-%m-%dT%H:%M:%SZ)]" --no-gpg-sign 2>/dev/null || \
git commit -m "research($TOPIC): report updated [$(date -u +%Y-%m-%dT%H:%M:%SZ)]"
git push &
```
