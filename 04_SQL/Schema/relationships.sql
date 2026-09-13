-- ============================================================
-- PHASE 2 – DATA INGESTION & ETL
-- STEP 9 – PRIMARY KEYS / FOREIGN KEYS
-- ============================================================

-- ============================================================
-- VALIDATE PRIMARY KEYS
-- ============================================================

SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type
FROM information_schema.table_constraints tc
WHERE tc.table_schema = 'public'
  AND tc.table_name IN ('customer', 'service', 'billing', 'churn')
  AND tc.constraint_type = 'PRIMARY KEY'
ORDER BY tc.table_name;


-- ============================================================
-- VALIDATE FOREIGN KEYS
-- ============================================================

SELECT
    tc.table_name,
    tc.constraint_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
   AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
   AND tc.table_schema = ccu.table_schema
WHERE tc.table_schema = 'public'
  AND tc.table_name IN ('service', 'billing', 'churn')
  AND tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name;


-- ============================================================
-- CHECK FOR ORPHAN RECORDS
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