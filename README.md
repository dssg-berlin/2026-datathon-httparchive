# HTTP Archive — DSSG Berlin Datathon 2026

> Analyzing web infrastructure to build scalable open-data products for social impact

**Part of the 8th DSSG Berlin Datathon** (23–25 October 2026)  
in collaboration with **DSSG NYC** (Data Diplomats for Nonprofits)

---

## About the Project

[HTTP Archive](https://httparchive.org/) is an open-source research initiative that tracks how the web is built. It monitors performance, accessibility, technology adoption, and more across millions of websites (currently ~17–24+ million pages depending on the crawl).

The public dataset lives in BigQuery and is enormous (~244 TB).  
During this Datathon we will explore it to solve key **digital maturity** and **web performance** challenges and prototype open-data products that create social impact.

This is the start of a multi-phase collaboration between DSSG Berlin and HTTP Archive. The Datathon is the exploratory / prototyping phase; a longer-term project may follow.

### What volunteers will do
- Explore and analyze the HTTP Archive BigQuery dataset
- Brainstorm data solutions and open-data products
- Build prototypes and present findings

---

## Event Details

| | |
|---|---|
| **Dates** | Friday 23 – Sunday 25 October 2026 |
| **Format** | Fully remote |
| **Kick-off** | Fri 6:00 PM CEST / 12:00 PM ET |
| **Hacking** | ~24 hours |
| **Final pitches** | Sunday afternoon |
| **Communication** | Slack + Google Meet |

**Registration**: [Eventbrite – Virtual AI for Good Datathon](https://www.eventbrite.de/e/virtual-ai-for-good-datathon-hosted-by-dssg-berlin-dssg-nyc-tickets-1993605979150)

---

## Key Resources

- [HTTP Archive website](https://httparchive.org/)
- [HTTP Archive methodology](https://httparchive.org/docs/)
- [BigQuery public datasets](https://console.cloud.google.com/bigquery?p=httparchive) (project `httparchive`)
- [HAR.fyi – data model & docs](https://har.fyi)
- [Web Almanac](https://almanac.httparchive.org/) (yearly deep-dive reports)
- [Core Web Vitals Tech Report](https://httparchive.org/reports/core-web-vitals)
- Useful notebooks: [exploring crawl.requests tables](https://colab.research.google.com/github/HTTPArchive/httparchive.org/blob/main/workbooks/exploring_httparchive-crawl-requests_tables.ipynb)

### Important BigQuery notes
- The dataset is **very large** — always filter by `date` and `client` (`desktop` / `mobile`) and use partitioning/clustering best practices.
- Free BigQuery quota is 1 TB/month of processed data. Be careful with `SELECT *` and large tables (`requests`, response bodies, etc.).
- Main datasets of interest: `httparchive.crawl.*`, summary tables, Lighthouse, technologies, etc.

---

## Repository Structure (to be expanded during the event)

├── README.md
├── notebooks/          # Exploratory analysis
├── queries/            # Reusable BigQuery SQL
├── prototypes/         # Dashboards, tools, open-data products
├── docs/               # Findings, methodology notes
└── presentations/      # Pitch slides & final outputs

---

## Getting Started

1. Join the Datathon Slack (link shared after registration).
2. Make sure you have a Google Cloud account with BigQuery access.
3. Clone this repo and create a branch for your team/workstream.
4. Start with small, filtered queries (always include a recent `date = 'YYYY-MM-01'`).
5. Document interesting findings and ideas in `docs/` or Issues.

---

## Code of Conduct

We follow the [Berlin Code of Conduct](https://berlincodeofconduct.org/).  
DSSG Berlin and DSSG NYC are inclusive communities — everyone is welcome regardless of background, identity, or experience level.

---

## Organizers & Partners

- **DSSG Berlin** — [dssg-berlin.github.io](https://dssg-berlin.github.io/) · dssgber@gmail.com
- **DSSG NYC** — [nyc-dssg.org](https://www.nyc-dssg.org/)
- **HTTP Archive** — [httparchive.org](https://httparchive.org/)

---

**Happy hacking!** 🚀  
Let’s turn web data into social impact.
