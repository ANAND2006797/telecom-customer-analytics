# Schema Design

## 1. Purpose

Define the relational database schema for the Telecom Customer Churn Analytics project based on the approved column mapping and data-quality findings.

The raw dataset contains 33 columns. The relational design separates customer attributes, service attributes, billing attributes, and churn attributes into four related tables.

---

## 2. Design Overview

The database consists of four tables:

- `Customer` — customer identity, geography, and demographic attributes
- `Service` — subscribed telecom services and contract information
- `Billing` — tenure, charges, billing preferences, and payment method
- `Churn` — churn status, score, CLTV, and churn reason

`CustomerID` is the common business key across all four tables.

The `Customer` table is the parent table. The `Service`, `Billing`, and `Churn` tables reference `Customer(CustomerID)`.

---

## 3. Removed Source Columns

The following source columns are excluded from the relational model:

| Column | Reason |
|---|---|
| `Count` | Constant value of 1 |
| `Country` | Single value: United States |
| `State` | Single value: California |
| `Lat Long` | Redundant because `Latitude` and `Longitude` are stored separately |

These columns remain documented in the data inventory, column mapping, and data-quality report.

---

## 4. Customer Table

Stores customer identity, geographic, and demographic attributes.

```sql
CREATE TABLE Customer (
    CustomerID VARCHAR(20) PRIMARY KEY,
    City VARCHAR(100),
    ZipCode INT,
    Latitude NUMERIC(10,6),
    Longitude NUMERIC(10,6),
    Gender VARCHAR(10),
    SeniorCitizen VARCHAR(5),
    Partner VARCHAR(5),
    Dependents VARCHAR(5)
);
```

### Key

- Primary Key: `CustomerID`

---

## 5. Service Table

Stores telecom service subscriptions and contract information.

```sql
CREATE TABLE Service (
    CustomerID VARCHAR(20) PRIMARY KEY,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
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
```

### Key

- Primary Key: `CustomerID`
- Foreign Key: `CustomerID` → `Customer(CustomerID)`

---

## 6. Billing Table

Stores customer tenure, charges, billing preferences, and payment method.

```sql
CREATE TABLE Billing (
    CustomerID VARCHAR(20) PRIMARY KEY,
    TenureMonths INT,
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
```

### Key

- Primary Key: `CustomerID`
- Foreign Key: `CustomerID` → `Customer(CustomerID)`

### Data-quality consideration

`Total Charges` is converted from the source object/text representation to `NUMERIC(10,2)`. Blank-string values are converted to `NULL`.

---

## 7. Churn Table

Stores the churn outcome and churn-related analytical attributes.

```sql
CREATE TABLE Churn (
    CustomerID VARCHAR(20) PRIMARY KEY,
    ChurnLabel VARCHAR(5),
    ChurnValue INT,
    ChurnScore INT,
    CLTV INT,
    ChurnReason TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
```

### Key

- Primary Key: `CustomerID`
- Foreign Key: `CustomerID` → `Customer(CustomerID)`

### Data-quality consideration

`ChurnReason` remains `NULL` for active customers because the profiling report shows that its 5,174 missing values correspond to customers with `Churn Label = No`.

---

## 8. Relationship Structure

```text
                         Customer
                    (CustomerID PK)
                          |
             +------------+------------+
             |            |            |
             |            |            |
          Service      Billing       Churn
       (CustomerID)  (CustomerID)  (CustomerID)
           PK/FK        PK/FK         PK/FK
```

The design represents a one-to-one relationship between a customer and each subject-area table, with `CustomerID` serving as the shared key.

---

## 9. Data Type Decisions

| Source Column | Database Column | Data Type | Reason |
|---|---|---|---|
| CustomerID | CustomerID | VARCHAR(20) | Alphanumeric customer identifier |
| Zip Code | ZipCode | INT | Numeric postal-code value in the source |
| Latitude | Latitude | NUMERIC(10,6) | Geographic coordinate |
| Longitude | Longitude | NUMERIC(10,6) | Geographic coordinate |
| Tenure Months | TenureMonths | INT | Whole number of months |
| Monthly Charges | MonthlyCharges | NUMERIC(10,2) | Monetary value |
| Total Charges | TotalCharges | NUMERIC(10,2) | Monetary value after conversion |
| Churn Value | ChurnValue | INT | Binary churn indicator |
| Churn Score | ChurnScore | INT | Integer score |
| CLTV | CLTV | INT | Integer customer lifetime value score |
| Churn Reason | ChurnReason | TEXT | Variable-length reason description |

---

## 10. Relational Design Principles

- `CustomerID` is the primary business identifier.
- Each subject-area table uses `CustomerID` as its primary key.
- Foreign-key constraints preserve referential integrity.
- Removed constant or redundant source columns are excluded from the database model.
- `TotalCharges` is stored as a numeric monetary field.
- `ChurnReason` permits `NULL` because missingness is structurally associated with active customers.
- The schema preserves the approved Customer, Service, Billing, and Churn separation.

---

## 11. Source-to-Database Mapping Summary

| Destination Table | Number of Columns |
|---|---:|
| Customer | 9 |
| Service | 11 |
| Billing | 6 |
| Churn | 6 |
| **Total Retained Columns** | **32** |
| Removed Source Columns | 4 |

> Note: `CustomerID` is intentionally present in each relational table as the shared key. The count above represents table columns, not unique source columns.

---

## 12. Phase 1 Schema Status

The relational schema is defined and ready for implementation during Phase 2 — Data Ingestion & ETL (PostgreSQL).
