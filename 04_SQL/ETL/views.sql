-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 11 – CLEAN ANALYTICAL VIEW
-- ============================================================

DROP VIEW IF EXISTS vw_customer_churn;

CREATE VIEW vw_customer_churn AS
SELECT
    -- Customer
    c.CustomerID,
    c.City,
    c.ZipCode,
    c.Latitude,
    c.Longitude,
    c.Gender,
    c.SeniorCitizen,
    c.Partner,
    c.Dependents,

    -- Service
    s.PhoneService,
    s.MultipleLines,
    s.InternetService,
    s.OnlineSecurity,
    s.OnlineBackup,
    s.DeviceProtection,
    s.TechSupport,
    s.StreamingTV,
    s.StreamingMovies,
    s.Contract,
    s.ServiceCount,

    -- Billing
    b.TenureMonths,
    b.TenureGroup,
    b.MonthlyCharges,
    b.MonthlyChargeBand,
    b.TotalCharges,
    b.PaperlessBilling,
    b.PaymentMethod,

    -- Churn
    ch.ChurnLabel,
    ch.ChurnValue,
    ch.ChurnScore,
    ch.CLTV,
    ch.ChurnReason,
    ch.ChurnFlag

FROM Customer c

LEFT JOIN Service s
    ON c.CustomerID = s.CustomerID

LEFT JOIN Billing b
    ON c.CustomerID = b.CustomerID

LEFT JOIN Churn ch
    ON c.CustomerID = ch.CustomerID;