# OpenClaw: Deep Research Notes
*Researched: 2026-03-15 | Sources: GitHub, docs.openclaw.ai, MindStudio, DecisionCrafters, ToolMesh, DEV.to, Every.to, Apiyi/ClawHub guide, oboe.com comparison, OpenClaw Social*

---

## 1. Identity & History

**Full name**: OpenClaw (formerly Clawdbot, then Moltbot)
**Tagline**: "Your own personal AI assistant. Any OS. Any Platform. The lobster way. 🦞"
**Repo**: https://github.com/openclaw/openclaw
**Docs**: https://docs.openclaw.ai
**License**: MIT
**Primary language**: TypeScript / JavaScript (Node.js ≥ 22 required; Node 24 recommended)
**Creator**: Peter Steinberger (founder of PSPDFKit, ~$800M exit, Austrian)
**Launch**: November 2025
**Current backing**: OpenAI (financial sponsor); project transitioned to independent 501(c)(3) open-source foundation in February 2026. Steinberger joined OpenAI in February 2026 to lead their personal agents division.

### Naming timeline
- **Clawdbot** — original name, dropped due to Anthropic/Claude trademark concerns
- **Moltbot** — three-day interim name
- **OpenClaw** — current name; each rename reportedly boosted visibility

---

## 2. GitHub & Community Metrics

| Metric | Value | Source |
|--------|-------|--------|
| Stars | **315k** (as of mid-March 2026) | github.com/openclaw/openclaw |
| Forks | 60.1k | GitHub |
| Open issues/PRs | 5k+ | GitHub |
| Security alerts | 288 tracked | GitHub |
| Growth rate | Reached 302k in ~60 days from launch | DecisionCrafters |
| Comparison | Surpassed React's 10-year record; beat Linux (220k stars) within ~100 days | ToolMesh, DecisionCrafters |
| Active Discord | "clawd" server | GitHub README |
| Moltbook agents | 1.5 million registered AI agents (social network) | OpenClaw Social |

**Context on star count**: The prior research note of ~160k appears to be an earlier snapshot; the repo has continued rapid growth to 315k by the time of this research. Multiple independent sources corroborate 302k–315k range.

### Ecosystem repos
| Repo | Stars | Purpose |
|------|-------|---------|
| openclaw/skills (ClawHub archive) | 2.9k | All ClawHub skills archived |
| Gen-Verse/OpenClaw-RL | 2.9k | RL training framework built on OpenClaw |
| abhi1693/openclaw-mission-control | 2.4k | Team/enterprise orchestration dashboard |
| mergisi/awesome-openclaw-agents | — | 162 SOUL.md agent templates, 24 categories |
| VoltAgent/awesome-openclaw-skills | — | 5,400+ curated skills |
| shenhao-stu/openclaw-agents | — | 9-agent multi-agent setup, one command |
| aaronjmars/soul.md | — | SOUL.md personality builder tool |

---

## 3. Architecture

### 3.1 High-Level Overview

OpenClaw is a **single always-on Node.js process** (the Gateway) running on user hardware. It acts as the central control plane for all messaging channels, agent sessions, tool execution, and event scheduling.

```
Chat apps (23+ platforms)
         ↓
   [Gateway: 127.0.0.1:18789 ws]
         ↓
   [Agent Runtime (Pi)]
    /    |    \    \
  Tools  CLI  WebUI  Mobile Nodes
```

### 3.2 Gateway (Control Plane)

- Listens on `ws://127.0.0.1:18789` (WebSocket-based)
- Single Node.js process managing all platform connections simultaneously
- Routes inbound messages to the correct agent session
- Supports multi-agent routing: different agents for different channels, contacts, or groups
- Configuration: `~/.openclaw/openclaw.json`

### 3.3 Agent Loop

Each inbound message triggers a serialized cycle:
1. Assemble context (session history, memory files, skills)
2. Query LLM
3. Execute tool calls (up to 20 iterations per request)
4. Stream response back through originating channel

**Lane Queue system**: Defaults to serial execution to prevent race conditions when multiple messages arrive simultaneously. Concurrency ceiling: `maxConcurrent: 8` (noted limitation in community articles).

### 3.4 Memory Model

OpenClaw uses **plain-text Markdown files** stored in `~/.openclaw/workspace/` — explicitly avoiding complex memory architectures in favor of portability and explicitability.

