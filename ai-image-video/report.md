# AI Image Generation Tools — Research Report

**Topic:** ai-image-video
**Created:** 2026-03-18
**Last Updated:** 2026-03-18T14:28:07Z

---

## Current Hypothesis

For marketing/commercial content in 2026: Adobe Firefly is safest for legal compliance; Midjourney V7 produces highest artistic quality; GPT Image 1 leads on text rendering; Flux 2 is the best open-source option; Ideogram 3.0 dominates typography use cases.

---

## Key Findings

### 1. Top Tools by Category (March 2026)

| Tool | Company | Best For |
|------|---------|----------|
| Midjourney V7 | Midjourney Inc. | Artistic quality, photorealism, brand imagery |
| GPT Image 1 / 1.5 | OpenAI | Text rendering, prompt fidelity, API integration |
| Adobe Firefly | Adobe | Commercial safety, Photoshop/CC workflow integration |
| Flux 2 (FLUX.2) | Black Forest Labs | Open-source photorealism, production-grade quality |
| Ideogram 3.0 | Ideogram AI | Typography, posters, signage, marketing assets with text |
| Stable Diffusion 3.5 | Stability AI | Open-source, customizable, self-hosted fine-tuning |
| Google Imagen 3 | Google DeepMind | Fast generation, Gemini ecosystem, competitive pricing |
| Leonardo.ai | Leonardo.ai | Multi-model platform, video generation, design flexibility |
| DALL-E 3 | OpenAI | Legacy model, still usable; superseded by GPT Image 1 |

---

## Section 2: Pricing Breakdown (as of March 2026)

### Midjourney
- **Basic:** $10/month — ~3.3 fast GPU hours, limited relaxed generations
- **Standard:** $30/month — 15 fast GPU hours, unlimited relaxed
- **Pro:** $60/month — 30 fast GPU hours, Stealth Mode (private images)
- **Mega:** $120/month — unlimited relaxed generations
- Annual discount: 20% off all plans
- No free tier (free trial was discontinued in 2023)
- V7 is the current default (set June 2025); use `--v 7` in prompts

### OpenAI (GPT Image 1 & DALL-E 3)
GPT Image 1 has replaced DALL-E 3 as the primary model. DALL-E 3 remains available as a "previous generation" model.

| Model | Quality | Price per image |
|-------|---------|-----------------|
| GPT Image 1 | High | $0.167 |
| GPT Image 1 | Medium | $0.04 |
| GPT Image 1 | Low | $0.01 |
| GPT Image 1 Mini | High | $0.036 |
| GPT Image 1 Mini | Low | $0.005 |
| DALL-E 3 | Standard/HD | $0.04–$0.12 |

- New API users receive $5 in free credits
- Full commercial rights included with API access at no extra cost
- Resolutions: 1024×1024, 1024×1536, 1536×1024

### Adobe Firefly
- **Free:** $0/month — limited monthly credits
- **Standard:** $9.99/month — 2,000 premium credits
- **Pro:** $19.99/month — 4,000 premium credits
- **Premium:** $199.99/month — 50,000 premium credits
- Enterprise plans include indemnification against copyright claims
- Commercial use permitted on all non-beta, paid-tier outputs
- Integrates natively into Photoshop, Illustrator, Premiere Pro

### Stable Diffusion 3.5 (via Stability AI API)
- Credits: $10 per 1,000 credits; new accounts get 25–200 free credits
- **SD 3.5 Large** (8B params): 6.5 credits/image (~$0.065)
- **SD 3.5 Medium:** 3.5 credits/image (~$0.035)
- **Stable Image Ultra** (SD 3.5 based): 8 credits/image (~$0.08)
- **SD Turbo:** 4 credits/image (~$0.04)
- Open-weight checkpoints free to download and self-host; only API access costs credits
- Full ComfyUI integration available

### Flux / FLUX.1 (Black Forest Labs)
- **FLUX.1 [schnell]:** Open-weight, Apache 2.0 license — free to self-host
- **FLUX.1 [dev]:** Open-weight, non-commercial license — free to self-host for research
- **FLUX.1 [pro] / FLUX.2 [pro]:** API access via Black Forest Labs API and third-party providers (fal.ai, Replicate, etc.) — pricing varies, roughly $0.04–$0.09/image
- FLUX.2 [dev] is a 32B open-weight model released November 2025

