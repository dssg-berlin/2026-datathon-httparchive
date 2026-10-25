-- Major PHP version buckets over selected crawl dates
-- For trend visualisation (2023–2026)

SELECT
  date,
  CASE
    WHEN version LIKE '5.%' THEN '5.x'
    WHEN version LIKE '7.%' THEN '7.x'
    WHEN version LIKE '8.0%' THEN '8.0'
    WHEN version LIKE '8.1%' THEN '8.1'
    WHEN version LIKE '8.2%' THEN '8.2'
    WHEN version LIKE '8.3%' THEN '8.3'
    WHEN version LIKE '8.4%' THEN '8.4'
    WHEN version LIKE '8.5%' THEN '8.5'
    ELSE 'other'
  END AS major_version,
  COUNT(DISTINCT root_page) AS origins
FROM `httparchive.crawl.pages`,
UNNEST(technologies) AS t,
UNNEST(t.info) AS version
WHERE date IN ('2023-01-01', '2024-01-01', '2025-01-01', '2026-01-01', '2026-10-01')
  AND is_root_page
  AND t.technology = 'PHP'
  AND version IS NOT NULL AND version != ''
GROUP BY date, major_version
ORDER BY date, major_version;
