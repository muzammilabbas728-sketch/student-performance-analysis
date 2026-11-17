Student Performance & Dropout Analytics Dashboard
About the Project
This project focuses on analyzing student academic performance and identifying the primary risk factors contributing to student dropouts at the university level.

Database Design
The project utilizes a relational star schema database model built in PostgreSQL and managed through DBeaver. The architecture consists of one central fact table surrounded by four dimension tables to support multidimensional analysis:

student_performance_fct (Fact Table): Contains core academic metrics including semester GPA, attendance percentages, assignment submission rates, and student dropout status.

student_financial_dim: Stores financial background details such as tuition payment status, family income levels, and weekly working hours.

student_health_info_dim: Captures student well-being metrics including stress levels, average sleeping hours, and daily commute times.

student_information_dim: Stores demographic and background data such as age and scholarship status.

This structured schema enables seamless data integration and comprehensive multi-perspective analysis of student performance trends.

Dashboard Overview
An interactive Power BI dashboard was developed to translate complex analytical findings into clear, actionable visual insights. The report is organized into three primary sections:

Overall Performance: High-level metrics tracking semester grades and academic progress.

Dropout Analysis: Deep dive into risk indicators, attendance correlations, and primary attrition factors.

Key Observations: Summary insights and takeaways derived from the data model.

Tools & Technologies
PostgreSQL: Database creation, schema implementation, and relational data management.

DBeaver: Database querying, script execution, and data inspection.

Power BI: Data modeling, visualization, and interactive dashboard development.

DAX: Writing calculated measures and dynamic columns for performance metrics.

Git & GitHub: Version control and source code management.

What I Learned
Through this project, I gained hands-on, practical experience in relational database design, complex SQL querying, exploratory data analysis, and end-to-end Power BI dashboard development.

Author
Muzammil Abbas
