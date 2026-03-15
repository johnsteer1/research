# Hermes Agent — Research Report

**Topic:** hermes-agent
**Created:** 2026-03-15
**Last Updated:** 2026-03-15
**Source:** NousResearch/hermes-agent (MIT, Python)

---

## Current Hypothesis

Hermes-agent is differentiated by autonomous persistent skill creation, multi-level cross-session memory, multi-platform gateway deployment, and RL/training integration — a combination not found in any other single framework.

---

## What Is Hermes Agent?

Hermes Agent is an open-source, self-hosted autonomous AI agent built by **Nous Research** (creators of the Hermes model family). Its tagline is *"The agent that grows with you."*

It is not a coding copilot tethered to an IDE or a chatbot wrapper around an API. It runs as a persistent server process, accumulates memory across sessions, autonomously creates and refines procedural skills, and can be deployed on a $5 VPS or serverless infrastructure. The latest release is **v0.2.0** (tagged `v2026.3.12`, March 12, 2026), representing 216 merged PRs from 63 contributors.

---

## Key Use Cases

| Use Case | Description |
|---|---|
| **Developer automation** | Parallel subagent spawning, file management, GitHub workflow automation, incremental feature development on long-running codebases |
| **Personal AI assistant** | Persistent cross-session assistant reachable via Telegram, Discord, Slack, WhatsApp, Signal, or CLI — runs unattended on a VPS |
| **Scheduled automation** | Natural-language cron scheduling for reports, backups, and briefings |
| **Research & analysis** | Multi-step web research, arXiv search/summarization, batch document processing |
| **AI/ML research tooling** | RL trajectory generation, SFT data export (ShareGPT format), `WebResearchEnv` RL environment, `YC-Bench` long-horizon benchmarking |
| **Team collaboration** | Slack/Discord integration so teams interact with the agent in shared channels |
| **Self-hosted control** | MIT license, no vendor lock-in, Docker/Modal/Daytona/SSH/Singularity deployment targets |

---

## Architecture

### Core Loop
A **refined ReAct (Reasoning → Acting) loop** implemented in `run_agent.py`. The central `AIAgent` class cycles: Observation → Reasoning → Action until a final response is produced. New instances are created per message in gateway/batch mode; a single instance persists across a CLI session.

### Tool System
**40+ self-registering tools** covering: web search, web extraction, headless browser automation, vision, image generation, TTS, file operations, terminal commands, sandboxed Python execution, memory management, task planning, cron scheduling, subagent delegation, and MCP servers.

A notable feature is **Programmatic Tool Calling (PTC)** via `execute_code`: instead of sequential tool round-trips, the agent writes Python that runs a complete multi-step pipeline in one block, returning only the aggregated result. This collapses inference calls and — per Wang et al. (ICML 2024) — outperforms JSON schema tool calls by up to 20% on task success rate.

### Memory System
Three persistent layers:
1. **MemoryStore** — Cross-session flat files (`MEMORY.md`, `USER.md`, `SOUL.md`), frozen at session start
2. **SessionDB** — SQLite with FTS5 full-text search over conversation transcripts; LLM summarization for long-context recall
3. **TodoStore** — Per-session task tracking

Additionally, **Honcho AI-native user modeling** builds an evolving profile of user work style, domain knowledge, and preferences — not just storing what was said, but building a model of who the user is.

### Skills System
Skills are the architectural centerpiece. A **skill** is a directory with a `SKILL.md` file — structured procedural memory the agent creates autonomously when it solves a complex problem for the first time. Skills use YAML frontmatter (`name`, `description`, optional `license`, `compatibility`, `metadata`, `allowed-tools`) with a free-form Markdown body.

Key design choices:
- **Progressive disclosure**: only `name` + `description` (~100 tokens) load at startup for all skills; full body loads only on activation
- **Open standard**: uses the **AgentSkills specification** (`agentskills.io`), shared with GitHub Copilot, VS Code, and OpenAI Codex — making skills portable across agent implementations
- **Shareable**: skills are distributed via agentskills.io Skills Hub, ClawHub, and LobeHub
- **70+ bundled skills** across 15+ categories: MLOps, GitHub workflows, Solana blockchain, Google Workspace, Notion, arXiv, YouTube transcripts, and more

### Deployment Infrastructure
- **6 terminal sandbox backends**: Local, Docker, SSH, Modal, Daytona, Singularity (via `mini-swe-agent` submodule)
- **7 messaging platforms**: Telegram (PDF/Office attachments, forum topic isolation), Discord, Slack, WhatsApp, Signal, Email (IMAP/SMTP), Home Assistant
- **ACP integration**: VS Code, Zed, JetBrains IDEs via Agent Communication Protocol (stdio/JSON-RPC)
- **MCP support**: Full Model Context Protocol client with stdio + HTTP transports

### Model Support
Provider-agnostic via a centralized `call_llm()` API routing to: Nous Portal, OpenRouter (200+ models), OpenAI/Codex, Kimi/Moonshot, MiniMax, z.ai/GLM, or custom vLLM/SGLang endpoints. No code changes required to switch models.

