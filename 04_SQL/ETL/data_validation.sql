-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 4 – Validate Raw Ingestion
-- ============================================================

-- 1. Validate total row count
SELECT COUNT(*) AS total_rows
FROM stg_telecom_churn;
-- Expected: 7043


-- 2. Check for NULL CustomerIDs
SELECT COUNT(*) AS null_customer_ids
FROM stg_telecom_churn
WHERE "CustomerID" IS NULL;
-- Expected: 0


-- 3. Check total column count
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'stg_telecom_churn';
-- Expected: 33


-- 4. Check unique CustomerIDs
SELECT COUNT(DISTINCT "CustomerID") AS unique_customer_ids
FROM stg_telecom_churn;
-- Expected: 7043


-- 5. Check duplicate CustomerIDs
SELECT "CustomerID", COUNT(*) AS duplicate_count
FROM stg_telecom_churn
GROUP BY "CustomerID"
HAVING COUNT(*) > 1;
-- Expected: 0 rows
-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 12 – FINAL POSTGRESQL VALIDATION
-- ============================================================


-- ============================================================
-- 1. FINAL ROW COUNTS
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
FROM Churn

UNION ALL

SELECT 'vw_customer_churn', COUNT(*)
FROM vw_customer_churn;


-- ============================================================
-- 2. CUSTOMERID DUPLICATE CHECK
-- ============================================================

SELECT 'Customer' AS table_name, COUNT(*) AS duplicate_customer_ids
FROM (
    SELECT CustomerID
    FROM Customer
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'Service', COUNT(*)
FROM (
    SELECT CustomerID
    FROM Service
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'Billing', COUNT(*)
FROM (
    SELECT CustomerID
    FROM Billing
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
) x

UNION ALL

SELECT 'Churn', COUNT(*)
FROM (
    SELECT CustomerID
    FROM Churn
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
) x;


-- ============================================================
-- 3. FOREIGN-KEY INTEGRITY
-- ============================================================

SELECT COUNT(*) AS service_orphans
FROM Service s
LEFT JOIN Customer c
    ON s.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


SELECT COUNT(*) AS billing_orphans
FROM Billing b
LEFT JOIN Customer c
    ON b.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


SELECT COUNT(*) AS churn_orphans
FROM Churn ch
LEFT JOIN Customer c
    ON ch.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


-- ============================================================
-- 4. DATA TYPE VALIDATION
-- ============================================================

SELECT
    table_name,
    column_name,
    data_type,
    numeric_precision,
    numeric_scale
FROM information_schema.columns
WHERE table_schema = 'public'
  AND (
        (table_name = 'billing' AND column_name IN
            ('monthlycharges', 'totalcharges'))
        OR
        (table_name = 'customer' AND column_name IN
            ('zipcode', 'latitude', 'longitude', 'seniorcitizen'))
        OR
        (table_name = 'churn' AND column_name IN
            ('churnvalue', 'churnscore', 'cltv', 'churnflag'))
      )
ORDER BY table_name, column_name;


-- ============================================================
-- 5. CHURN BUSINESS LOGIC
-- ============================================================

SELECT COUNT(*) AS invalid_churn_values
FROM Churn
WHERE NOT (
    (ChurnValue = 1 AND ChurnLabel = 'Yes')
    OR
    (ChurnValue = 0 AND ChurnLabel = 'No')
);


-- ============================================================
-- 6. CHURN FLAG VALIDATION
-- ============================================================

SELECT COUNT(*) AS invalid_churn_flags
FROM Churn
WHERE ChurnFlag <> ChurnValue
   OR ChurnFlag IS NULL;


-- ============================================================
-- 7. TENURE GROUP VALIDATION
-- ============================================================

SELECT COUNT(*) AS invalid_tenure_groups
FROM Billing
WHERE NOT (
    (TenureMonths BETWEEN 0 AND 12
        AND TenureGroup = '0-12 Months')

    OR

    (TenureMonths BETWEEN 13 AND 24
        AND TenureGroup = '13-24 Months')

    OR

    (TenureMonths BETWEEN 25 AND 48
        AND TenureGroup = '25-48 Months')

    OR

    (TenureMonths >= 49
        AND TenureGroup = '49+ Months')
);


-- ============================================================
-- 8. MONTHLY CHARGE BAND VALIDATION
-- ============================================================

SELECT COUNT(*) AS invalid_charge_bands
FROM Billing
WHERE NOT (
    (MonthlyCharges <= 50.20
        AND MonthlyChargeBand = 'Low')

    OR

    (MonthlyCharges > 50.20
        AND MonthlyCharges <= 84.15
        AND MonthlyChargeBand = 'Medium')

    OR

    (MonthlyCharges > 84.15
        AND MonthlyChargeBand = 'High')
);


-- ============================================================
-- 9. SERVICE COUNT VALIDATION
-- ============================================================

SELECT COUNT(*) AS invalid_service_counts
FROM Service
WHERE ServiceCount < 1
   OR ServiceCount > 8
   OR ServiceCount IS NULL;


-- ============================================================
-- 10. TOTAL CHARGES NULL VALIDATION
-- ============================================================

SELECT
    COUNT(*) AS total_customers,
    COUNT(TotalCharges) AS non_null_total_charges,
    COUNT(*) - COUNT(TotalCharges) AS null_total_charges
FROM Billing;


-- ============================================================
-- 11. CHURN REASON LOGIC
-- ============================================================

SELECT COUNT(*) AS invalid_churn_reasons
FROM Churn
WHERE
    (ChurnLabel = 'No' AND ChurnReason IS NOT NULL)
    OR
    (ChurnLabel = 'Yes' AND ChurnReason IS NULL);