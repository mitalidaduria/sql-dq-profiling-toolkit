---- 06 Uniqueness Check: Should be zero duplicates in the golden record.

SELECT
    customer_id,
    COUNT(*) AS record_count,
    'DUPLICATE - MATCH JOB ERROR' AS issue
    FROM customer_golden_record
    GROUP BY customer_id
    HAVING COUNT(*) > 1
    ORDER BY record_count DESC;