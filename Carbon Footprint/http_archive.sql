WITH page_metrics AS (
  SELECT
    date,
    client,
    page,
    rank,
    CAST(JSON_EXTRACT_SCALAR(summary, '$.bytesTotal') AS INT64) AS bytes_total,
    CAST(JSON_EXTRACT_SCALAR(summary, '$.bytesImg') AS INT64) AS bytes_img,
    CAST(JSON_EXTRACT_SCALAR(summary, '$.bytesVideo') AS INT64) AS bytes_video
  FROM
    `httparchive.crawl.pages` TABLESAMPLE SYSTEM (2 PERCENT)
  WHERE
    date = '2024-05-01'
    AND is_root_page = TRUE
)
SELECT
  page,
  client,
  rank,
  ROUND(bytes_total / (1024 * 1024), 2) AS total_mb,
  -- Calculate carbon emissions per view (gCO2e)
  ROUND(bytes_total * 0.00000008644, 4) AS co2_grams_per_view,
  -- Proportion of weight driven by media assets
  ROUND((bytes_img / GREATEST(bytes_total, 1)) * 100, 2) AS img_weight_pct,
  ROUND((bytes_video / GREATEST(bytes_total, 1)) * 100, 2) AS video_weight_pct
FROM
  page_metrics
WHERE
  bytes_total IS NOT NULL
ORDER BY
  co2_grams_per_view DESC
LIMIT 1000;