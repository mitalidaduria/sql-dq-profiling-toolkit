---- 05 Timeliness Check:  To check if records are being processed within SLA?

SELECT
     PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY processing_time_ms) AS p95_latency_ms,
     PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY processing_time_ms) AS median_latency_ms,
     CASE
     WHEN PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY processing_time_ms) <= 300 THEN 'SLA MET' ELSE 'SLA BREACH'
     END AS sla_status
     FROM failure_events
     WHERE event_date >= CURRENT_DATE - 7;