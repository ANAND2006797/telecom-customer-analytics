-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 8 – TRANSFORM CLEANED DATA INTO RELATIONAL TABLES
-- ============================================================

-- ============================================================
-- 1. CUSTOMER TABLE
-- ============================================================

DROP TABLE IF EXISTS Churn CASCADE;
DROP TABLE IF EXISTS Billing CASCADE;
DROP TABLE IF EXISTS Service CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;

CREATE TABLE Customer (
    CustomerID VARCHAR(20) PRIMARY KEY,
    City VARCHAR(100),
    ZipCode INT,
    Latitude NUMERIC(10,6),
    Longitude NUMERIC(10,6),
    Gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10)
);

INSERT INTO Customer (
    CustomerID,
    City,
    ZipCode,
    Latitude,
    Longitude,
    Gender,
    SeniorCitizen,
    Partner,
    Dependents
)
SELECT
    "CustomerID",
    "City",
    "Zip Code",
    "Latitude",
    "Longitude",
    "Gender",
    "Senior Citizen",
    "Partner",
    "Dependents"
FROM clean_telecom_churn;


-- ============================================================
-- 2. SERVICE TABLE
-- ============================================================

CREATE TABLE Service (
    CustomerID VARCHAR(20) PRIMARY KEY,
    PhoneService VARCHAR(20),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Service (
    CustomerID,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract
)
SELECT
    "CustomerID",
    "Phone Service",
    "Multiple Lines",
    "Internet Service",
    "Online Security",
    "Online Backup",
    "Device Protection",
    "Tech Support",
    "Streaming TV",
    "Streaming Movies",
    "Contract"
FROM clean_telecom_churn;


-- ============================================================
-- 3. BILLING TABLE
-- ============================================================

CREATE TABLE Billing (
    CustomerID VARCHAR(20) PRIMARY KEY,
    TenureMonths INT,
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    PaperlessBilling VARCHAR(20),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Billing (
    CustomerID,
    TenureMonths,
    MonthlyCharges,
    TotalCharges,
    PaperlessBilling,
    PaymentMethod
)
SELECT
    "CustomerID",
    "Tenure Months",
    "Monthly Charges",
    "Total Charges",
    "Paperless Billing",
    "Payment Method"
FROM clean_telecom_churn;


-- ============================================================
-- 4. CHURN TABLE
-- ============================================================

CREATE TABLE Churn (
    CustomerID VARCHAR(20) PRIMARY KEY,
    ChurnLabel VARCHAR(10),
    ChurnValue INT,
    ChurnScore INT,
    CLTV INT,
    ChurnReason TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Churn (
    CustomerID,
    ChurnLabel,
    ChurnValue,
    ChurnScore,
    CLTV,
    ChurnReason
)
SELECT
    "CustomerID",
    "Churn Label",
    "Churn Value",
    "Churn Score",
    "CLTV",
    "Churn Reason"
FROM clean_telecom_churn;


-- ============================================================
-- STEP 8 BASIC VALIDATION
-- ============================================================

SELECT 'Customer' AS table_name, COUNT(*) AS row_count
FROM Customer

UNION ALL

SELECT 'Service', COUNT(*)
FROM Service

UNION ALL

SELECT 'Billing', COUNT(*)
FROM Billing

UNION ALL

SELECT 'Churn', COUNT(*)
FROM Churn;