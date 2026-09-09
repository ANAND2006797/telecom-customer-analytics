# Project Objectives

## 1. Primary Objective

To analyze customer churn within the telecommunications customer base, identify the customer and service characteristics associated with churn, quantify the financial impact of customer loss, and provide actionable business insights that can support customer retention decisions.

---

## 2. Data Objectives

* Understand and document the structure and characteristics of the telecom customer dataset.
* Profile the **7,043 customer records and 33 variables**.
* Identify data-quality issues such as missing values, incorrect data types, duplicates, and irrelevant fields.
* Clean and standardize the dataset for analytical use.
* Design and implement a structured relational data model in PostgreSQL.
* Establish appropriate primary-key and foreign-key relationships between customer, service, billing, and churn data.

---

## 3. SQL / PostgreSQL Objectives

* Load the cleaned customer data into PostgreSQL.
* Perform data validation after ingestion.
* Develop reusable SQL views where appropriate.
* Calculate overall customer churn metrics.
* Analyze churn across important business dimensions, including:

  * Contract type
  * Internet service
  * Payment method
  * Customer tenure
  * Demographics
  * Additional services
  * Geographic segments
* Calculate revenue-related metrics such as:

  * Total monthly revenue
  * Monthly revenue associated with churned customers
  * Average revenue per customer
* Identify customer segments with comparatively high churn rates.

---

## 4. Python / Pandas Objectives

* Perform data profiling and validation using Pandas.
* Verify data types, missing values, distributions, and descriptive statistics.
* Conduct exploratory data analysis to identify meaningful churn patterns.
* Replicate and extend selected SQL analyses using Pandas.
* Create analytical features where useful, including:

  * Tenure groups
  * Service count
  * Churn flag
  * Customer spending indicators
* Analyze relationships between customer characteristics, services, charges, tenure, customer value, and churn.
* Produce supporting visualizations for exploratory analysis.

---

## 5. Excel Analysis Objectives

* Prepare analytical datasets for Excel-based analysis.
* Create PivotTables for churn analysis.
* Analyze churn rates across major customer and service categories.
* Analyze churn by:

  * Contract
  * Internet service
  * Payment method
  * Tenure group
  * Other relevant customer segments
* Create PivotCharts to communicate important patterns.
* Use slicers and filters where appropriate to support interactive exploration.

---

## 6. Power BI Objectives

* Build a Power BI data model using the prepared analytical data.
* Establish appropriate relationships between model tables.
* Develop reusable DAX measures for core business KPIs.
* Create an interactive churn analytics dashboard.
* Present key metrics including:

  * Total Customers
  * Churned Customers
  * Churn Rate
  * Total Monthly Revenue
  * Revenue Associated with Churned Customers
  * Average Monthly Revenue
  * Customer Value Indicators
* Visualize churn patterns across contracts, services, tenure, payment methods, customer segments, and geography.
* Enable interactive filtering and cross-analysis through slicers and visual interactions.

---

## 7. Customer Segmentation Objectives

* Identify customer segments with elevated observed churn.
* Examine churn patterns across tenure groups.
* Analyze customer value using the available `CLTV` field.
* Identify segments where high customer value and observed churn overlap.
* Identify high-priority customer segments for potential retention attention.

> **Note:** High-priority segmentation in this project is based on observed business characteristics and existing customer-value indicators. It is not a machine-learning prediction task.

---

## 8. Churn Reason Analysis Objectives

* Analyze the recorded reasons for customer churn.
* Identify the most frequently reported churn reasons.
* Group churn reasons into meaningful business themes where appropriate.
* Determine which reasons represent significant areas for potential retention improvement.

---

## 9. Revenue Impact Objectives

* Quantify the monthly revenue associated with churned customers.
* Compare revenue from churned customers with the overall monthly revenue base.
* Analyze the relationship between customer charges, tenure, CLTV, and churn.
* Identify high-value customer segments affected by churn.
* Translate customer churn into measurable financial impact.

---

## 10. Business Insight Objectives

The project will convert analytical findings into business insights by:

* Identifying major churn hotspots.
* Determining customer and service characteristics associated with higher churn.
* Identifying potentially stable customer segments.
* Highlighting significant churn reasons.
* Quantifying the financial impact of customer loss.
* Identifying high-priority segments for retention initiatives.
* Developing data-driven recommendations based on observed patterns.

---

## 11. Final Project Objective

The final objective is to create a complete, reproducible **Telecom Customer Churn Analytics workflow** that transforms raw customer data into validated analytical datasets, SQL/Pandas/Excel analyses, an interactive Power BI dashboard, and actionable business recommendations.

The project will focus on **descriptive and diagnostic analytics** and will **not develop or train a machine-learning churn prediction model**.
