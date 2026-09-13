-- ============================================================
-- PHASE 2 — DATA INGESTION & ETL
-- STEP 2 — Raw/Staging Table
-- ============================================================

DROP TABLE IF EXISTS stg_telecom_churn;

CREATE TABLE stg_telecom_churn (
    "CustomerID" VARCHAR(20),
    "Count" INTEGER,
    "Country" VARCHAR(50),
    "State" VARCHAR(50),
    "City" VARCHAR(100),
    "Zip Code" INTEGER,
    "Lat Long" VARCHAR(100),
    "Latitude" NUMERIC(10,6),
    "Longitude" NUMERIC(10,6),
    "Gender" VARCHAR(20),
    "Senior Citizen" INTEGER,
    "Partner" VARCHAR(10),
    "Dependents" VARCHAR(10),
    "Tenure Months" INTEGER,
    "Phone Service" VARCHAR(10),
    "Multiple Lines" VARCHAR(30),
    "Internet Service" VARCHAR(30),
    "Online Security" VARCHAR(30),
    "Online Backup" VARCHAR(30),
    "Device Protection" VARCHAR(30),
    "Tech Support" VARCHAR(30),
    "Streaming TV" VARCHAR(30),
    "Streaming Movies" VARCHAR(30),
    "Contract" VARCHAR(30),
    "Paperless Billing" VARCHAR(10),
    "Payment Method" VARCHAR(50),
    "Monthly Charges" NUMERIC(10,2),
    "Total Charges" VARCHAR(30),
    "Churn Label" VARCHAR(10),
    "Churn Value" INTEGER,
    "Churn Score" INTEGER,
    "CLTV" INTEGER,
    "Churn Reason" TEXT
);