### Google Imagen 3
- **Gemini API:** $0.03 per image
- Free access via ImageFX and Gemini web interface (usage limits apply)
- Available on Google AI Studio with free tier
- Also accessible via Vertex AI (enterprise pricing)

### Ideogram
- **Free:** limited generations
- **Plus:** $20/month — 1,000 priority credits
- **Pro:** $60/month — 3,500 priority credits, batch generation
- **Teams:** $30/user/month — 1,500 priority credits/user

### Leonardo.ai
- **Free:** limited tokens
- **Apprentice:** $10/month (annual) — 8,500 fast tokens/month
- **Artisan:** $24/month (annual) — more tokens, advanced features
- Uses a token system; video generation (Veo 3 integration) consumes tokens rapidly
- Includes custom model training, Alchemy enhancement, Unified Canvas

---

## Section 3: Open-Source Options

### FLUX.1 / FLUX.2 — Black Forest Labs
- **FLUX.1 [schnell]:** 12B parameter rectified flow transformer; Apache 2.0 (free commercial use); generates in 1–4 steps
- **FLUX.1 [dev]:** 12B params; non-commercial license; guidance-distilled for efficiency
- **FLUX.1 Tools:** Fill (inpainting/outpainting), Depth, Canny, Redux (image variations)
- **FLUX.2 [dev]:** 32B model (November 2025); production-grade; improved anatomy, skin texture, lighting, complex compositions
- Black Forest Labs founded by former Stability AI researchers
- Video model (codename "SOTA") in development

### Stable Diffusion 3.5 — Stability AI
- Available in: Medium, Large (8B), and Turbo variants
- Improved text rendering within images vs. SDXL
- Replaces SD Cascade and SDXL as the Stability AI flagship
- Weights available on Hugging Face; free to self-host
- ComfyUI native support available

### SDXL (Stable Diffusion XL)
- Still the most widely used open-source image model by ecosystem size
- Deepest library of LoRAs, community checkpoints, and fine-tunes
- Technically superseded by SD 3.5 and Flux, but remains dominant in community workflows

### Other notable open-source options
- **DeepFloyd IF:** Multi-stage diffusion model with strong text rendering
- **StyleGAN variants:** Specialized for face/portrait generation

---

## Section 4: Quality Comparison

Based on the LM Arena Image Generation Leaderboard (December 2025, Elo-based human preference ranking):

