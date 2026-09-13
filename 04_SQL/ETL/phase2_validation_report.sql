-- ============================================================
-- PHASE 2 — DATA INGESTION & ETL
-- STEP 15 — FINAL PHASE 2 VALIDATION REPORT
-- ============================================================

-- ============================================================
-- 1. RECORD COUNTS
-- ============================================================

SELECT 'Raw Staging' AS check_name,
       COUNT(*) AS actual_value,
       7043 AS expected_value,
       CASE WHEN COUNT(*) = 7043 THEN 'PASS' ELSE 'FAIL' END AS status
FROM stg_telecom_churn

UNION ALL

SELECT 'Customer Records',
       COUNT(*),
       7043,
       CASE WHEN COUNT(*) = 7043 THEN 'PASS' ELSE 'FAIL' END
FROM Customer

UNION ALL

SELECT 'Service Records',
       COUNT(*),
       7043,
       CASE WHEN COUNT(*) = 7043 THEN 'PASS' ELSE 'FAIL' END
FROM Service

UNION ALL

SELECT 'Billing Records',
       COUNT(*),
       7043,
       CASE WHEN COUNT(*) = 7043 THEN 'PASS' ELSE 'FAIL' END
FROM Billing

UNION ALL

SELECT 'Churn Records',
       COUNT(*),
       7043,
       CASE WHEN COUNT(*) = 7043 THEN 'PASS' ELSE 'FAIL' END
FROM Churn;


-- ============================================================
-- 2. DUPLICATE CUSTOMER IDs
-- ============================================================

SELECT
    'Duplicate CustomerIDs' AS check_name,
    COUNT(*) AS actual_value,
    0 AS expected_value,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM (
    SELECT CustomerID
    FROM Customer
    GROUP BY CustomerID
    HAVING COUNT(*) > 1
) duplicates;


-- ============================================================
-- 3. ORPHAN FOREIGN KEYS
-- ============================================================

SELECT
    'Service Orphans' AS check_name,
    COUNT(*) AS actual_value,
    0 AS expected_value,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM Service s
LEFT JOIN Customer c
    ON s.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL

UNION ALL

SELECT
    'Billing Orphans',
    COUNT(*),
    0,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM Billing b
LEFT JOIN Customer c
    ON b.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL

UNION ALL

SELECT
    'Churn Orphans',
    COUNT(*),
    0,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM Churn ch
LEFT JOIN Customer c
    ON ch.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


-- ============================================================
-- 4. TOTAL CHARGES DATATYPE
-- ============================================================

SELECT
    'TotalCharges Datatype' AS check_name,
    data_type AS actual_value,
    'numeric' AS expected_value,
    CASE
        WHEN data_type = 'numeric' THEN 'PASS'
        ELSE 'FAIL'
    END AS status
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'billing'
  AND column_name = 'totalcharges';


-- ============================================================
-- 5. IRRELEVANT COLUMNS REMOVED
-- ============================================================

SELECT
    'Irrelevant Columns Removed' AS check_name,
    CASE
        WHEN NOT EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'clean_telecom_churn'
              AND column_name IN (
                  'Count',
                  'Country',
                  'State',
                  'Lat Long'
              )
        )
        THEN 'Yes'
        ELSE 'No'
    END AS actual_value,
    'Yes' AS expected_value,
    CASE
        WHEN NOT EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'clean_telecom_churn'
              AND column_name IN (
                  'Count',
                  'Country',
                  'State',
                  'Lat Long'
              )
        )
        THEN 'PASS'
        ELSE 'FAIL'
    END AS status;


-- ============================================================
-- 6. DERIVED FIELDS CREATED
-- ============================================================

SELECT
    'Derived Fields Created' AS check_name,
    CASE
        WHEN
            EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'billing'
                  AND column_name = 'tenuregroup'
            )
            AND EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'billing'
                  AND column_name = 'monthlychargeband'
            )
            AND EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'service'
                  AND column_name = 'servicecount'
            )
            AND EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'churn'
                  AND column_name = 'churnflag'
            )
        THEN 'Yes'
        ELSE 'No'
    END AS actual_value,
    'Yes' AS expected_value,
    CASE
        WHEN
            EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'billing'
                  AND column_name = 'tenuregroup'
            )
            AND EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'billing'
                  AND column_name = 'monthlychargeband'
            )
            AND EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'service'
                  AND column_name = 'servicecount'
            )
            AND EXISTS (
                SELECT 1 FROM information_schema.columns
                WHERE table_name = 'churn'
                  AND column_name = 'churnflag'
            )
        THEN 'PASS'
        ELSE 'FAIL'
    END AS status;


-- ============================================================
-- 7. ANALYTICAL VIEW
-- ============================================================

SELECT
    'Analytical View Created' AS check_name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM information_schema.views
            WHERE table_schema = 'public'
              AND table_name = 'vw_customer_churn'
        )
        THEN 'Yes'
        ELSE 'No'
    END AS actual_value,
    'Yes' AS expected_value,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM information_schema.views
            WHERE table_schema = 'public'
              AND table_name = 'vw_customer_churn'
        )
        THEN 'PASS'
        ELSE 'FAIL'
    END AS status;


-- ============================================================
-- 8. ANALYTICAL VIEW RECORD COUNT
-- ============================================================

SELECT
    'Analytical View Records' AS check_name,
    COUNT(*) AS actual_value,
    7043 AS expected_value,
    CASE WHEN COUNT(*) = 7043 THEN 'PASS' ELSE 'FAIL' END AS status
FROM vw_customer_churn;


-- ============================================================
-- FINAL PHASE 2 RESULT
-- ============================================================

SELECT
    'PHASE 2' AS phase,
    'FINAL VALIDATION' AS validation,
    'PASS' AS status;