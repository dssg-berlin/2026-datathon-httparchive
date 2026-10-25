-- Overall PHP adoption (cost-conscious: one month, root pages only)
-- Dataset: httparchive.crawl.pages
-- Project example: httparchive-bigquery-495520

SELECT
  client,
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
GROUP BY client
ORDER BY client;
