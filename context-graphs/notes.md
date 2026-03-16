# Context Graphs & AI Agent Performance — Research Notes

**Topic initialized:** 2026-03-16
**Status:** Active research

---

## 1. What Are Context Graphs?

Context graphs are structured, persistent, queryable networks of entities and relationships that give AI agents grounded, traversable knowledge rather than flat text. They are distinct from:

- **RAG (flat vector):** chunks of text retrieved by semantic similarity — no traversal, no relationships
- **Knowledge graphs (KG):** ontology-defined entity/relationship stores (e.g., RDF, property graphs)
- **Context graphs (new framing):** living records of *decision traces* — what happened, why it was allowed, who approved, which precedents apply — stitched across entities and time

Foundation Capital's Dec 2025 thesis ("AI's Trillion-Dollar Opportunity: Context Graphs") defines them as: *"a system of record for decisions, not just data."* Unlike SoR databases that record outcomes, context graphs capture the reasoning chain behind outcomes.

---

## 2. Why They Matter for AI Agents

Agents need more than rules — they need precedent. When an agent hits an ambiguous case, it needs to know:
- How was this resolved last time?
- Who approved the exception?
- What policy version was in effect?

Flat data can't answer these. Context graphs can. This directly impacts:
- **Reliability** — grounded decisions instead of hallucinated rules
- **Explainability** — traversable reasoning path
- **Long-horizon task completion** — persistent context across multi-step workflows

---

## 3. Technical Landscape

### 3a. GraphRAG (Microsoft, open-source)

- Repo: https://github.com/microsoft/graphrag
- **Architecture:** Ingests raw text → extracts entities/relationships → hierarchical community clustering (Leiden algorithm) → bottom-up community summaries → at query time, provides community summaries as LLM context
- **Query modes:**
  - `DRIFT Search` — entity-centric fan-out with community context
  - `Basic Search` — standard top-k vector fallback
  - `Global Search` — cross-community reasoning for thematic questions
- **Agent integration (2025):** Being connected to MCP servers for autonomous agent interfaces; applied to incident management and change management at Microsoft
- **Available via:** Microsoft Discovery (Azure), open-source on GitHub

### 3b. Hybrid Graph + Vector (KG-RAG, KA-RAG)

- **KG-RAG** (Scientific Reports 2025): Dual-channel retrieval — Dense Passage Retrieval (vector) + Graph Neural Network path attention. Filters entity-relationship chains, penalizes redundant paths.
- **KA-RAG** (MDPI 2025): Agentic workflow (ToolPlanner controller) + course KG + vector subsystem. Achieves **91.4% retrieval accuracy**.
- **FalkorDB GraphRAG:** Graph DB + vector hybrid, claims 90% hallucination reduction vs. traditional RAG, sub-50ms query latency.

### 3c. Graph-Based Agent Planning

- **GAP** (arXiv 2510.25320): Models task dependencies as DAGs. Trains via SFT + RL (correctness reward). Enables parallel tool execution. Results:
  - 33.4% fewer interaction turns
  - 24.9% shorter responses
  - 32.3% faster on HotpotQA
  - ~1% better accuracy vs. SOTA baselines on multi-hop QA

- **GLM** (arXiv 2511.01633): Multi-agent Graph-CoT framework. Decomposes into Classifier → Reasoner → Summarizer agents each with minimal context. Reduces unexpected agent outputs from 41% → 2%.

- **RoG:** Planning-retrieval-reasoning framework — generates KG *relation paths* as plans before reasoning, so the agent's reasoning path is structurally grounded.

- **ToG / KG-CoT:** KG-assisted reasoning — extract key entities from prompt, retrieve multi-hop subgraphs, inject as reasoning context.

### 3d. Multi-Agent Graph Orchestration

- **Evolving Orchestration** (arXiv 2505.19591): Puppeteer orchestrator dynamically activates agents within a directed graph-of-thoughts using RL-driven policy. Achieves better quality + lower compute vs. static topologies.

### 3e. Memory as a Graph

- **Mem0** (arXiv 2504.19413): Graph memory layer for long-term agent memory. Results vs. full-context:
  - 91% lower p95 latency
  - 90%+ token cost reduction
  - ~2% accuracy improvement over non-graph Mem0

---

## 4. Context Engineering Discipline (How Labs Actually Do It)

LangChain, Cognition AI, Anthropic internal tooling converge on **four strategies**:

| Strategy | What it does | Techniques |
|----------|-------------|-----------|
| **Write** | Persist outside context window | Scratchpad, memory store, Mem0 |
| **Select** | Retrieve only relevant info | KG-RAG, hybrid retrieval, re-ranking |
| **Compress** | Reduce token usage | Summarization, auto-compact (Claude Code uses this at 95% fill) |
| **Isolate** | Scope per sub-agent | Multi-agent isolation, min-context-by-default |

**Key production tips:**
- Cache stable prefixes (system prompt, long-term summaries) — reuse attention computation
- Scope context: each agent/tool call sees minimum necessary context
- Treat context as infrastructure with observability (LangSmith)
- Start simple (scratchpad + RAG), only add graph complexity when evidence demands it
- Context caching can dramatically reduce cost on repeated stable prefixes

