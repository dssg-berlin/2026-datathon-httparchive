# PHP-to-Shell vulnerability and HTTP Archive insights

This project examines PHP adoption and version disclosure in HTTP Archive data
in the context of the PHP-to-Shell vulnerability claims. It brings together
the 2025 and 2026 analyses contributed by Elena and Benjamin Senst.

## Findings

The 2025-09 crawl showed PHP on about 52% of origins (51.8% desktop and 52.1%
mobile); roughly 30% of PHP origins disclosed a version. The 2026 analysis
showed PHP presence at 47.90% on desktop and 47.31% on mobile. The analysis
also highlights continued exposure from outdated versions, including PHP
7.4.33. These are measurements of PHP presence and version disclosure, not
proof that every PHP site is vulnerable.

## Project structure

```text
php2shell/
├── data/
│   ├── 2025/                  # PHP presence and version disclosure CSVs
│   └── 2026/
├── figures/
│   ├── 2025/                  # Charts generated from the 2025 analysis
│   └── 2026/
├── notebooks/                 # Year-specific exploratory analyses
├── notes/                     # Methodology and interpretation notes
├── sql/                       # Reusable BigQuery queries
└── viz/                       # Standalone visualization scripts
```

## Running the analysis

Install the local notebook and visualization dependencies:

```bash
python -m pip install jupyter pandas matplotlib numpy
```

### Notebooks

Run from this directory to resolve the notebooks' relative data paths:

```bash
cd php2shell/notebooks
jupyter notebook
```

Open `php-analysis-2025.ipynb` or `php-analysis-2026.ipynb`. The notebooks
expect the corresponding CSV exports under `../data/<year>/`.

### BigQuery queries

Use a Google Cloud project with BigQuery access to the public HTTP Archive
dataset. The queries in `sql/` include a project example, but can be run from
any project with dataset access. Review the date and filtering conditions
before running; query costs depend on the selected crawl and tables.

### Visualization scripts

Install the Python dependencies and run either script from any working
directory:

```bash
python php2shell/viz/plot_longtail.py
python php2shell/viz/plot_versions_over_time.py
```

Generated charts are saved to `figures/2025/` and `figures/2026/`,
respectively. The chart series in `plot_versions_over_time.py` are illustrative;
replace them with exact exports from `sql/04_major_versions_over_time.sql`
before treating the chart as a data result.

## Data and interpretation

- The CSV files are exported analysis results; query definitions are in `sql/`.
- `notes/considerations.md` records comparative interpretation and caveats.
- PHP presence and a disclosed version alone do not establish exploitability.
- See the HTTP Archive [website](https://httparchive.org/), its
  [methodology](https://httparchive.org/docs/), and the
  [Web Almanac](https://almanac.httparchive.org/) for source context.
