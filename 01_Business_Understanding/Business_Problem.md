# Business Problem

## 1. Business Context

The project analyzes customer churn for a fictional telecommunications company that provides home phone and Internet services to customers in California.

The dataset contains customer-level information for **7,043 customers across 33 variables**. The available data covers customer demographics, geographic information, tenure, subscribed services, contract type, billing and payment methods, monthly and total charges, customer lifetime value, churn status, churn score, and churn reasons.

The dataset represents a **Q3 customer snapshot**, where `Churn Label` identifies whether a customer left the company during the quarter.

---

## 2. Business Problem

Customer churn is a significant business concern because customers who leave the company reduce the existing customer base and eliminate their recurring revenue.

The company currently has customer-level data describing who its customers are, which services they use, how they pay, what contracts they hold, how long they have been customers, and whether they have churned.

However, raw customer data alone does not provide management with a clear understanding of:

* Which customer segments experience the highest churn.
* Which contract types are associated with higher customer loss.
* Whether particular Internet or phone services have different churn patterns.
* How churn varies by tenure, demographics, payment method, and geography.
* Which churn reasons occur most frequently.
* How much recurring monthly revenue is associated with churned customers.
* Whether high-value customers, based on CLTV, are disproportionately affected by churn.

The business therefore needs a structured analytics process to transform the available customer data into actionable information about **churn patterns, customer segments, and financial impact**.

---

## 3. Problem Statement

The objective of this project is to analyze customer churn within the telecommunications customer base and determine the customer, service, contract, billing, payment, tenure, and geographic characteristics associated with customer loss.

The analysis will also quantify the financial impact of churn using available revenue-related measures such as `Monthly Charges`, `Total Charges`, and `CLTV`.

The resulting analysis should enable business stakeholders to understand **where churn is concentrated, why customers are leaving, which customer groups require attention, and what areas should be considered for retention initiatives**.

---

## 4. Dataset-Based Business Situation

The profiling of the dataset identified:

| Metric                      |  Value |
| --------------------------- | -----: |
| Total Customers             |  7,043 |
| Total Variables             |     33 |
| Churned Customers           |  1,869 |
| Retained Customers          |  5,174 |
| Churn Rate                  | 26.54% |
| Duplicate Records           |      0 |
| Missing Cells               |  5,174 |
| Columns With Missing Values |      1 |

The `Churn Reason` field contains 5,174 missing values because churn reasons are recorded for customers who churned, while retained customers do not have a churn reason.

The dataset also contains several dimensions that can be used to investigate churn, including:

* Customer demographics
* Customer tenure
* Phone and Internet services
* Additional services such as Online Security, Online Backup, Device Protection, and Tech Support
* Contract type
* Paperless billing
* Payment method
* Monthly Charges
* Total Charges
* Customer Lifetime Value (CLTV)
* Geographic information
* Churn Reason

---

## 5. Key Business Questions

The analysis will answer the following questions:

### Customer Churn

1. What percentage of customers have churned?
2. How many customers have churned?
3. Which customer segments have the highest churn rates?

### Contract & Services

4. Which contract types have the highest churn?
5. How does churn differ across Internet Service types?
6. Do customers using additional services such as Tech Support or Online Security show different churn patterns?
7. Does phone service or multiple-line usage relate to churn?

### Customer Characteristics

8. How does churn vary by tenure?
9. How does churn differ between senior and non-senior customers?
10. How does churn vary by gender, partner status, and dependent status?

### Billing & Payment

11. Does churn vary by payment method?
12. How does churn differ across monthly charge levels?
13. What is the relationship between tenure and total charges?
14. What is the monthly revenue associated with churned customers?

### Customer Value

15. Are high-CLTV customers represented disproportionately among churned customers?
16. Which high-value customer segments require greater retention attention?

### Geography

17. Are there geographic areas with relatively high customer churn?
18. Which cities or geographic segments contribute significantly to churn?

### Churn Reasons

19. What are the most common reasons customers leave?
20. Which churn reasons should receive priority from a retention perspective?

---

## 6. Business Impact

Customer churn can affect the company in two primary ways:

### Customer Base Impact

Every churned customer represents a reduction in the existing customer base. Understanding the characteristics of these customers can help identify segments where customer retention requires greater attention.

### Revenue Impact

Churned customers no longer contribute their recurring monthly charges. Therefore, the analysis will quantify the monthly revenue associated with churned customers and compare it with the overall customer revenue base.

Customer value will also be considered through the available `CLTV` field so that churn analysis is not limited to customer counts alone.

---

## 7. Analytical Scope

This project focuses on **descriptive and diagnostic business analytics**.

The workflow will use:

* **PostgreSQL / SQL** for relational data storage, ETL, validation, and business analysis.
* **Python / Pandas** for data profiling, cleaning, exploratory analysis, and supporting analysis.
* **Excel** for pivot-table-based business analysis and supporting visualizations.
* **Power BI** for interactive dashboards and stakeholder reporting.

The project will analyze the existing `Churn Label` and `Churn Value` fields to understand observed customer churn.

The project does **not** develop a machine-learning churn prediction model.

The existing `Churn Score` field is treated as a dataset-provided attribute. According to the dataset description, it was calculated using IBM SPSS Modeler. Similarly, `CLTV` is a dataset-provided predicted customer lifetime value measure.

---

## 8. Expected Business Outcome

The final analysis is expected to provide stakeholders with a clear view of:

* Overall customer churn.
* High-churn customer segments.
* Service and contract patterns associated with churn.
* Billing and payment patterns associated with churn.
* Tenure-related churn patterns.
* Geographic churn concentrations.
* Major reasons for customer departure.
* Revenue associated with churn.
* High-value customer segments affected by churn.

These findings will be used to develop **data-driven retention recommendations** and support management decision-making.

---

## 9. Business Objective

The overall business objective is:

> **To use customer-level telecom data to understand the drivers and concentration of customer churn, quantify its revenue impact, identify high-priority customer segments, and provide actionable insights that can support customer retention decisions.**
