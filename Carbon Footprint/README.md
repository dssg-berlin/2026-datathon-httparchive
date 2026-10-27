# Web Sustainability & Digital Carbon Footprint Analysis

This repository contains a data-driven sustainability analysis investigating the environmental impact and carbon intensity of web page transfers. Built for the **DSSG Berlin Datathon 2026**, this project evaluates web bloat, identifies key drivers of page weight, compares mobile versus desktop footprint disparities, and models potential carbon reductions using historical crawl data from the **HTTP Archive**.

---

## 📌 Project Overview

Digital infrastructure, data centers, and network transmission account for a significant portion of global energy consumption. Each time a web page loads, data is transferred across servers and cellular networks, consuming electricity and emitting carbon dioxide equivalent ($\text{CO}_2\text{e}$).

Using the **Sustainable Web Design (SWD v4)** model, this project analyzes a dataset of **1,000 of the most carbon-intensive web page loads** from May 2024 to answer three main research questions:
1. What is the environmental cost of extreme web page bloat?
2. Which asset types (images, videos, or scripts/code) drive digital carbon emissions?
3. How does device type (Mobile vs. Desktop) impact carbon footprint?

---

## 📁 Repository Structure

```text
Carbon Footprint/
├── DSSGHackathon 2026 October.ipynb         # Jupyter Notebook for EDA, data cleaning, and visualization
├── http_archive.sql                         # BigQuery SQL query extracting page weights from HTTP Archive
├── Top_carbon_intensive_website.png         # Chart: Top 10 carbon-intensive web pages
├── video_image_pie_chart.png                # Chart: Page payload breakdown by asset type
└── mobile_vs_desktop_carbon_footprint.png   # Chart: Mobile vs. Desktop emissions comparison
```

---

## 🧮 Methodology & Carbon Model

### Data Source
Data was queried directly from Google BigQuery via the public HTTP Archive dataset:
* **Table:** `httparchive.crawl.pages`
* **Crawl Date:** `2024-05-01` (`is_root_page = TRUE`)
* **Sampling:** 2% system sample filtered for top carbon-intensive homepages.

### Sustainable Web Design Model (SWD v4)
Emissions per page view are calculated using the standard SWD factor:
$$\text{Emissions (gCO}_2\text{e)} = \text{Bytes Transferred} \times 0.00000008644 \text{ gCO}_2\text{e/byte}$$

$$\text{Total MB} = \frac{\text{Bytes Total}}{1024 \times 1024}$$

---

## 📊 Key Findings

| Metric | Sample Value (n=1,000) |
| :--- | :--- |
| **Mean Page Size** | **85.56 MB** (Median: 78.96 MB, Max: 215.30 MB) |
| **Mean Carbon Footprint per View** | **7.75 gCO₂e** (Median: 7.16 g, Max: 19.51 g) |
| **Media Weight Share (Images + Video)** | **94.2%** of total page payload |
| **Mobile vs. Desktop Disparity** | Mobile pages are **33.6% heavier** on average |
| **Simulated Carbon Savings** | **23.2% total reduction** via 30% image compression |

### Core Insights
1. **Media Dominance (94.2%):** Uncompressed images represent **76.7%** of total page payload, while video accounts for **17.5%**. Code, text, HTML, CSS, and fonts combined account for only **5.8%**.
2. **Mobile Environment Penalty:** 773 out of the top 1,000 heavy pages (**77.3%**) were served on mobile clients. Mobile homepages averaged **90.74 MB** (**8.22 gCO₂e/view**) compared to desktop homepages at **67.91 MB** (**6.15 gCO₂e/view**).
3. **Outlier Impact:** The single heaviest site (`cifi-tools.azurewebsites.net`) reached **215.30 MB** (**19.51 gCO₂e** per single view)—over 100 times heavier than the global web median ($\sim 1.8 \text{ MB}$).

---

## 🛠️ Reproduction & Usage

### Prerequisites
Install the required dependencies using pip:
```bash
pip install pandas matplotlib seaborn plotly
```

### Running the SQL Query in BigQuery
Execute the `http_archive.sql` query in Google BigQuery console.


### Executing the Analysis Notebook
Open `Carbon Footprint/DSSGHackathon 2026 October.ipynb` in Jupyter Notebook, VS Code, or Google Colab to regenerate the figures.

---

## 🤝 Contribution & Acknowledgments

Contributed as part of the **DSSG Berlin Datathon 2026** HTTP Archive workstream.

