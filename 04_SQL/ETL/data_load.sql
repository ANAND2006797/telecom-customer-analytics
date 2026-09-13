-- ============================================================
-- PHASE 2 — DATA INGESTION & ETL
-- STEP 3 — Load Raw Data
-- ============================================================

-- Clear staging table before loading.
TRUNCATE TABLE stg_telecom_churn;

-- Load raw CSV into staging table.
\copy stg_telecom_churn FROM 'C:/Users/B ANAND/OneDrive/Desktop/project 1/telecom-customer-analytics/03_Raw_Data/telecom_customer_churn.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8');