---

## What Separates Hermes From Other Frameworks

### Comparison Table

| Feature | Hermes | LangGraph | CrewAI | AutoGen | smolagents | OpenAI Assistants |
|---|---|---|---|---|---|---|
| Persistent cross-session memory | Multi-level (file + SQLite + FTS5) | None (dev responsibility) | None | None | None | Threads (managed) |
| Autonomous skill creation | Yes (open AgentSkills spec) | No | No | No | No | No |
| Workflow model | ReAct loop (emergent) | DAG (explicit) | Role-based crews | Multi-agent conversation | Code execution | Managed |
| Multi-platform gateway | 7 platforms (first-class) | None | None | None | None | API only |
| RL/SFT data generation | Integrated | None | None | None | None | None |
| Model lock-in | None (200+ via OpenRouter) | None | None | None | HuggingFace-oriented | OpenAI only |
| Self-hosting | Yes | Yes | Yes | Yes | Yes | No |
| License | MIT | MIT | MIT | MIT | Apache 2.0 | Proprietary |

### Key Differentiators in Depth

**1. Autonomous skill evolution (vs. all others)**
No comparable framework automatically generates and stores portable procedural skills from task experience. LangChain/LangGraph/CrewAI/AutoGen all leave memory and skill management entirely to the developer. Hermes externalizes this as a first-class, open-spec, shareable artifact.

**2. Self-evolution research arm (unique)**
The companion repo `hermes-agent-self-evolution` (accepted as **ICLR 2026 Oral**) uses DSPy + GEPA (Genetic-Pareto Prompt Evolution) to automatically optimize skill files, tool descriptions, and system prompt sections using full execution traces — no GPU training, ~$2–10 per optimization cycle. This positions Hermes at the intersection of production tooling and active research into self-improving systems.

**3. Lifecycle orientation vs. task orientation**
CrewAI, AutoGen, and LangGraph are all task-oriented: you define a task, run the system, get output. Hermes is lifecycle-oriented: a persistent agent that accumulates knowledge, refines skills, and improves with continued use. The appropriate comparison is less "agent framework" and more "personal AI infrastructure."

**4. Multi-platform gateway as first-class target**
Other frameworks treat messaging platform integration as a downstream integration problem. Hermes ships a production gateway with per-platform session isolation, media handling, and forum/channel routing. A developer can deploy to a VPS and immediately have a persistent agent accessible from Telegram, Slack, and Discord simultaneously.

**5. RL/training integration**
The `tinker-atropos` submodule and `batch_runner.py` make Hermes a data-generation tool for model training — enabling trajectory collection, reward labeling, and SFT export as part of the same system used for production agent tasks. No other end-user framework integrates this natively.

---

## Limitations

| Limitation | Detail |
|---|---|
| **Memory scalability** | No documented mechanism for pruning contradictory or outdated skills as the corpus grows |
| **Model-dependent reliability** | 40+ tools are only as reliable as the model's tool selection; non-Hermes models untested at depth |
| **Gateway security surface** | Running as a persistent service accepting commands via 5+ messaging platforms is a significant attack surface; compromised accounts become effective remote shells |
| **Ecosystem immaturity** | ~862 GitHub stars vs. OpenClaw's 160K+; skills ecosystem value depends on community adoption still in early stages |
| **Not plug-and-play** | Targets Python developers and ML engineers; requires virtualenv, git submodule init, multi-platform credential configuration, long-running process management |
| **Prompt caching constraint** | Mid-conversation context alterations that invalidate the prompt cache are architecturally prohibited |
| **PTC limitations** | No Claude Code support yet; requires managed sandbox; broader security surface than JSON tool calls |
| **Multi-agent maturity** | Named-agent routing with isolated workspaces was still in active PRs as of March 2026 |

---

## Open Questions

1. Real-world production adoption at scale — does the skill system remain coherent at 500+ skills?
2. How does skill quality degrade as the corpus grows and contradictory procedures accumulate?
3. PTC reliability across non-Hermes models — is the 20% improvement model-specific?

---

## Session Timeline

**Session 1 (2026-03-15):** Initialized the research topic and conducted a full first-pass investigation. Fetched the GitHub repo, official documentation, AGENTS.md developer guide, v0.2.0 release notes, and four third-party comparison articles (yuv.ai, awesomeagents.ai, rywalker.com, ikangai.com). Identified the core architecture (ReAct loop, self-registering tools, three-layer memory, skills system), mapped use cases across developer automation / personal assistant / RL tooling domains, and constructed a detailed framework comparison. The central finding is that Hermes occupies a unique position combining autonomous persistent skill creation, multi-level cross-session memory, multi-platform gateway deployment, and training data generation — no other single framework combines all four.

---

*Generated 2026-03-15 from state.json + log.jsonl. Source of truth for updates is the log, not this file.*
