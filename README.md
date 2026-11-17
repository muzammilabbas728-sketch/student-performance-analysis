 Student Performance & Dropout Analytics Dashboard

 About the Project

This project focuses on analyzing student academic performance and identifying the main factors associated with student dropouts at the university level.

 Database Design

The project uses a relational star schema database model built in PostgreSQL and managed through DBeaver. It consists of one central fact table and four dimension tables, allowing analysis of student data from different perspectives.

. student_performance_fct (Fact Table): Contains academic information such as semester GPA, attendance percentages, assignment submission rates, and student dropout status.
. student_financial_dim: Stores financial details, including tuition payment status, family income levels, and weekly working hours.
. student_health_info_dim: Contains student well-being information, including stress levels, average sleeping hours, and daily commute times.
. student_information_dim: Stores student background information, such as age and scholarship status.

This database structure makes it easier to combine information from different tables and explore the factors related to student performance and dropouts.

 Dashboard Overview

An interactive Power BI dashboard was developed to present the analysis through visual reports. It is organized into three main sections:

1. Overall Performance: Displays key metrics related to student numbers, dropout rates, and average academic performance.
2. Dropout Analysis: Explores the relationship between dropout rates and different factors, including tuition status, attendance, and student background.
3. Key Observations: Highlights the main findings and patterns identified during the analysis.

 Tools & Technologies

- PostgreSQL: Database creation and data management.
- DBeaver: Database querying and data inspection.
- Power BI: Data modeling, visualization, and dashboard development.
- DAX: Creating calculated measures and columns for analytical metrics.
- Git & GitHub: Version control and project management.

 Author

Muzammil Abbas