| Rank | Model | Elo Score | Strength |
|------|-------|-----------|----------|
| 1 | Flux 2 Pro v1.1 | ~1,265 | Photorealism — professional photography aesthetic |
| 2 | GPT Image 1.5 | ~1,264 | Text rendering, prompt adherence |
| 3 | Midjourney V7 | — | Artistic coherence, composition, lighting |
| 4 | Gemini 3 Pro / Imagen 3 | — | Speed (3–5 sec), realism |
| 5 | Ideogram 3.0 | — | Typography accuracy (~90% vs. Midjourney's ~30%) |

**By use case:**
- **Photorealism / product photography:** Flux 2 Pro wins by a meaningful margin in 2026
- **Artistic/editorial imagery:** Midjourney V7 remains the gold standard for composition and aesthetic
- **Text in images (logos, signage, packaging, posters):** Ideogram 3.0 and GPT Image 1.5 (tied at the top)
- **Speed:** Gemini 3 Pro (3–5 sec), Flux 2 Flex (2–4 sec), FLUX.1 [schnell] (1–4 steps locally)
- **Overall prompt adherence:** GPT Image 1.5 and FLUX.2

---

## Section 5: Prompt Engineering Best Practices (2026)

### Universal Structure
Use a one-line goal + 4–6 high-signal detail descriptors covering: medium, style, lighting, framing, mood, palette.

**Weak:** `Fox, forest, autumn, misty, sunlight, 8k, best quality`
**Strong:** `A curious red fox exploring a misty autumn forest at dawn. Golden sunlight filters through colorful leaves, casting dappled shadows on the forest floor`

### Model-Specific Approaches
- **GPT Image 1 / ChatGPT:** Works best with paragraph-style natural language; supports multi-turn editing
- **Midjourney V7:** Prefers short, high-signal phrases + reference images; use `--v 7`; personalization models can learn your aesthetic
- **Stable Diffusion 3.5 / Flux:** Rewards structured, weighted keywords; supports negative prompts
- **Ideogram:** Supports direct text-in-image instructions; specify exact copy you want rendered

### Photography / Realism Techniques
- Specify **catchlight** for portraits: `catchlight in eyes`, `light reflecting in eyes` — prevents flat "dead" eyes
- Camera angles matter: low-angle = heroic/powerful; high-angle = vulnerable/small; Dutch angle = tension
- Name lighting setups: `Rembrandt lighting`, `golden hour`, `softbox lighting`, `studio lighting with rim light`
- Reference specific camera/lens combos: `shot on Canon EOS R5, 85mm f/1.4, shallow depth of field`

### Prompt Refinement
- Test each prompt across 3–5 generations; watch for anatomy errors, hallucinations, off-topic drift
- Simple prompts typically need 2–3 rounds of iteration
- For Midjourney: use `--sref` for style references, `--cref` for character consistency across images

### Marketing Asset Tips
- For brand consistency: use seed numbers (all platforms) and character reference images
- For ad copy integration: use Ideogram or GPT Image 1.5, specify font style and placement explicitly
- For product mockups: Flux 2 + depth/reference image for structural accuracy

---

## Section 6: Commercial Licensing Considerations

### Adobe Firefly — Strongest Commercial Protection
- Trained exclusively on Adobe Stock (licensed), openly licensed content, and public domain
- Enterprise subscribers get **indemnification** — Adobe protects clients against third-party copyright claims
- Non-beta outputs may be used commercially under all paid plans
- Industry trend: enterprise clients increasingly specify Firefly in project requirements
- More than 40% of professional designers cite copyright ambiguity as a reason to avoid certain AI tools

### OpenAI (GPT Image 1 / DALL-E 3)
- Full commercial rights included with API access
- No extra licensing fee for commercial use
- OpenAI's training data practices have faced scrutiny but no successful infringement actions against users to date

### Midjourney
- Paid subscribers receive commercial usage rights for generated images
- No explicit indemnification clause
- Ongoing lawsuits from artists over training data; legal landscape unsettled
- Millions of users generate commercial content daily without reported legal issues
- Stealth Mode (Pro/Mega) keeps images private

### Flux / FLUX.1
- **[schnell]:** Apache 2.0 — full commercial use, self-hosted free
- **[dev]:** Non-commercial license only (research/personal)
- **[pro] via API:** Commercial use permitted per Black Forest Labs API terms

### Stable Diffusion 3.5
- Stability AI Community License: free for commercial use under $1M annual revenue
- Enterprise license required above $1M revenue threshold
- Self-hosted weights: check per-model license on Hugging Face

### Ideogram & Leonardo.ai
- Both permit commercial use on paid plans
- Ideogram: outputs on paid tiers are commercially licensable
- Leonardo.ai: commercial rights on paid plans; check specific model licenses for third-party models hosted on the platform

### Key Risk Summary
| Tool | Indemnification | Training Data Transparency | Commercial Use |
|------|----------------|---------------------------|----------------|
| Adobe Firefly | Yes (enterprise) | High (Adobe Stock + licensed) | Yes (paid plans) |
| GPT Image 1 | No | Medium | Yes (API) |
| Midjourney V7 | No | Low (undisclosed) | Yes (paid plans) |
| Flux [schnell] | No | N/A (open weights) | Yes (Apache 2.0) |
| SD 3.5 | No | Medium | Yes (<$1M revenue) |
| Google Imagen 3 | No | Medium | Yes (API terms) |
| Ideogram 3.0 | No | Medium | Yes (paid plans) |

---

## Section 7: New Developments in Early 2026

### Major Releases and Updates (Jan–Mar 2026)
- **Midjourney V7** set as default (June 2025 for context); complete architectural overhaul with video generation capabilities, dedicated web editor, personalization models, image editing mode
- **GPT Image 1.5** released; currently leads LM Arena Elo at ~1,264; surpasses DALL-E 3 in all benchmarks
- **FLUX.2** (November 2025): 32B open-weight model by Black Forest Labs; addresses FLUX.1 limitations in anatomy, skin texture, lighting; production-grade quality
- **Ideogram 3.0** (March 2025): Near-perfect typography accuracy; improved realism beyond text rendering
- **Gemini 3 Pro Image** (Google DeepMind): Google's 2026 flagship image model for high realism and commercial production; 3–5 second generation times
- **Leonardo.ai + Canva integration:** Veo 3 model integration for video with sound/dialogue
- **Gamma Imagine** (announced March 17, 2026): Text-prompt-based brand asset generation (charts, marketing collateral, social graphics) — targeting Canva/Adobe

### Key Technological Trends in 2026
1. **4K output as standard** — no longer a premium feature; most top-tier models now output at 4K by default
2. **Text rendering solved** — readable text in images is now reliable across top models (Ideogram, GPT Image 1.5); removes a major barrier for marketing mockups, packaging, signage
3. **Real-time knowledge integration** — some 2026 models pull live web data during generation, enabling current-context product visuals
4. **Speed parity** — fastest models (Flux [schnell], Gemini 3 Pro) generate in 2–5 seconds without significant quality sacrifice
5. **Video generation convergence** — Black Forest Labs' SOTA model in development; video + image workflows merging in platforms like Leonardo.ai
6. **Market consolidation** — emphasis on professional-grade capabilities; smaller experimental tools being absorbed or discontinued

---

## Approaches Tried

- web_search: Midjourney v7 pricing
- web_search: DALL-E 3 / GPT Image 1 pricing
- web_search: Stable Diffusion 3.5 / Flux open source status
- web_search: Adobe Firefly pricing and commercial use
- web_search: Ideogram and Leonardo.ai pricing
- web_search: Google Imagen 3 pricing
- web_search: quality benchmarks 2026
- web_search: commercial licensing
- web_search: prompt engineering best practices
- web_search: 2026 new developments

---

## Open Questions

1. How does Gemini 3 Pro Image compare in real-world marketing workflows (vs. Midjourney/Firefly)?
2. What is the pricing trajectory — will API costs keep declining through 2026?
3. How do video generation tools (Sora, Runway, Kling, SOTA) complement image tools for full marketing content pipelines?

---

## Next Steps

- Optional: Research video generation tools comparison (Sora, Runway Gen-3, Kling, Leonardo Motion, Pika)
- Optional: Deep-dive per-tool workflow guides for marketing teams
- Optional: Benchmark Gemini 3 Pro Image in marketing use cases

---

## Session Timeline

**Session session-20260318 (2026-03-18):** Conducted comprehensive research sweep across all major AI image generation platforms via 10 web searches. Gathered grounded data on pricing, open-source status, quality benchmarks, commercial licensing, prompt engineering best practices, and early 2026 developments. Key finding: the 2026 landscape has matured significantly with clear leaders by use case — Flux 2 for photorealism, Midjourney V7 for artistic quality, GPT Image 1.5 for text rendering, Adobe Firefly for commercial safety, and Ideogram 3.0 for typography. Four convergent trends define 2026: 4K as standard, reliable text in images, real-time knowledge integration, and speed parity across top models.

---

## Sources

- [Comparing Midjourney Plans – Midjourney](https://docs.midjourney.com/hc/en-us/articles/27870484040333-Comparing-Midjourney-Plans)
- [Midjourney Pricing 2026: Plans, Costs & Reddit Verdict](https://www.aitooldiscovery.com/guides/midjourney-pricing)
- [Midjourney v7 NOT Released Yet: Still v6.1 in Feb 2026 (v7 Alpha Expected April)](https://leaveit2ai.com/ai-tools/image/midjourney)
- [OpenAI DALL-E & GPT Image Pricing Calculator (Mar 2026)](https://costgoat.com/pricing/openai-images)
- [OpenAI Image Pricing Calculator 2026 | GPT Image 1.5, GPT Image 1 & DALL-E](https://invertedstone.com/calculators/dall-e-pricing)
- [Pricing | OpenAI](https://openai.com/api/pricing/)
- [GPT Image 1 Model | OpenAI API](https://platform.openai.com/docs/models/gpt-image-1)
- [The Best Open-Source Image Generation Models in 2026](https://www.bentoml.com/blog/a-guide-to-open-source-image-generation-models)
- [Stable Diffusion 3.5 vs. Flux](https://modal.com/blog/best-text-to-image-model-article)
- [The 9 Best AI Image Generation Models in 2026](https://www.gradually.ai/en/ai-image-models/)
- [black-forest-labs/FLUX.1-dev · Hugging Face](https://huggingface.co/black-forest-labs/FLUX.1-dev)
- [Black Forest Labs - Creators of FLUX Image Generation](https://bfl.ai/)
- [Compare plans that include generative AI | Adobe Firefly](https://www.adobe.com/products/firefly/plans.html)
- [Adobe Firefly Pricing 2026: $9.99-$199.99/month | CostBench](https://costbench.com/software/ai-image-generators/adobe-firefly/)
- [Adobe Generative AI User Guidelines | Adobe Legal](https://www.adobe.com/legal/licenses-terms/adobe-gen-ai-user-guidelines.html)
- [Ideogram AI Review 2026: Best AI Image Generator for Perfect Text Rendering?](https://pxz.ai/blog/ideogram-ai-review-2026)
- [Leonardo.Ai Pricing: Individual, Team & API Plans | Leonardo.Ai](https://leonardo.ai/pricing)
- [AI Image Pricing 2026: Google Gemini vs. OpenAI GPT Cost Analysis | IntuitionLabs](https://intuitionlabs.ai/articles/ai-image-generation-pricing-google-openai)
- [Imagen 3 arrives in the Gemini API - Google Developers Blog](https://developers.googleblog.com/imagen-3-arrives-in-the-gemini-api/)
- [Imagen 3 | Generative AI on Vertex AI | Google Cloud Documentation](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/imagen/3-0-generate)
- [Best AI Image Generators in 2026: Complete Comparison Guide | WaveSpeedAI](https://wavespeed.ai/blog/posts/best-ai-image-generators-2026/)
- [Best AI Image Generators (2026): A Honest Test & Review | getimg.ai](https://getimg.ai/blog/best-ai-image-generator)
- [AI Image Generation API Comparison 2026: Pricing, Quality, and the Best Value Pick](https://blog.laozhang.ai/en/posts/ai-image-generation-api-comparison-2026)
- [Adobe Firefly vs Midjourney 2026: Which Is Best?](https://pxz.ai/blog/adobe-firefly-vs-midjourney-2026)
- [Adobe Firefly Indemnification: What It Means and Why It Matters | LicenseOrg](https://www.licenseorg.com/blog/adobe-firefly-indemnification-explained)
- [Stability AI - Developer Platform](https://platform.stability.ai/pricing)
- [Stable Diffusion in 2026: Features, Pricing, License, and Alternatives](https://merlio.app/blog/stable-diffusion-features-pricing-license-and-alternatives)
- [How to write AI image prompts like a pro [2026]](https://letsenhance.io/blog/article/ai-text-prompt-guide/)
- [The 8 best AI image generators in 2026 | Zapier](https://zapier.com/blog/best-ai-image-generator/)
- [2026 AI Image Generation Trends: 4K Output and Real-Time Grounding](https://northpennnow.com/news/2026/mar/08/2026-ai-image-generation-trends-why-4k-output-and-real-time-grounding-are-changing-everything-for-creators/)
- [Gamma adds AI image-generation tools in bid to take on Canva and Adobe | TechCrunch](https://techcrunch.com/2026/03/17/gamma-adds-ai-image-generation-tools-in-bid-to-take-on-canva-and-adobe/)
- [Best AI Image Generation Tools 2026: DALL-E vs Midjourney vs Stable Diffusion - Gurkha Technology](https://gurkhatech.com/ai-image-generation-tools-2026/)
- [Best AI Ad Creative Generator: Top 7 Tools 2026 Guide](https://www.cometly.com/post/best-ai-ad-creative-generator)
