# Research Report: Context Graphs & AI Agent Performance

**Topic:** context-graphs
**Created:** 2026-03-16
**Last Updated:** 2026-03-16
**Status:** Active — initial landscape survey complete

---

## Current Hypothesis

Context graphs are the emerging infrastructure layer separating production-grade AI agents from demo-quality systems. The key insight: agents need **decision traces** (why something was allowed to happen) not just data (what happened). GraphRAG + hybrid retrieval + graph-based planning is the dominant technical direction. Context engineering (write/select/compress/isolate) is the discipline. The trillion-dollar opportunity is building systems of record for decisions.

---

## Key Findings

### 1. The "Decision Traces" Framing (Foundation Capital, Dec 2025)
The highest-signal conceptual contribution of the past year is Foundation Capital's thesis: the next trillion-dollar platforms won't be built by adding AI to existing systems of record — they'll be built by capturing **decision traces** that enterprises have never systematically stored. A context graph is a living record of: how rules were applied, where exceptions were granted, who approved what, and which precedents actually govern reality. Existing SoR databases (Salesforce, Workday, SAP) record *outcomes*; they don't capture *why* outcomes were allowed. That "missing layer" is what agents need to operate reliably.

> "Agents don't just need rules — they need access to the decision traces that show how rules were applied in the past." — Foundation Capital

### 2. Microsoft GraphRAG — The Reference Architecture
Microsoft's open-source GraphRAG (github.com/microsoft/graphrag) is the most widely cited production-grade implementation:
- **Indexing:** Raw text → entity/relationship extraction → hierarchical community clustering (Leiden algorithm) → bottom-up community summaries
- **Query modes:**
  - **DRIFT Search** — entity-centric fan-out with community context (best for specific entities)
  - **Global Search** — cross-community reasoning for thematic/holistic questions
  - **Basic Search** — standard top-k vector fallback
- **2025 agent integration:** Being wired to MCP servers for autonomous agent interfaces; deployed in Microsoft incident management and change management workflows
- **Available via:** Microsoft Discovery (Azure) + open-source

### 3. Graph-Based Agent Planning Delivers Measurable Gains
**GAP** (arXiv 2510.25320) — Graph-based Agent Planning with Parallel Tool Use and RL:
- Models task dependencies as directed acyclic graphs (DAGs)
- Trains via SFT + RL with correctness-based reward
- Enables parallel tool execution where dependencies allow
- **Results vs. sequential baselines:**
  - −33.4% interaction turns
  - −24.9% response length
  - −32.3% wall-clock time on HotpotQA
  - ~1% accuracy improvement on multi-hop QA

**GLM** (arXiv 2511.01633) — Multi-Agent Graph Chain-of-Thought:
- Decomposes into Classifier → Reasoner → Summarizer agents, each with minimal scoped context
- Reduces unexpected/hallucinated agent outputs from **41% → 2%**
- Addresses the core problem: long graph context causes unstable reasoning in a single agent

### 4. Hybrid Graph + Vector Retrieval Outperforms Either Alone
| Framework | Approach | Key Result |
|-----------|----------|-----------|
| FalkorDB GraphRAG | Graph DB + vector hybrid | 90% hallucination reduction, <50ms latency |
| KA-RAG (MDPI 2025) | Agentic RAG + KG + vector | 91.4% retrieval accuracy |
| KG-RAG (Scientific Reports 2025) | DPR + GNN path attention | Dual-channel reduces redundancy |
| GraphRAG vs. flat RAG | Graph traversal vs. vector only | ~5x query speed on multi-hop |

### 5. Graph Memory Dramatically Reduces Cost
**Mem0** (arXiv 2504.19413) — graph memory for long-term agent state:
- vs. full-context approaches: **−91% p95 latency**, **−90%+ token cost**
- ~2% accuracy improvement over non-graph Mem0
- Practical implication: graph-structured memory makes long-horizon agents economically viable

### 6. Context Engineering Is the Discipline
LangChain, Cognition AI, Anthropic, and Google have converged on four strategies for managing agent context at scale:

| Strategy | What It Does | Key Techniques |
|----------|-------------|---------------|
| **Write** | Persist outside the context window | Scratchpad, memory store, Mem0 |
| **Select** | Retrieve only relevant info | KG-RAG, hybrid retrieval, re-ranking |
| **Compress** | Reduce token usage | Summarization, auto-compact |
| **Isolate** | Scope per sub-agent | Multi-agent isolation, min-context-by-default |

Key production tactics:
- Cache stable prefixes (system prompt, long-term summaries) to reuse attention computation
- Each agent/tool call sees minimum necessary context by default
- Treat context as observable infrastructure (LangSmith for tracing)
- Context Engineering as a Service (CEaaS) is predicted as a core 2026 architectural layer

### 7. Lab-Specific Signals

