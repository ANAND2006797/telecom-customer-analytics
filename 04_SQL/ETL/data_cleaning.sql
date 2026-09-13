-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 5 – DATA-TYPE CLEANING
-- ============================================================

DROP TABLE IF EXISTS clean_telecom_churn;

CREATE TABLE clean_telecom_churn AS
SELECT
    "CustomerID"::VARCHAR(20) AS "CustomerID",
    "Count"::INT AS "Count",
    "Country"::VARCHAR(50) AS "Country",
    "State"::VARCHAR(50) AS "State",
    "City"::VARCHAR(100) AS "City",
    "Zip Code"::INT AS "Zip Code",
    "Lat Long"::VARCHAR(100) AS "Lat Long",
    "Latitude"::NUMERIC(10,6) AS "Latitude",
    "Longitude"::NUMERIC(10,6) AS "Longitude",
    "Gender"::VARCHAR(20) AS "Gender",

    CASE
        WHEN "Senior Citizen" = 'Yes' THEN 1
        WHEN "Senior Citizen" = 'No' THEN 0
        ELSE NULL
    END::INT AS "Senior Citizen",

    "Partner"::VARCHAR(10) AS "Partner",
    "Dependents"::VARCHAR(10) AS "Dependents",
    "Tenure Months"::INT AS "Tenure Months",
    "Phone Service"::VARCHAR(20) AS "Phone Service",
    "Multiple Lines"::VARCHAR(30) AS "Multiple Lines",
    "Internet Service"::VARCHAR(30) AS "Internet Service",
    "Online Security"::VARCHAR(30) AS "Online Security",
    "Online Backup"::VARCHAR(30) AS "Online Backup",
    "Device Protection"::VARCHAR(30) AS "Device Protection",
    "Tech Support"::VARCHAR(30) AS "Tech Support",
    "Streaming TV"::VARCHAR(30) AS "Streaming TV",
    "Streaming Movies"::VARCHAR(30) AS "Streaming Movies",
    "Contract"::VARCHAR(30) AS "Contract",
    "Paperless Billing"::VARCHAR(20) AS "Paperless Billing",
    "Payment Method"::VARCHAR(50) AS "Payment Method",
    "Monthly Charges"::NUMERIC(10,2) AS "Monthly Charges",

    NULLIF(TRIM("Total Charges"), '')::NUMERIC(10,2)
        AS "Total Charges",

    "Churn Label"::VARCHAR(10) AS "Churn Label",
    "Churn Value"::INT AS "Churn Value",
    "Churn Score"::INT AS "Churn Score",
    "CLTV"::INT AS "CLTV",
    "Churn Reason"::VARCHAR(100) AS "Churn Reason"

FROM stg_telecom_churn;