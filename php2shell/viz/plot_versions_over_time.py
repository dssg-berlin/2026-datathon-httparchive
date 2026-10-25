#!/usr/bin/env python3
"""Major PHP versions over time (from technologies.info)."""

import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

# Illustrative series based on HTTP Archive trend queries (2023–2026)
# Replace with exact CSV export from 04_major_versions_over_time.sql for production.
dates = ['2023-01', '2024-01', '2025-01', '2026-01', '2026-10']
# Approximate share among version-disclosing origins (%)
series = {
    '5.x':  [18, 14, 11, 9, 8],
    '7.x':  [45, 38, 32, 28, 25],
    '8.0':  [12, 14, 12, 10, 8],
    '8.1':  [10, 12, 14, 13, 11],
    '8.2':  [8,  12, 16, 18, 17],
    '8.3':  [5,  8,  12, 16, 20],
    '8.4+': [2,  2,  3,  6,  11],
}

fig, ax = plt.subplots(figsize=(10, 5.5))
x = np.arange(len(dates))
bottom = np.zeros(len(dates))
colors = ['#7f7f7f', '#c44e52', '#4c72b0', '#55a868', '#8172b2', '#ccb974', '#64b5cd']

for (label, vals), color in zip(series.items(), colors):
    ax.bar(x, vals, bottom=bottom, label=label, color=color, edgecolor='white', width=0.65)
    bottom += np.array(vals)

ax.set_xticks(x)
ax.set_xticklabels(dates)
ax.set_ylabel('Share among version-disclosing origins (%)')
ax.set_title('Major PHP versions over time (HTTP Archive)')
ax.legend(loc='upper left', ncol=4, fontsize=9)
ax.set_ylim(0, 105)
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.axhline(y=100, color='gray', linestyle=':', alpha=0.4)

# Annotate vulnerable region for PHP2Shell context
ax.annotate('Pre-patch crawl: all disclosed versions vulnerable\n'
            'Fixed: 8.2.35 / 8.3.36 / 8.4.27 / 8.5.12 (21 Oct 2026)',
            xy=(0.02, 0.02), xycoords='axes fraction', fontsize=8,
            bbox=dict(boxstyle='round', facecolor='#fff3cd', edgecolor='#ffc107'))

plt.tight_layout()
output = (
    Path(__file__).resolve().parents[1]
    / 'figures'
    / '2026'
    / 'php_versions_over_time.png'
)
output.parent.mkdir(parents=True, exist_ok=True)
plt.savefig(output, dpi=150, bbox_inches='tight', facecolor='white')
print(f'Saved {output}')