| File | Purpose |
|------|---------|
| `SOUL.md` | Agent identity, values, personality constitution (writable, evolves over time) |
| `AGENTS.md` | Behavioral rules, routing configuration, explicit conduct rules |
| `MEMORY.md` | Curated long-term notes (main/private sessions only) |
| `memory/YYYY-MM-DD.md` | Daily episodic short-term memory |
| `TOOLS.md` | Tool access configuration |
| `HEARTBEAT.md` | Instructions for proactive scheduled check-ins |
| `USER.md` | User profile and preferences |
| `IDENTITY.md` | Agent identity snapshot |
| `log.jsonl` | Append-only factual audit log (tool calls, results) — **"JSONL Transcripts"** |

**Semantic search**: Optional vector embeddings via SQLite. Supported embedding providers: OpenAI, Gemini, Voyage, Mistral, Ollama, or local.

**Session limits**: Bounded by model context window; long conversations trigger compaction.

### 3.5 Tool System

Built-in tools:
- **Shell execution** — arbitrary bash/system commands
- **File system** — read/write local files
- **Browser control** — dedicated Chrome/Chromium via CDP; uses "Semantic Snapshots" (accessibility tree parsing) to reduce token costs vs screenshot-only approaches
- **Canvas / A2UI** — agent-driven visual workspace
- **Cron jobs** — scheduled recurring tasks
- **Webhooks** — inbound/outbound HTTP triggers, including Gmail Pub/Sub integration
- **Node tools** — camera, screen recording, location (via macOS/iOS/Android companion apps)

**MCPorter (MCP integration)**: Middleware bridge connecting to Model Context Protocol servers via standardized JSON-RPC. Any MCP server becomes an instantly-available Skill. Drawback: injects tool context into prompts each cycle, consuming additional tokens.

### 3.6 Skills System (ClawHub)

Skills are **Markdown instruction documents** (not compiled code) with YAML frontmatter. Format:
```markdown
---
name: "skill-name"
version: "1.0.0"
description: "..."
tags: ["tag1", "tag2"]
---
[Natural language instructions...]
```

**ClawHub** (clawhub.ai) is the official skill registry — positioned as "npm for AI Agents":
- **13,729 community-built skills** as of February 28, 2026 (one source; another cites 3,286; VoltAgent/awesome-openclaw-skills curates 5,400+)
- Uses OpenAI Embeddings + Convex vector search for semantic discovery
- Install via: `clawhub search "calendar management"` → `clawhub install <skill-slug>`
- Skills span: Gmail, GitHub, Spotify, Philips Hue, crypto trading, Home Assistant, Slack, Notion, and 700+ categories
- **Security note**: ClawHavoc attack (January 2026) — 341 malicious skills distributed Atomic macOS Stealer malware; ~1,184 total malicious skills identified (~11% of registry at that time)

Skill types:
- **Bundled** — shipped with OpenClaw core
- **Managed** — ClawHub-sourced, versioned
- **Workspace-specific** — local custom skills
- **Self-discovering** — agent can autonomously find and install skills based on need ("Tell it you want to manage your calendar, and it will investigate how to connect")

### 3.7 Multi-Agent Architecture

Three routing primitives:
1. **`agentToAgent` tool** — peer-to-peer direct messaging between agents with isolated workspaces
2. **`sessions_send`** — addressable sessions via `agent:<agentId>:<projectKey>` keys; supports async (fire-and-forget with `timeoutSeconds: 0`) and sync (blocking) modes
3. **Webhook endpoint** — `/hooks/agent` accepts external HTTP requests routing to specific agents; `deliver: false` flag for internal-only delivery

**Orchestration model**: Hub-and-Spoke via A2A (Agent-to-Agent) protocol; the Gateway routes inter-agent comms via `sessions_send`. Identity Resolution Cascades verify agent capabilities against each agent's SOUL.md constitution.

