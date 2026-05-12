---- DQ Dimension 1: Completeness
---- Purpose: Find what % of records have the mandatory fields populated.

---- 1a. Overall NULL rate for a single column
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN your_column IS NULL THEN 1 ELSE 0 END) AS null_conunt,
    ROUND(SUM(CASE WHEN your_column IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS null_pct'
    CASE
        WHEN SUM(CASE WHEN your_column IS NULL THEN 1 ELSE 0 END) = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS status
FROM your_table
WHERE rescord_status = 'ACTIVE';

---- 1b. NULL rate for multiple columns, critical insight - tells if the problem is systemic or source-specific

SELECT
    source_system,
    COUNT(*) AS total,
    SUM(CASE WHEN your_column IS NULL THEn 1 ELSE 0 END) AS null_count,
    ROUND(SUM(CASE WHEN your_column IS NULL THEN 1 ELSE 0 END)*100.0/ COUNT(*), 2) AS null_pct_bySource
FROM your_table
GROUP_BY source_system
ORDER BY null_pct_by_source DESC;

---- 1c. Multi-column completeness scorecard - Run this to get the full picture of all mandatory fields at once
SELECT
    'transaction_id' AS column_name,
    COUNT(*) AS total,
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS nulls,
    ROUND(SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS null_pct
    FROM your_table
    UNION ALL SELECT 'failure_category',
    COUNT(*),
    SUM(CASE WHEN failure_category IS NULL THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN failure_category IS NULL THEN 1 ELSE 0 END)*100.0/COUNT(*),2)
    FROM your_table_name
    UNION ALL SELECT 'gateway_id',
    COUNT(*),
    SUM(CASE WHEN gateway_id IS NULL THEN 1 ELSE 0 END),
    ROUND SUM(CASE WHEN gateway_id ID NULL THEN 1 ELSE 0 END)*100.0/COUNT(*),2)
    FROM your_table
    ORDER BY null_pct DESC;