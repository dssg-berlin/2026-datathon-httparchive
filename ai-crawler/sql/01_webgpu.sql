-- WebGPU adoption (desktop vs mobile) – rank-limited for cost control
-- Replace date if a newer partition is available

SELECT
  client,
  COUNT(DISTINCT page) AS pages_with_webgpu,
  COUNT(DISTINCT IF(is_root_page, root_page, NULL)) AS sites_with_webgpu
FROM `httparchive.crawl.pages`,
UNNEST(features) AS f
WHERE
  date = '2026-09-01'
  AND f.feature = 'WebGPU'
  AND rank <= 100000
GROUP BY client
ORDER BY client;