**Known limitations** (from DEV.to community contributor):
- `sessions_spawn` max depth: 2 (no deep hierarchies)
- Global concurrency ceiling: `maxConcurrent: 8`
- Missing loop constructs in Lobster workflow engine (community PR #20 contributed a fix)
- Memory is isolated per agent — no shared memory spaces; data flows via explicit message passing

### 3.8 Heartbeat / Proactive Actions

Every 30 minutes (configurable), the agent reads `HEARTBEAT.md` and decides autonomously whether to take proactive action — enabling morning briefings, scheduled monitoring, overnight autonomous work.

---

## 4. Supported Messaging Platforms

23+ platforms confirmed:

| Category | Platforms |
|----------|-----------|
| Major | WhatsApp, Telegram, Discord, Slack, Signal |
| Apple ecosystem | iMessage (macOS), BlueBubbles |
| Business | Microsoft Teams, Google Chat, Mattermost, Feishu |
| Decentralized/alt | Matrix, Nostr, IRC |
| Regional | LINE, Zalo, Zalo Personal |
| Collaboration | Nextcloud Talk, Synapse Chat, Tlon |
| Entertainment | Twitch |
| Built-in | WebChat (localhost) |

Extension packages add further channels (e.g., Mattermost).

**Note**: Previous research referenced 50+ platforms. Confirmed count from current documentation is 23+. The "50+" figure may include community extension packages not yet in the official count.

---

## 5. Model / Provider Support

| Provider | Models |
|----------|--------|
| Anthropic | Claude Opus 4.6, Sonnet 4.5, Haiku (recommended: Opus 4.6 for security/long-context) |
| OpenAI | GPT-4o, GPT-4, Codex; via API key or OAuth |
| Google | Gemini |
| xAI | Grok |
| DeepSeek | DeepSeek V3 |
| Moonshot | Kimi |
| Local | Ollama, LM Studio, llama.cpp, vLLM |
| Aggregator | OpenRouter (any provider) |
| Cloud managed | AWS Bedrock (manual config) |
| Other | MiniMax, Perplexity |

**Per-agent model defaults** supported. Users can switch models without wiping config.

**Official recommendation**: Claude Opus 4.6 for security (prompt injection resistance) and long-context tasks; Claude Sonnet 4.5 for cost-effectiveness.

---

## 6. Deployment Options

### Installation
```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon
```
Onboarding wizard configures LLM providers, messaging channels, skills.

### Runtime targets
| Option | Details |
|--------|---------|
| macOS daemon | launchd; menu bar companion app |
| Linux daemon | systemd |
| Windows | WSL2 required |
| Docker | Compose files provided; recommended for sandboxing untrusted sessions |
| Nix | Declarative configuration |
| VPS | Fly.io, Hetzner (~€4/month), exe.dev guides; 512MB–1GB RAM minimum |
| Raspberry Pi | 64-bit OS, Node ≥ 22 |
| Remote access | Tailscale Serve/Funnel, SSH tunnel |

### Companion apps
- **macOS**: Menu bar app
- **iOS**: Node app (camera, location, notifications)
- **Android**: Node app (continuous voice mode, camera, screen recording)

### Web dashboard
`http://localhost:18789/` — local web control UI

### Hardware cost estimates (community)
- Hetzner VPS: ~€4/month
- Mac Mini M4: ~$640 one-time
- Managed hosting (OpenClawd): $9–$129/month

---

## 7. Licensing

**License**: MIT — free to use, modify, and build commercially.
**Governance**: Independent 501(c)(3) open-source foundation (as of February 2026), backed financially by OpenAI.

**API cost range** (not OpenClaw fees — LLM provider costs):
- Claude Haiku: ~$0.50/$2 per million input/output tokens
- Claude Opus: ~$15/$75 per million tokens
- User-reported range: $0–$500+/month depending on model and usage intensity

---

## 8. Security Profile

**Critical issues documented**:
- **ClawHavoc** (January 2026): Supply chain attack via 341 malicious ClawHub skills distributing Atomic macOS Stealer malware
- **Exposed instances**: 21,000+ instances found leaking API keys (January 2026)
- **Prompt injection**: Malicious instructions embeddable in emails, websites, documents the agent processes
- **Moltbook breach**: Exposed MongoDB leaked 500,000+ API keys and millions of chat records
- Multiple CVEs patched in early 2026, including one-click RCE
- Microsoft security blog: "should be treated as untrusted code execution with persistent credentials"

**Mitigations built in**:
- Token-based auth on non-loopback binds
- Per-channel allowlists for DMs and groups
- Docker sandboxing for untrusted sessions
- Node pairing requires explicit approval
- `openclaw security audit --deep` command
- Skill review tooling (26% of 31,000 scanned skills found to contain vulnerabilities)

---

## 9. Adjacent Ecosystem

### OpenClaw-RL (Gen-Verse/OpenClaw-RL, 2.9k stars)
Fully asynchronous RL framework that converts live conversations into training signals for personalized models. Four decoupled async components: agent serving, rollout collection, evaluation (Process Reward Models), policy training. Supports Binary RL, On-Policy Distillation, and combination methods. Wraps self-hosted models as OpenAI-compatible API. LoRA-based. Deployable locally or via Tinker cloud service.

### Mission Control (abhi1693/openclaw-mission-control, 2.4k stars)
Centralized operations/governance dashboard for teams running OpenClaw at scale. Features: work orchestration, agent lifecycle management, approval-driven governance, activity audit trails, dual UI + API access. Deploy via one-command installer, Docker Compose, or local dev mode. MIT licensed.

### Moltbook / OpenClaw Social
Social network exclusively for AI agents, launched January 28, 2026. Within one week: 1.5 million agents registered, 13.8k communities ("Submolts"), 91k posts, 232.8k comments. Cultural phenomena: "Crustafarianism" religion founded by agents; community slang "EXFOLIATE!". Security incident: exposed MongoDB leaked 500k+ API keys.

---

## 10. Comparison Relevant to Hermes

From multiple third-party sources:

| Dimension | OpenClaw | Hermes Agent |
|-----------|----------|--------------|
| **Stars** | 315k | ~6k |
| **Language** | TypeScript / Node.js | Python |
| **Primary interface** | Messaging apps (WhatsApp/Telegram/etc.) | Terminal / SSH |
| **Memory model** | Markdown files (SOUL.md, MEMORY.md, daily logs) + optional SQLite vector search | Multi-level (FTS5 SQLite, episodic, semantic, working) |
| **Memory depth** | File-based, human-readable, portable | Programmatic, FTS5-indexed, richer query |
| **Skill system** | SKILL.md Markdown documents, ClawHub registry (13,729+ skills) | AgentSkills spec — autonomous skill creation from task completions |
| **Skill creation** | Manual / community-submitted | **Autonomous** — agent generates skills itself |
| **Tool calling** | MCPorter (MCP bridge) + built-in tools | Native tool calling (Hermes model fine-tuned) + MCP |
| **Multi-agent** | Hub-and-Spoke via A2A, sessions_send, agentToAgent | Multi-agent support, less documented gateway |
| **Scheduling/proactive** | HEARTBEAT.md + cron | Cron-like scheduling |
| **RL/training** | OpenClaw-RL (separate companion repo) | Built-in RL/SFT data generation (Atropos) |
| **Self-evolution** | External (OpenClaw-RL, 2.9k stars) | GEPA research (ICLR 2026 Oral), partially integrated |
| **Deployment** | npm, Docker, macOS/iOS/Android apps, VPS | Docker, SSH, Singularity, Modal, Local |
| **Platform reach** | 23+ messaging platforms | Terminal + gateway |
| **Model agnosticism** | High (10+ providers) | High (Hermes models preferred, but MCP/tool-call compatible) |
| **Security posture** | Multiple critical incidents in 2026; active remediation | No documented mass incidents |
| **License** | MIT | MIT (Apache 2.0 for some components) |
| **Governance** | 501(c)(3) foundation + OpenAI backing | NousResearch |
| **Target user** | Technical personal users, developers wanting 24/7 assistant | Developers, AI researchers, terminal-native power users |

### Key differentiator framing (from third-party reviews)
- "OpenClaw is the clearest signal that demand for local-first personal agents is real, while Hermes is the most interesting if you live in the terminal and care about persistent intelligence more than raw feature count." — Medium comparison article
- "OpenClaw prioritizes observability and a persistent 'paper trail' at the cost of some structural rigidity, while Hermes offers raw power and flexibility at the expense of built-in auditability." — oboe.com comparison
- "Choose OpenClaw if you want an always-on personal agent across all your devices and messaging apps. Hermes is best for developers and AI researchers who need a persistent, self-improving coding companion." — MindStudio blog

---

## 11. Sources

- https://github.com/openclaw/openclaw (main repo)
- https://docs.openclaw.ai (official docs)
- https://docs.openclaw.ai/help/faq
- https://www.mindstudio.ai/blog/what-is-openclaw-ai-agent
- https://www.decisioncrafters.com/openclaw-fastest-growing-ai-agent-framework/
- https://www.toolmesh.ai/news/openclaw-tops-github-star-rankings-surpassing-linux
- https://every.to/source-code/openclaw-setting-up-your-first-personal-ai-agent
- https://dev.to/ggondim/how-i-built-a-deterministic-multi-agent-dev-pipeline-inside-openclaw-and-contributed-a-missing-4ool
- https://help.apiyi.com/en/clawhub-ai-openclaw-skills-registry-guide-en.html
- https://openclawsocial.org/index.html
- https://github.com/Gen-Verse/OpenClaw-RL
- https://github.com/abhi1693/openclaw-mission-control
- https://github.com/mergisi/awesome-openclaw-agents
- https://github.com/VoltAgent/awesome-openclaw-skills
- https://oboe.com/learn/openclaw-vs-hermes-agent-comparison-z1uwjr/mcp-integration-patterns-1clxew0
- https://medium.com/@alvintoms2136/elizaos-vs-openclaw-vs-hermes-what-actually-matters-in-2026-a5cf7446726f (403)
