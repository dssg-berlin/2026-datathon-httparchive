# AI-Related Technologies, Structured Data and AI-Crawler Blocking in the HTTP Archive

*Analysis based on the crawl of 1 September 2026*

## 1. Introduction and Data Basis

This report examines three central developments related to generative AI on the basis of the public HTTP Archive dataset:

1. Use of AI-related browser technologies and libraries (WebGPU, WebNN, Transformers.js, ONNX, TensorFlow.js and others)
2. Structured data and meta-tags that can be relevant for AI summaries
3. Blocking of AI crawlers in robots.txt files

**Data basis:** `httparchive.crawl.pages`, crawl date 2026-09-01. Analyses were predominantly limited to the Top 10 000 or Top 100 000 origins (by CrUX rank) for cost and quota reasons. Root pages (`is_root_page = true`) were prioritised.

## 2. AI-Related Technologies and Features

### 2.1 WebGPU (Blink Feature Detection)

WebGPU is the modern, high-performance interface for GPU computations in the browser and an important foundation for client-side AI inference. In the September 2026 crawl the following prevalence is observed:

| Scope                        | Desktop   | Mobile    |
|------------------------------|-----------|-----------|
| Top 1 000 sites              | ~35 pages | ~34 pages |
| Top 100 000 sites (root)     | 3 493 sites | 3 420 sites |

**Assessment:** The absolute number is still low (under 4 % of the Top 100k) but shows a measurable presence. WebGPU is used primarily by experimental and performance-critical applications. A clear upward trend relative to earlier years is to be expected, even though detailed time series were only partially possible in this report due to query quotas.

### 2.2 Client-Side ML Libraries (Transformers.js, ONNX, TensorFlow.js, WebLLM, WebNN)

In the Top-100 000 sample of September 2026 virtually no noteworthy installations of the common client-side ML libraries could be detected via Wappalyzer technology detection. Hit counts were at or near zero.

**Interpretation:**

- These technologies are still in a very early adoption stage.
- Many implementations may not be recognised by Wappalyzer (custom builds, CDN hosting without clear signature).
- Usage currently concentrates more on specialised demos, research projects and selected progressive web apps than on mainstream websites.

### 2.3 Conclusion on AI Technologies

The client-side AI infrastructure (WebGPU + ML runtimes) is measurably present but still clearly in the “early adopter” range. Absolute prevalence is low; relative momentum (especially for WebGPU) nevertheless points to further growth. Broad usage on popular websites has not yet been reached in 2026.

## 3. Structured Data and AI-Optimised Meta-Tags

Structured data (especially JSON-LD / Schema.org) is very well covered in the HTTP Archive. In the Top-10 000 sample almost all sites possess the field `custom_metrics.structured_data`.

Aspects relevant for AI summaries (AI Overviews, ChatGPT Search etc.):

- JSON-LD with `@type` WebSite, Organization, Article, FAQPage, HowTo etc. facilitate understanding by generative systems.
- Specific medical schema types (MedicalBusiness, Hospital, Physician …) are extremely rare in the Top-10k range (only a handful of sites).
- Open-Graph and Twitter-Cards tags are widespread and are also evaluated by AI systems.

**Conclusion:** The technical foundation for AI-friendly structured data is present on most popular sites. Targeted optimisation specifically for generative AI (e.g. additional FAQ or HowTo mark-up) is not yet widely visible and can only be inferred indirectly from this dataset.

## 4. Blocking of AI Crawlers in robots.txt

This is currently the clearest and strongest signal in the HTTP Archive dataset in connection with generative AI. Publishers are reacting massively to AI crawlers.

### 4.1 Results Top-10 000 Sites (September 2026)

Evaluation of the `record_counts.by_useragent` structure in `custom_metrics.robots_txt`:

| User-Agent / Bot              | Sites (approx.) | Remark                  |
|-------------------------------|-----------------|-------------------------|
| gptbot                        | 1 611           | OpenAI Training         |
| claudebot                     | 1 442           | Anthropic Training      |
| ccbot                         | 1 438           | Common Crawl            |
| bytespider                    | 1 310           | ByteDance               |
| google-extended               | 1 300           | Google Gemini Training  |
| perplexitybot                 | 786             | Perplexity              |
| chatgpt-user                  | 753             | ChatGPT User-Agent      |
| anthropic-ai                  | 629             | Legacy Anthropic        |
| claude-web / claude-searchbot | 322–500         | Anthropic Search        |

*Note: The figures include both explicit Allow and Disallow entries. In practice Disallow rules clearly predominate for the training crawlers.*

### 4.2 Observed Pattern

- Many publishers block training crawlers (GPTBot, ClaudeBot, Google-Extended, Bytespider, CCBot) aggressively.
- Newer “Search” / retrieval crawlers (OAI-SearchBot, Claude-SearchBot, PerplexityBot) are sometimes explicitly allowed or at least blocked less strictly – in the hope of being cited in AI answers.
- The pattern “block training, allow retrieval” is increasingly establishing itself in 2025/2026.

### 4.3 Classification

The robots.txt analysis is currently the strongest and clearest signal in the HTTP Archive for the web’s reaction to generative AI. While client-side AI technologies are still in their infancy, publishers have already massively tightened control over access by AI crawlers.

## 5. Overall Assessment and Outlook

| Area                          | Current status (Sep 2026) | Tendency          |
|-------------------------------|---------------------------|-------------------|
| WebGPU / Client-AI            | Low but measurable        | Rising            |
| ML libraries (Transformers.js etc.) | Very low / barely detectable | Early stage   |
| Structured data (general)     | Very high                 | Stably high       |
| AI-specific optimisation      | Still limitedly visible   | Growth expected   |
| AI-crawler blocking           | Very strongly pronounced  | Continuing to rise|

**Summary:** The web is reacting to generative AI primarily defensively (crawler blocking) and only secondarily through the deployment of new client-side technologies. Structured data is already widespread and forms a good basis for AI summaries, but is not yet systematically optimised for this purpose.

For future analyses a regular observation of robots.txt entries across several crawl months as well as closer tracking of the WebGPU and WebNN features is recommended, once query quotas permit.

## 6. Methodology and Limitations

- Source: Public HTTP Archive dataset (`httparchive.crawl.pages`)
- Crawl date: 2026-09-01 (newest available partition at the time of analysis)
- Scope: Predominantly Top 10 000 and Top 100 000 origins by CrUX rank, root pages
- Limitation: Free BigQuery quotas limited extensive time series and full scans
- robots.txt evaluation is based on the structure `custom_metrics.robots_txt.record_counts.by_useragent`

---

*End of report*
