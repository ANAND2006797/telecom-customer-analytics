-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 10 – DERIVED BUSINESS COLUMNS
-- ============================================================


-- ============================================================
-- 1. ADD DERIVED COLUMNS
-- ============================================================

ALTER TABLE Billing
ADD COLUMN IF NOT EXISTS TenureGroup VARCHAR(20);

ALTER TABLE Billing
ADD COLUMN IF NOT EXISTS MonthlyChargeBand VARCHAR(10);

ALTER TABLE Service
ADD COLUMN IF NOT EXISTS ServiceCount INT;

ALTER TABLE Churn
ADD COLUMN IF NOT EXISTS ChurnFlag INT;


-- ============================================================
-- 2. TENURE GROUP
-- ============================================================

UPDATE Billing
SET TenureGroup =
    CASE
        WHEN TenureMonths BETWEEN 0 AND 12
            THEN '0-12 Months'

        WHEN TenureMonths BETWEEN 13 AND 24
            THEN '13-24 Months'

        WHEN TenureMonths BETWEEN 25 AND 48
            THEN '25-48 Months'

        WHEN TenureMonths >= 49
            THEN '49+ Months'

        ELSE NULL
    END;


-- ============================================================
-- 3. MONTHLY CHARGE BAND
-- Objective thresholds:
-- P33 = 50.20
-- P67 = 84.15
-- ============================================================

UPDATE Billing
SET MonthlyChargeBand =
    CASE
        WHEN MonthlyCharges <= 50.20
            THEN 'Low'

        WHEN MonthlyCharges > 50.20
             AND MonthlyCharges <= 84.15
            THEN 'Medium'

        WHEN MonthlyCharges > 84.15
            THEN 'High'

        ELSE NULL
    END;


-- ============================================================
-- 4. SERVICE COUNT
--
-- Count subscribed services:
--   Phone Service
--   Internet Service
--   Online Security
--   Online Backup
--   Device Protection
--   Tech Support
--   Streaming TV
--   Streaming Movies
--
-- "Multiple Lines" is intentionally NOT counted because
-- it represents an additional phone-line feature, not a
-- separate service category in the approved definition.
-- ============================================================

UPDATE Service
SET ServiceCount =
      CASE
          WHEN PhoneService = 'Yes' THEN 1
          ELSE 0
      END

    + CASE
          WHEN InternetService IN ('DSL', 'Fiber optic') THEN 1
          ELSE 0
      END

    + CASE
          WHEN OnlineSecurity = 'Yes' THEN 1
          ELSE 0
      END

    + CASE
          WHEN OnlineBackup = 'Yes' THEN 1
          ELSE 0
      END

    + CASE
          WHEN DeviceProtection = 'Yes' THEN 1
          ELSE 0
      END

    + CASE
          WHEN TechSupport = 'Yes' THEN 1
          ELSE 0
      END

    + CASE
          WHEN StreamingTV = 'Yes' THEN 1
          ELSE 0
      END

    + CASE
          WHEN StreamingMovies = 'Yes' THEN 1
          ELSE 0
      END;


-- ============================================================
-- 5. CHURN FLAG
-- ============================================================

UPDATE Churn
SET ChurnFlag =
    CASE
        WHEN ChurnLabel = 'Yes' THEN 1
        WHEN ChurnLabel = 'No' THEN 0
        ELSE NULL
    END;


-- ============================================================
-- 6. VALIDATION — TENURE GROUP
-- ============================================================

SELECT
    TenureGroup,
    COUNT(*) AS customer_count
FROM Billing
GROUP BY TenureGroup
ORDER BY TenureGroup;


-- ============================================================
-- 7. VALIDATION — MONTHLY CHARGE BAND
-- ============================================================

SELECT
    MonthlyChargeBand,
    COUNT(*) AS customer_count,
    MIN(MonthlyCharges) AS minimum_charge,
    MAX(MonthlyCharges) AS maximum_charge
FROM Billing
GROUP BY MonthlyChargeBand
ORDER BY
    CASE MonthlyChargeBand
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
    END;


-- ============================================================
-- 8. VALIDATION — SERVICE COUNT
-- ============================================================

SELECT
    MIN(ServiceCount) AS minimum_service_count,
    MAX(ServiceCount) AS maximum_service_count,
    AVG(ServiceCount) AS average_service_count
FROM Service;


-- ============================================================
-- 9. VALIDATION — CHURN FLAG
-- ============================================================

SELECT
    ChurnFlag,
    COUNT(*) AS customer_count
FROM Churn
GROUP BY ChurnFlag
ORDER BY ChurnFlag;


-- ============================================================
-- 10. VALIDATION — NULL DERIVED VALUES
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE TenureGroup IS NULL)
        AS null_tenure_groups,

    COUNT(*) FILTER (WHERE MonthlyChargeBand IS NULL)
        AS null_charge_bands
FROM Billing;


SELECT
    COUNT(*) FILTER (WHERE ServiceCount IS NULL)
        AS null_service_counts
FROM Service;


SELECT
    COUNT(*) FILTER (WHERE ChurnFlag IS NULL)
        AS null_churn_flags
FROM Churn;