-- Version strings from response headers (X-Powered-By / Server)
-- Used to estimate how many PHP sites still look unpatched

SELECT
  client,
  REGEXP_EXTRACT(h.value, r'(?i)PHP[/ ]?([\d.]+)') AS php_version,
  COUNT(DISTINCT page) AS origins
FROM `httparchive.crawl.requests`,
UNNEST(response_headers) AS h
WHERE date = '2025-09-01'
  AND is_root_page
  AND is_main_document
  AND LOWER(h.name) IN ('x-powered-by', 'server')
  AND REGEXP_CONTAINS(h.value, r'(?i)PHP')
GROUP BY client, php_version
ORDER BY origins DESC
LIMIT 40;
