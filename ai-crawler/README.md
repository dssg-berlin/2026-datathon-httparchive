# Generative AI impact on internet infrastructure (HTTP Archive)

This project quantifies how the web is reacting to generative AI using the public HTTP Archive dataset (crawl 2026-09-01). It focuses on three signals:

1. AI-related browser technologies (WebGPU, client-side ML libraries)
2. Structured data relevant to AI summaries
3. Blocking of AI training and retrieval crawlers in robots.txt

The analysis demonstrates that HTTP Archive data can measure the infrastructure-level impact of generative AI — primarily a strong *defensive* response (robots.txt blocking) rather than widespread client-side AI adoption.

Framing inspired by the HBS AI Institute article [“The Internet is Eating Itself – and AI is Holding the Fork”](https://aiinstitute.hbs.edu/the-internet-is-eating-itself-and-ai-is-holding-the-fork/).

## Key findings (Top sites, Sep 2026)

| Signal | Magnitude | Interpretation |
|--------|-----------|----------------|
| AI training crawler blocking (GPTBot etc.) | ~23 % of Top-10k | Strong defensive response by publishers |
| Client-side AI (WebGPU) | < 4 % of Top-100k | Still early-adopter stage |
| Traditional trackers / analytics | ~83–85 % of Top-10k | Legacy measurement & monetisation economy intact |
| ML libraries (Transformers.js, ONNX, …) | ~0 % (detectable) | Virtually invisible in mainstream sites |

**Core message:** The web is reacting *defensively* (robots.txt blocking of training crawlers) far more strongly than it is adopting client-side AI technologies.

## Project structure

```text
ai-crawler/
├── REPORT.md                  # Full English analysis report
├── figures/                   # Visualisations (English labels)
│   ├── viz1_ai_crawler_blocking.png
│   ├── viz2_defensive_vs_proactive.png
│   ├── viz3_web_economy_pie.png
│   ├── viz4_dashboard_summary.png
│   └── viz5_gptbot_blocking_trend.png
└── sql/                       # Reusable BigQuery queries (rank-limited)
    ├── 01_webgpu.sql
    └── 02_ai_bots_robots.txt.sql
```

## Running the queries

Use a Google Cloud project with BigQuery access to the public HTTP Archive dataset. Always filter on `date = '2026-09-01'` (or the desired partition) and preferably `rank <= N` + `is_root_page` to stay within free-tier quotas.

Example pattern used throughout:

```sql
WHERE date = '2026-09-01'
  AND is_root_page
  AND rank <= 10000
  AND client IN ('desktop', 'mobile')
```

## Data and interpretation

- Source: `httparchive.crawl.pages` (public HTTP Archive).
- Scope: predominantly Top 10k / Top 100k origins by CrUX rank, root pages.
- robots.txt evaluation uses `custom_metrics.robots_txt.record_counts.by_useragent`.
- Free BigQuery quotas limited full-table scans and long time series; most analyses are rank-limited.
- See the HTTP Archive [website](https://httparchive.org/), its [methodology](https://httparchive.org/docs/), and the [Web Almanac](https://almanac.httparchive.org/) for source context.

## Relation to the php2shell workstream

This folder is a parallel analysis track inside the same Datathon repository. The php2shell work examines PHP presence and version disclosure; this track examines the measurable infrastructure reaction to generative AI crawlers and client-side AI technologies.
