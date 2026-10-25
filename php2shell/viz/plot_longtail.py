#!/usr/bin/env python3
"""Long-tail PHP concentration chart (HTTP Archive rank buckets)."""

import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

# Approximate averages from 2025-09-01 crawl (desktop + mobile midpoints)
buckets = ['Top 1k', 'Top 10k', 'Top 100k', 'Top 1M', 'Long Tail']
pct_php = [16.7, 25.7, 34.7, 43.9, 52.5]

# Approximate absolute PHP origins (millions)
origins_m = [0.0007, 0.006, 0.06, 0.7, 13.1]
php_origins_m = [p / 100 * o for p, o in zip(pct_php, origins_m)]

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(13, 5.5))
colors = ['#2E86AB', '#2E86AB', '#A23B72', '#F18F01', '#C73E1D']

# Left: percentage
bars = ax1.bar(buckets, pct_php, color=colors, edgecolor='white', linewidth=0.8)
ax1.set_ylabel('Share of PHP detections (%)')
ax1.set_title('PHP share by popularity rank\n(HTTP Archive, 2025-09 crawl)')
ax1.set_ylim(0, 65)
ax1.axhline(y=52, color='gray', linestyle='--', alpha=0.5)
ax1.text(4.3, 53.5, 'Overall ~52%', fontsize=8, color='gray')
for bar, val in zip(bars, pct_php):
    ax1.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 1.2,
             f'{val:.0f}%', ha='center', va='bottom', fontsize=10, fontweight='bold')
ax1.spines['top'].set_visible(False)
ax1.spines['right'].set_visible(False)

# Right: absolute volume
bars2 = ax2.bar(buckets, php_origins_m, color=colors, edgecolor='white', linewidth=0.8)
ax2.set_ylabel('PHP origins (millions, approximate)')
ax2.set_title('Where does the absolute PHP volume sit?\n(Long Tail dominates)')
for bar, val in zip(bars2, php_origins_m):
    label = f'{val:.1f}M' if val >= 0.1 else f'{val:.2f}M'
    ax2.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.15,
             label, ha='center', va='bottom', fontsize=9, fontweight='bold')
ax2.spines['top'].set_visible(False)
ax2.spines['right'].set_visible(False)

textstr = ('Long Tail = small businesses, blogs,\n'
           'local shops, non-profits, schools \u2026\n'
           '\u2192 mainly WordPress + shared hosting')
props = dict(boxstyle='round,pad=0.4', facecolor='#FFF3E0', edgecolor='#F18F01', alpha=0.95)
ax2.text(0.02, 0.97, textstr, transform=ax2.transAxes, fontsize=8.5,
         verticalalignment='top', bbox=props)

fig.suptitle('PHP2Shell risk is heavily concentrated in the Long Tail',
             fontsize=14, fontweight='bold', y=1.02)
fig.text(0.5, -0.02,
         'Source: HTTP Archive rank buckets \u00b7 PHP detection via Wappalyzer \u00b7 '
         'Absolute numbers approximated from crawl sizes\n'
         'Note: Visible detections only; many large sites hide their technology stack.',
         ha='center', fontsize=8, style='italic', color='#555')

plt.tight_layout()
output = (
    Path(__file__).resolve().parents[1]
    / 'figures'
    / '2025'
    / 'php_longtail_vulnerability.png'
)
output.parent.mkdir(parents=True, exist_ok=True)
plt.savefig(output, dpi=150, bbox_inches='tight', facecolor='white')
print(f'Saved {output}')