| Lab / Company | What They're Doing |
|---------------|-------------------|
| **Microsoft** | GraphRAG (open-source + Azure Discovery), MCP-integrated agent interfaces |
| **Google** | Agent Development Kit (ADK) with context engineering, Deep Research (Gemini 3 Pro API) |
| **Anthropic** | MCP as open standard (adopted by OpenAI), multi-agent scratchpad/memory patterns |
| **OpenAI** | Adopted Anthropic Agent Skills standard; long-horizon agent research |
| **LangChain** | LangGraph (#1 agentic framework per Nov 2025 survey), LangSmith observability |
| **Glean** | Enterprise context graph ("we've been doing this, it finally has a name") |
| **Cognition AI** | Context engineering as primary engineering responsibility |
| **Neo4j / FalkorDB** | GraphRAG-native graph databases |

---

## Performance Benchmarks (Compiled)

| Technique | Metric | Result |
|-----------|--------|--------|
| GraphRAG vs. flat RAG | Multi-hop query speed | ~5x faster |
| FalkorDB GraphRAG | Hallucination reduction | 90% vs. traditional RAG |
| FalkorDB GraphRAG | Query latency | <50ms |
| KA-RAG | Retrieval accuracy | 91.4% |
| GAP (graph planning) | Interaction turns | −33.4% |
| GAP (graph planning) | Response length | −24.9% |
| GAP (graph planning) | Wall-clock (HotpotQA) | −32.3% |
| GLM multi-agent | Unexpected outputs | 41% → 2% |
| Mem0 graph memory | p95 latency vs. full-context | −91% |
| Mem0 graph memory | Token cost vs. full-context | −90%+ |
| RAG vs. no-RAG (general) | Hallucination rate | ~60% reduction |

---

## Approaches Tried

1. Web search: context graphs AI agents state of the art 2025 2026
2. Web search: knowledge graph RAG agent performance optimization top AI labs 2025
3. Web search: GraphRAG Microsoft context graph agent architecture techniques 2025
4. Web search: Google DeepMind Anthropic OpenAI context graph memory agent system 2025
5. Web search: context graph agent performance multi-hop reasoning planning 2025 arxiv
6. Web search: Foundation Capital context graphs trillion dollar opportunity
7. Web search: production agent context graph implementation techniques 2025 engineering

---

## Open Questions

1. How are production teams actually *building* context graphs? (tooling, schema design, maintenance burden)
2. What is the practical difference between context graphs and traditional enterprise knowledge graphs?
3. How does MCP interact with context graph architectures specifically?
4. What are the failure modes? (graph staleness, missing decision traces, schema drift)
5. Which startups are building "systems of record for decisions"? (competitive landscape)
6. Are there published evals comparing context graph vs. flat RAG on *agentic* tasks (not just QA benchmarks)?
7. How does Anthropic's internal memory/context architecture work for Claude agents?

---

## Next Steps

1. Deep dive on key arXiv papers: GAP (2510.25320), GLM (2511.01633), Graphs Meet AI Agents (2506.18019)
2. Research startup landscape: who is building context graph / systems-of-decisions infrastructure
3. Research MCP + context graph integration patterns
4. Research failure modes and operational challenges of graph-based agent memory
5. Look for production case studies beyond Microsoft incident management

---

## Session Timeline

**Session 1 — 2026-03-16 (initialization)**
Bootstrapped the topic from scratch. Ran 7 parallel web searches to map the full landscape: conceptual framing (Foundation Capital decision-traces thesis), technical architecture (Microsoft GraphRAG, KG-RAG, KA-RAG, FalkorDB), academic SOTA (GAP, GLM, RoG, ToG, Mem0, Evolving Orchestration arXiv papers), lab-specific signals (Microsoft, Google, Anthropic, OpenAI, LangChain), and production engineering discipline (context engineering write/select/compress/isolate). Compiled `notes.md` with structured findings. Strong initial hypothesis formed: context graphs = decision trace infrastructure; the dominant technical pattern is GraphRAG + hybrid retrieval + graph-based planning + multi-agent isolation. Next session should go deeper on specific arXiv papers and the startup/competitive landscape.

---

## Key Sources

- [Foundation Capital: Context Graphs — AI's Trillion-Dollar Opportunity](https://foundationcapital.com/ideas/context-graphs-ais-trillion-dollar-opportunity)
- [Microsoft GraphRAG Project Page](https://www.microsoft.com/en-us/research/project/graphrag/)
- [Microsoft GraphRAG GitHub](https://github.com/microsoft/graphrag)
- [GraphRAG + Agentic Interfaces (Microsoft Engineering Blog)](https://medium.com/data-science-at-microsoft/graphrag-powered-ai-agent-interfaces-revolutionizing-content-retrieval-and-generation-with-8ba7d2c1c698)
- [GAP: Graph-Based Agent Planning (arXiv 2510.25320)](https://arxiv.org/abs/2510.25320)
- [GLM: Scaling Graph Chain-of-Thought (arXiv 2511.01633)](https://arxiv.org/html/2511.01633)
- [Graphs Meet AI Agents: Taxonomy (arXiv 2506.18019)](https://arxiv.org/html/2506.18019v1)
- [Mem0: Long-Term Graph Memory (arXiv 2504.19413)](https://arxiv.org/pdf/2504.19413)
- [Multi-Agent Evolving Orchestration (arXiv 2505.19591)](https://arxiv.org/html/2505.19591v2)
- [LangChain: Context Engineering for Agents](https://blog.langchain.com/context-engineering-for-agents/)
- [Neo4j: GraphRAG + Agentic Architecture](https://neo4j.com/blog/developer/graphrag-and-agentic-architecture-with-neoconverse/)
- [KA-RAG Framework (MDPI 2025)](https://www.mdpi.com/2076-3417/15/23/12547)
- [KG-RAG (Scientific Reports 2025)](https://www.nature.com/articles/s41598-025-21222-z)
- [Glean: Context as the New Data Platform](https://www.glean.com/blog/context-data-platform)
- [Awesome-Context-Engineering (GitHub)](https://github.com/Meirtz/Awesome-Context-Engineering)
- [Subramanya N: Who Captures the Context Graph Opportunity?](https://subramanya.ai/2026/01/14/context-graphs-are-a-trillion-dollar-opportunity-but-who-captures-it/)
- [Cloudraft: Context Graph Implementation Guide](https://www.cloudraft.io/blog/context-graph-for-ai-agents)
