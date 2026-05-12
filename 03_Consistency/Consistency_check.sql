---- DQ Dimension 3: Consistency
---- Purpose: Same Entity, Same Attribute - does it match across systems?, This is where survivorship decisions get their evidences from.

---- 3a. Cross-system attribute comparison, It is the foundational query for the survivorship design decisions.

SELECT
crm.customer_id,
crm.email AS crm_email,
oms.email AS oms_email,
CASE
    WHEN crm.email = oms.email THEN 'CONSISTENT'
    WHEN crm.email IS NULL THEN 'CRM NULL - OMS WINS BY DEFAULT'
    WHEN oms.email IS NULL THEN 'OMS NULL - CRM WINS BY DEFAULT'
    ELSE 'CONFLICT - APPLY SURVIVORSHIP RULE'
    ENS AS consistency_status
    FROM crm_customers crm
    LEFT JOIN oms_customers oms ON crm.customer_id = oms.customer_id;


    ---- 3b. Conflict rate summary - feeds the trust score decision
    SELECT
          COUNT(*) AS total_matched_records,
          SUM(CASE WHEN crm.email != oms.email THEN 1 ELSE 0 END) AS conflicts,
          RPOUND( SUM(CASE WHEN crm.email != oms.email THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conflict_rate_pct
          FROM crm_customer crm
          JOIN oms_customers oms ON crm.customer_id = oms.customer_id
          WHERE crm.email IS NOT NULL AND oms.email IS NOT NULL;