**Context Engineering as a Service (CEaaS)** is predicted to emerge as a core architectural layer in 2026 — centralizing context construction to make agent behavior composable and reusable across teams.

---

## 5. Lab-Specific Signals

| Lab/Company | What they're doing |
|-------------|-------------------|
| **Microsoft** | GraphRAG (open-source), MCP-integrated agent interfaces, Microsoft Discovery on Azure |
| **Google** | Agent Development Kit (ADK) with context engineering, Deep Research (Gemini 3 Pro), Vertex AI agent orchestration |
| **Anthropic** | MCP (Model Context Protocol) as open standard, multi-agent scratchpad/memory patterns in Claude agents |
| **OpenAI** | Adopted Anthropic's Agent Skills open standard, working on long-horizon agents |
| **LangChain** | LangGraph for agentic orchestration (top framework per Nov 2025 survey), LangSmith for observability |
| **Glean** | Enterprise context graph ("we've been doing this, it finally has a name") |
| **Cognition AI** | Context engineering as primary engineering responsibility |
| **Neo4j / FalkorDB** | GraphRAG-native graph databases |

---

## 6. Performance Benchmarks (Compiled)

| Technique | Metric | Improvement |
|-----------|--------|-------------|
| GraphRAG vs. flat RAG | Query speed | ~5x faster |
| FalkorDB GraphRAG | Hallucination reduction | 90% vs. traditional RAG |
| FalkorDB GraphRAG | Latency | <50ms |
| KA-RAG | Retrieval accuracy | 91.4% |
| GAP (graph planning) | Interaction turns | -33.4% |
| GAP | Response length | -24.9% |
| GAP | Wall-clock time (HotpotQA) | -32.3% |
| GLM multi-agent | Unexpected outputs | 41% → 2% |
| Mem0 graph memory | p95 latency vs. full-context | -91% |
| Mem0 graph memory | Token cost vs. full-context | -90%+ |
| General RAG vs. no-RAG | Hallucination rate | ~60% reduction |

---

## 7. Open Questions (To Research)

- How are production teams actually *building* context graphs? (tooling, schema, maintenance)
- What's the practical difference between context graphs and traditional enterprise knowledge graphs?
- How does MCP interact with context graph architectures specifically?
- What are the failure modes? (graph staleness, missing decision traces, schema drift)
- Which startups are building "systems of record for decisions"? (competitor landscape)
- How does Anthropic's internal memory/context architecture work for Claude agents?
- Are there published evals comparing context graph vs. flat RAG on agentic tasks (not just QA)?

---

## 8. Key Sources

- [Foundation Capital: Context Graphs — AI's Trillion-Dollar Opportunity](https://foundationcapital.com/ideas/context-graphs-ais-trillion-dollar-opportunity)
- [Microsoft GraphRAG Project](https://www.microsoft.com/en-us/research/project/graphrag/)
- [Microsoft GraphRAG GitHub](https://github.com/microsoft/graphrag)
- [GraphRAG + Agentic Architecture (Microsoft Medium)](https://medium.com/data-science-at-microsoft/graphrag-powered-ai-agent-interfaces-revolutionizing-content-retrieval-and-generation-with-8ba7d2c1c698)
- [GAP: Graph-Based Agent Planning (arXiv 2510.25320)](https://arxiv.org/abs/2510.25320)
- [GLM: Scaling Graph Chain-of-Thought (arXiv 2511.01633)](https://arxiv.org/html/2511.01633)
- [Graphs Meet AI Agents: Taxonomy (arXiv 2506.18019)](https://arxiv.org/html/2506.18019v1)
- [Mem0: Long-Term Graph Memory (arXiv 2504.19413)](https://arxiv.org/pdf/2504.19413)
- [Multi-Agent Evolving Orchestration (arXiv 2505.19591)](https://arxiv.org/html/2505.19591v2)
- [LangChain: Context Engineering for Agents](https://blog.langchain.com/context-engineering-for-agents/)
- [Neo4j: GraphRAG + Agentic Architecture](https://neo4j.com/blog/developer/graphrag-and-agentic-architecture-with-neoconverse/)
- [Cloudraft: Context Graph Implementation Guide](https://www.cloudraft.io/blog/context-graph-for-ai-agents)
- [Glean: Context as the New Data Platform](https://www.glean.com/blog/context-data-platform)
- [KA-RAG Framework (MDPI 2025)](https://www.mdpi.com/2076-3417/15/23/12547)
- [KG-RAG (Scientific Reports 2025)](https://www.nature.com/articles/s41598-025-21222-z)
- [Awesome-Context-Engineering (GitHub)](https://github.com/Meirtz/Awesome-Context-Engineering)
- [Subramanya N: Who Captures the Context Graph Opportunity?](https://subramanya.ai/2026/01/14/context-graphs-are-a-trillion-dollar-opportunity-but-who-captures-it/)
