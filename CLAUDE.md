# Research Repository

This is the main research repository. Each research topic is a subfolder in the root.
Archived topics are moved to `archived/`.

## Structure

```
research/
├── CLAUDE.md
├── archived/
├── topic-a/
│   ├── state.json   # current snapshot — always load before working
│   ├── log.jsonl    # append-only chronological log
│   └── ...          # topic-specific files, free-form
└── topic-b/
    └── ...
```

## Research Principles

1. **Never assert facts without grounding in a tool call result.** Do not rely on pre-trained knowledge to answer research questions. Always web search, read a file, run code, or query an API first.

2. **Always run `research-status` before beginning work on a topic.** The session-start hook will inject context automatically, but explicitly orient yourself before taking any action.

3. **Always write a `research-log` entry before ending a session.** The session-end hook enforces this — a `session_summary` entry is required. Update `state.json` fields (`current_hypothesis`, `open_questions`, `tried`, `next_steps`) to reflect the current state.

## Skills

| Skill | When to use |
|-------|-------------|
| `research-init` | Starting a new topic |
| `research-status` | Orienting at session start or mid-session |
| `research-log` | After every significant action; required before stopping |
| `research-report` | Generating human-readable output on demand |

## Hooks

- **Session start** (`UserPromptSubmit`): injects `state.json` + last 20 log entries if in a topic dir
- **Session end** (`Stop`): blocks stop if no log entry written for current session

## Utilities

Useful repos cloned at `~/utilities/`:

| Repo | Description |
|------|-------------|
| `claude-scientific-skills` | 170+ scientific/research skills for Claude Code |
