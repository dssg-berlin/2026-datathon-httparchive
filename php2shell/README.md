# PHP2Shell analysis with HTTP Archive

Empirical check of the media claim that "roughly 70% of the internet" was affected by PHP2Shell (CVE-2026-109618 / CVE-2026-109619).

## Findings (2025-09-01 crawl)

- Overall PHP presence: **~52%** of origins (desktop 51.8%, mobile 52.1%)
- Only ~30% of PHP origins still broadcast a version string
- PHP share rises sharply from Top 1k (~14–20%) to the **long tail (~52%)**
- Long tail = small businesses, blogs, local shops, non-profits, schools (mainly WordPress + shared hosting)

## Files

| File | Description |
|------|-------------|
| `sql/01_php_adoption.sql` | Overall PHP adoption (cost-conscious) |
| `sql/02_php_by_rank.sql` | Rank-bucket breakdown (Top 1k → Long tail) |
| `sql/03_version_headers.sql` | Version strings from X-Powered-By / Server |
| `sql/04_major_versions_over_time.sql` | Major-version trends |
| `viz/plot_longtail.py` | Long-tail concentration chart |
| `viz/plot_versions_over_time.py` | Major PHP versions over time |

## How to run

1. BigQuery project with access to `httparchive.crawl` (e.g. public data).
2. Run the SQL files in order; export results as CSV if needed for the plots.
3. `pip install matplotlib numpy` then run the Python scripts in `viz/`.

Project used in the datathon: `httparchive-bigquery-495520`.

## Related

- Report and pitch materials from DSSG Berlin datathon
- Almanac 2025 Security chapter confirms version leakage (PHP/7.4.33 dominant in X-Powered-By)
