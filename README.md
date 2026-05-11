# sql-dq-profiling-toolkit
Reusable SQl queries for data quality profiling across 6 DQ dimensions -> Completeness, Consistency, Accuracy, Timeliness, Uniqueness. Built from production MDM and payment analytics work.
Data Profiling is a pre-requisite for any MDM or migration strategy. This toolkit provides standardized SQL queries to measure the state of data before making design decisions.

# The 6 Dimensions of Data Quality:
1. Completeness: Are mandatory fields populated?
2. Confirmity: Do values follow the taxonomy?
3. Consistency: Does the same entity match across systems?
4. Accuracy: Does the data reflect daily reality?
5. Timeliness: Is the data processed within SLA?
6. Uniqueness: Are there unintended duplicates in the golden record?

# How to use:
Each script contains a Template section. Replace your_table and your_column with your specific env variables to generate a Data Quality (DQ) scorecard.
