---
name: research-init
description: Initialize a new research topic directory. Use when the user wants to start a new research topic. Creates the topic folder, state.json snapshot file, and log.jsonl append-only log under /home/john/research/.
license: MIT
metadata:
    skill-author: John
---

# research-init

Scaffolds a new research topic directory under `/home/john/research/`.

## When to Use

When the user wants to begin a new research topic that does not yet have a directory.

## Usage

```bash
TOPIC="<topic-name>"  # short, lowercase, hyphenated
RESEARCH_ROOT="/home/john/research"
TOPIC_DIR="$RESEARCH_ROOT/$TOPIC"
TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)

mkdir -p "$TOPIC_DIR"

cat > "$TOPIC_DIR/state.json" << EOF
{
  "topic": "$TOPIC",
  "created": "$TS",
  "last_updated": "$TS",
  "current_hypothesis": null,
  "open_questions": [],
  "tried": [],
  "blockers": [],
  "next_steps": []
}
EOF

touch "$TOPIC_DIR/log.jsonl"

echo "Initialized: $TOPIC_DIR"
```

After running, work from within the topic directory so hooks and skills operate correctly.
