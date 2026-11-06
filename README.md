# Student Performance & Dropout Analytics Dashboard

A comprehensive data analytics project designed to evaluate student performance, financial barriers, well-being indicators, and primary dropout risk factors using a multi-dimensional database model and an interactive Power BI executive dashboard.

---

## 📌 Project Overview
Student retention is a critical challenge for educational institutions. This project investigates the multi-dimensional aspects of student data—spanning academic performance, financial standing, health/well-being, and lifestyle factors—to identify early warning indicators and root causes of student dropouts.

---

## 🗄️ Data Architecture & Schema
The project is built on a structured relational data model combining a central fact table with core dimension tables managed in **PostgreSQL** (queried via **DBeaver**):
* **`student_performance_fct`**: Central fact table tracking academic metrics, attendance, assignment submission rates, semester GPAs, and dropout status.
* **`student_financial_dim`**: Financial dimension tracking tuition payment status (`tuition_up_to_date`), family income levels, and work hours.
* **`student_health_info_dim`**: Well-being and lifestyle dimension tracking stress levels, sleep hours, and commute times (`Commute Group`).
* **`student_information_dim`**: Demographic and background details including scholarship status and age.

---

## 📊 Key Analytical Insights (Dropout Factors)
Answering core institutional inquiries, the analysis identifies the **top five student-related risk factors** associated with dropout rates:
1. **Tuition Payment Status (`tuition_up_to_date`):** Unpaid or overdue tuition is the single largest financial indicator of student withdrawal.
2. **Academic Performance (Semester GPA):** Consistently low GPAs or sharp academic decline between semesters heavily precede withdrawal.
3. **Missed Deadlines & Submission Rates:** Chronic academic disengagement serves as an early behavioral warning sign.
4. **Financial Background & Scholarships:** Low-income brackets combined with a lack of scholarship support restrict long-term enrollment stability.
5. **Chronic Stress & Sleep Deprivation:** High psychological stress combined with inadequate sleep severely degrades academic retention.

### 🔍 Correlation vs. Causation
* **Correlation (Early Indicators):** Low GPA and missed deadlines strongly correlate with dropout risk, serving as vital *early warning predictors*.
* **Causation (Root Drivers):** External administrative blocks (unpaid tuition) and severe financial/well-being strain act as the *direct root causes* driving students out of the institution.

---

## 🛠️ Tech Stack & Tools
* **Data Visualization:** Power BI (DAX measures, Calculated columns, Executive KPI summaries, Matrix & Clustered Bar Visuals)
* **Database & Querying:** PostgreSQL, DBeaver
* **Version Control:** Git & GitHub

---

## 🚀 Dashboard Layout & Features
* **Top Row:** Executive Summary KPI Cards (*Total Students, Overall Dropout Rate %, Average Institutional GPA*).
* **Middle Section:** 
  * Clustered Bar Chart mapping Dropout Rates by Tuition Status and Commute Time Groups.
  * Multi-Variable Matrix Table intersecting scholarship holders, tuition compliance, and stress tiers with GPA and dropout percentages.
* **Bottom Section:** Executive text box briefing outlining analytical findings and the correlation vs. causation framework.

---

## 👤 Author
* **Muzammil Abbas**
* GitHub: [muzammilabbas728-sketch](https://github.com/muzammilabbas728-sketch)