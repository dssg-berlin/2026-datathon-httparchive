-- PHP presence by popularity rank (long-tail analysis)
-- Shows why overall ~52% is driven by the long tail

SELECT
  client,
  CASE
    WHEN rank <= 1000 THEN 'Top 1k'
    WHEN rank <= 10000 THEN 'Top 10k'
    WHEN rank <= 100000 THEN 'Top 100k'
    WHEN rank <= 1000000 THEN 'Top 1M'
    ELSE 'Long tail'
  END AS rank_bucket,
  COUNT(DISTINCT root_page) AS total_origins,
  COUNT(DISTINCT IF(
    EXISTS(SELECT 1 FROM UNNEST(technologies) t WHERE t.technology = 'PHP'),
    root_page, NULL
  )) AS php_origins,
  ROUND(100 * COUNT(DISTINCT IF(
    EXISTS(SELECT 1 FROM UNNEST(technologies) t WHERE t.technology = 'PHP'),
    root_page, NULL
  )) / COUNT(DISTINCT root_page), 2) AS pct_php
FROM `httparchive.crawl.pages`
WHERE date = '2025-09-01'
  AND is_root_page
GROUP BY client, rank_bucket
ORDER BY client, MIN(rank);
