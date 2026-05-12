---- DQ Dimension2: Confirmity
---- Purpose: To check values match approved taxonomy / naming standards.

---- 2a. Check values against approved list (valid value set check)
SELECT
field_name AS column_name,
COUNT(*) AS occurence_count,
CASE
    WHEN field_name IN (
        'CAT-01', 'CAT-02', 'CAT-03', 'CAT-04', 'CAT-05'
    ) THEN 'VALID'
    WHEN field_name IS NULL THEN 'NULL - SEE COMPLETENESS'
    ELSE 'NON-CONFIRMING - REJECT'
    END AS confirmity_status
    FROM your_table
    ORDER BY confirmity_status DESC, occurenece_count DESC;


---- 2b.  See all non confirming values and which source they came from, this tells if source A is sending a different name than source B.

SELECT
source_system,
raw_field_value AS what_source_sent,
COUNT(*) AS frequency,
'NOT IN CANONICAL TAXONOMY' AS issue
FROM your_table
WHERE raw_field_value NOT IN ( 
    'CAT-01', 'CAT-02', 'CAT-03', 'CAT-04', 'CAT-05'
)
AND raw_field_value IS NOT NULL
GROUP BY source_system, raw-field_name
ORDER BY source_system, frequency DESC;


---- 2c. Naming convention check (format level confirmity)

SELECT
product_code,
COUNT(*) AS count,
CASE
    WHEN product_code REGEXP ''
    THEN 'Conforms'
    ELSE 'Format Violation'
    END AS format_status
    FROM your_table
    GROUP BY product_code
    HAVING format_status = 'FORMAT VIOLATION'
    ORDER BY count DESC;