# **Olist E-Commerce: Full-Stack Cohort Retention & Growth Engine**

## **Project Overview**
This project provides an end-to-end analytical solution for the **Olist Brazilian E-Commerce dataset**. It bridges the gap between raw data engineering and executive decision-making by tracking how customer acquisition and retention interact over a two-year period (2016–2018).

### **The "Full-Stack" Architecture**
1.  **PostgreSQL:** Data Engineering and creation of the "Gold Table" (Cohort Logic).
2.  **Jupyter Notebook (Python):** Statistical validation and historical heatmap visualization.
3.  **Power BI:** Interactive Executive Dashboard for real-time monitoring of Revenue, AOV, and Growth.

---

## **Phase 1: Data Engineering (PostgreSQL)**
To ensure high performance in BI tools, the heavy lifting (joins and window functions) was performed at the database level. I engineered a **Gold Table** that pre-calculates the monthly cohort index for every unique customer.

* **Key Technical Challenge:** Handling the "Birth Month" vs. "Active Month" logic for over 90k unique customers.
* **SQL Skillset:** Common Table Expressions (CTEs), Window Functions (`FIRST_VALUE`), and Date Truncation.
* **Infrastructure:** Managed multi-version PostgreSQL instances (v15/v18) and optimized port configurations for external BI connections.

---

## **Phase 2: Deep-Dive Analysis (Python)**
Using a Jupyter Notebook, I validated the SQL output and performed a deep-dive analysis into customer behavior.

* **Key Insight:** Identified a significant drop-off after Month 0, common in marketplaces, but isolated specific cohorts with higher-than-average 3-month retention.
* **Libraries:** `Pandas`, `Seaborn`, `Matplotlib`.
* **Methodology:** Replicated SQL logic in Python to ensure data integrity and generated a high-resolution heatmap for historical documentation.

---

## **Phase 3: Executive Business Intelligence (Power BI)**
The final phase translates the technical data into a business-ready tool. I designed a **Star Schema** that connects the aggregate cohort data with transactional financial records using a **Calendar Bridge**.

### **Key Metrics (KPIs):**
* **Total Revenue:** Denominated in **Brazilian Real (R$)** to reflect Olist's primary market context.
* **Total Unique Customers:** Calculated using specialized DAX measures to ensure accurate acquisition counts per cohort.
* **Average Order Value (AOV):** A real-time efficiency metric calculated as Revenue divided by Distinct Orders.

### **Dashboard Interactivity:**
* **Global Filters (Year):** Controls the entire analytical suite, filtering the acquisition line chart and the retention heatmap simultaneously.
* **Transactional Filters (Payment Type):** Specifically targets financial KPIs (Revenue & AOV) for granular performance analysis.
* **DAX Optimization:** Implemented `VAR/RETURN` and `ALLSELECTED` logic to maintain consistent 100% baselines for Cohort Month 0.

![Dashboard]
<img width="633" height="369" alt="image" src="https://github.com/user-attachments/assets/ed5abaf2-1f80-459f-9eef-faa91911a5dc" />


---

## **How to Use This Repository**
1.  **SQL:** Run the scripts from `Olist_ecommerce.sql` file to generate the `cohort_retention_results` table.
2.  **Notebook:** Open `Olist_E-commerce_Analysis.ipynb` to see the statistical heatmap.
3.  **Power BI:** Open the `Olist_E-commerce_Dashboard.pbix` file in the. 
    * *Note: Ensure your PostgreSQL service is running on the correct port (e.g., localhost:5433).*

## **Conclusion**
By moving the cohort logic into the SQL layer, this project demonstrates a **Production-Ready** mindset. It allows for advanced Python modeling while providing a fast, interactive Power BI environment that balances high-level executive summaries with granular financial deep-dives.
