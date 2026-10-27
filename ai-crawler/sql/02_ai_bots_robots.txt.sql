-- Most common AI-related User-Agents in robots.txt (Top-10k)
-- Schema uses record_counts.by_useragent

SELECT
  LOWER(ua) AS user_agent,
  COUNT(DISTINCT root_page) AS sites
FROM `httparchive.crawl.pages`,
UNNEST(JSON_KEYS(custom_metrics.robots_txt.record_counts.by_useragent)) AS ua
WHERE
  date = '2026-09-01'
  AND is_root_page
  AND rank <= 10000
  AND (
    LOWER(ua) LIKE '%gptbot%'
    OR LOWER(ua) LIKE '%claude%'
    OR LOWER(ua) LIKE '%anthropic%'
    OR LOWER(ua) LIKE '%google-extended%'
    OR LOWER(ua) LIKE '%perplexity%'
    OR LOWER(ua) LIKE '%chatgpt%'
    OR LOWER(ua) LIKE '%ccbot%'
    OR LOWER(ua) LIKE '%bytespider%'
  )
GROUP BY user_agent
ORDER BY sites DESC
LIMIT 50;
