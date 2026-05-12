---- 04 Accuracy Check: Proxy for accuracy, stale rate

SELECT
      source_system,
      COUNT(*) AS total,
      SUM(CASE WHEN last_updated < DATEADD(day, -90, CURRENT_DATE) THEN 1 ELSE 0 END) AS stale_count,
      ROUND(
        SUM(CASE WHEN last_updated_date < DATEADD(day, -90, CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
      ) AS stale_rate_pct
      FROM customer_data
      GROUP_BY source_system;