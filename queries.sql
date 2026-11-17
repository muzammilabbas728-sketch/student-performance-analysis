-- Easy Level - Basic Data Analysis
-- Q1 - (What is the total number of students in the dataset?)

select distinct count(*) as total_student
from student_information_dim sid ;


-- Q2 -(What is the distribution of students across different genders?)
select gender , count (*) total
from student_information_dim
group by gender 
order by total desc ;


-- Q3 -(How many students belong to each nationality?)
select nationality, count (*) as total 
from student_information_dim
group by nationality
order by total desc;


-- Q4 -(What is the average GPA for Semester 1 and Semester 2?)
select Round(avg(gpa_semester_1):: numeric,2) as avg_result_sem_1,
       Round(avg(gpa_semester_2):: numeric,2) as avg_result_sem_2
       from student_performance_fct ;

select avg((gpa_semester_1+gpa_semester_2)/2) as avg_gpa
from student_performance_fct;


-- Q5 -(What is the total number of students who have dropped out versus those who have continued their studies?)
select dropout , count(*) as total_droopout
from student_performance_fct
group by dropout
order by total_droopout desc;

select 
   sum (case when dropout = 1 then 1 else 0 end )as dropout_count,
   sum(case when dropout =0 then 1 else 0 end) as continue_count
   from student_performance_fct;


SELECT 
    CASE 
        WHEN dropout = 1 THEN 'dropout'
        WHEN dropout = 0 THEN 'continued'
        ELSE 'unknown'
    END AS dropout_status,
    COUNT(*) AS total_count
FROM public.student_performance_fct
GROUP BY 
    CASE 
        WHEN dropout = 1 THEN 'dropout'
        WHEN dropout = 0 THEN 'continued'
        ELSE 'unknown'
    END
ORDER BY total_count DESC;


-- Hard Level – Comparative Analysis

-- Q6 : What is the dropout rate across different course types?
select 
course_type,
count (*) as total_students, 
sum(case when dropout = 1 then 1 else 0 end) as dropout_count,
round (
sum(case when dropout =1 then 1 else 0 end )*100.0 / count(*)
)as dropout_rate
from public.student_performance_fct s
join public.student_information_dim i
on s.student_id = i.student_id 
join public.course_type_lkp c
on i.course_id = c.course_id 
group by course_type 

-- Q7:  How does the average GPA differ between scholarship holders and non-scholarship holders?
select case when scholarship_holder = 0 then 'scholarship_holder' else 'non_scholarship_holder' end as Scholarship_status ,
avg((gpa_semester_1+gpa_semester_2)/2) as average_gpa
from student_information_dim i
join student_performance_fct s
on s.student_id = i.student_id
group by scholarship_holder
order by average_gpa ;

-- Q8:  Is there a relationship between attendance rate and the number of units passed? Compare students with different
-- attendance levels.

select 
case 
	when attendance_rate < 60 then '1. low attandence'
	when attendance_rate between 60 and 79.99 then '2. modrate (between 60 and 80)'
	else '3. high above 80'
end as attandance_list,
count (*) as total_student,
round(avg(units_passed)::numeric,2) as avg_unit_passed
from student_performance_fct
group by attandance_list
order by attandance_list desc;


-- just for understaning
select 
case 
	when attendance_rate < 60 then '1'
	when attendance_rate between 60 and 79.99 then '5'
	else '100'
end as attandance_list,
count (*) as total_student,
round(avg(units_passed)::numeric,2) as avg_unit_passed
from student_performance_fct
group by attandance_list
order by attandance_list desc;



-- Q9:  How does working part-time affect academic performance? Compare the average GPA of students who work part-time
-- against those who do not, considering their weekly working hours.

select f.part_time_job,f.weekly_work_hours ,
round(avg((gpa_semester_1+gpa_semester_2/2.0))::numeric,2) as average_gpa
from student_financial_dim f
join public.student_performance_fct s
on f.student_financial_id = s.student_financial_id 
group by  f.part_time_job, f.weekly_work_hours 
order by f.part_time_job ,f.weekly_work_hours ;


-- Q10:. Which factors are associated with higher dropout rates: family income level, tuition payment status, or scholarship status?
-- Compare dropout rates across these categories.

select p.dropout,f.family_income_level,i.tuition_up_to_date,
i.scholarship_holder,
count(*) as total_student,
sum(case when p.dropout= 1 then 1 else 0 end )as total_dropouts,
round(
(sum(case when p.dropout= 1 then 1 else 0 end)* 100.0 )
/ count(*),2
) as dropout_rate
from student_performance_fct p
join public.student_financial_dim f
on p.student_financial_id = f.student_financial_id 
join public.student_information_dim i
on p.student_id =i.student_id 
group by p.dropout,f.family_income_level ,
i.tuition_up_to_date ,
i.scholarship_holder 
order by dropout_rate desc;



--Q11:Does student engagement influence academic performance and dropout rates? Analyze the combined relationship
--between attendance rate, LMS logins, library visits, assignment submission rate, and missed deadlines.

select case when dropout=1 then 'dropout' else 'continue'end as student_status,
count(*) as total_students,
round(avg(attendance_rate)::numeric,2)as avg_atandance_rate,
round(avg(lms_logins_per_week)::numeric,2) as avg_lms_logins_per_week,
round(avg(library_visits_per_month)::numeric,2)as avg_library_visits_per_month,
round(avg(assignments_submitted_rate)::numeric,2)as avg_assignments_submitted_rate,
round(avg(missed_deadlines)::numeric,2)as avg_missed_deadlines,
round(avg((gpa_semester_1+gpa_semester_2)/2.0)::numeric,2)as avg_gpa
from public.student_performance_fct
group by dropout
order by student_status desc;

--Q12: How does student well-being relate to academic performance? Analyze the relationship between stress level, sleep
--hours, mental health support, satisfaction score, and GPA.
select h.stress_level ,
count(*)as total_student,
round(avg(h.mental_health_support)::numeric,2)as avg_mental_health_support,
round(avg(h.satisfaction_score)::numeric,2)as avg_statisfaction_score,
round(avg(h.sleep_hours)::numeric,2) as avg_sleep_hours,
round(avg((p.gpa_semester_1+gpa_semester_2)/2.0)::numeric,2)as avg_gpa
from student_health_info_dim h
join student_performance_fct p
on h.student_health_id =p.student_health_id 
group by h.stress_level ;


--Q13:Are first-generation students more likely to drop out than non-first-generation students? Compare dropout rates while also
--considering scholarship status and family income level.
select 
  case when i.first_generation= 1 then 'first_gen'else 'second_gen' end as generation,
  i.scholarship_holder,
    f.family_income_level,
  count(*) as total_student,
  SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
  ROUND((SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS dropout_rate
  from public.student_information_dim i
  join public.student_performance_fct p
  on i.student_id=p.student_id
  join public.student_financial_dim f
  on f.student_financial_id=p.student_financial_id
  group by CASE 
        WHEN i.first_generation = 1 THEN 'first_gen' 
        ELSE 'second_gen' 
    END,
    i.scholarship_holder,
    f.family_income_level
ORDER BY dropout_rate DESC;


with labeled_students as(
select case
when i.first_generation =1 then 'first_gen' else 'second_gen'
end as generation,
i.scholarship_holder,
f.family_income_level,
p.dropout
from student_information_dim i
join student_performance_fct p
on i.student_id = p.student_id
join student_financial_dim f 
on f.student_financial_id=p.student_financial_id
)
select generation,
    scholarship_holder,
    family_income_level,
    count (*)as total_student,
   SUM(CASE WHEN dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
    ROUND(
        (SUM(CASE WHEN dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS dropout_rate
FROM labeled_students
GROUP BY 
    generation,
    scholarship_holder,
    family_income_level
ORDER BY dropout_rate DESC;


--Q14:  Does commuting time influence student attendance, academic performance, and dropout rates? Identify any patterns
-- across different commuting-time groups.
select case when h.commute_time_mins < 30 then 'local'
        when h.commute_time_mins between 30 and 60 then 'Standard_travel' 
        when h.commute_time_mins between 60 and 90 then 'Substantial travel'
        else 'Extreme_travelling' end as travelling,
        round(avg(p.attendance_rate)::numeric, 2) as avg_attendance_rate,
        round(avg(p.gpa_semester_1+p.gpa_semester_2)/2.0)as student_performance,
        round(sum(case when p.dropout=1 then 1 else 0 end)*100/count(*))as dropout_rate
         from student_health_info_dim h
        join student_performance_fct p
        on h.student_health_id = p.student_health_id
     group by travelling;



--Q15:  Identify the top five student-related factors associated with dropout. Support your findings with appropriate SQL analysis,
--comparisons, and statistical summaries. Clearly distinguish between correlation and causation.


--Attendance Rate Brackets

SELECT 
    CASE 
        WHEN p.attendance_rate < 60 THEN '1. Low (<60%)'
        WHEN p.attendance_rate BETWEEN 60 AND 79.99 THEN '2. Moderate (60-80%)'
        ELSE '3. High (>80%)'
    END AS attendance_tier,
    COUNT(*) AS total_students,
    SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
    ROUND(
        (SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS dropout_rate_pct
FROM student_performance_fct p
GROUP BY 1
ORDER BY attendance_tier;
 
--Tuition Payment Status

SELECT 
    CASE WHEN i.tuition_up_to_date = 1 THEN 'Tuition Paid' ELSE 'Tuition Overdue/Unpaid' END AS tuition_status,
    COUNT(*) AS total_students,
    SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
    ROUND(
        (SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS dropout_rate_pct
FROM student_information_dim i
JOIN student_performance_fct p ON i.student_id = p.student_id
GROUP BY i.tuition_up_to_date
ORDER BY dropout_rate_pct DESC;

--Missed Deadlines

SELECT 
    CASE 
        WHEN p.missed_deadlines = 0 THEN '0 Missed Deadlines'
        WHEN p.missed_deadlines BETWEEN 1 AND 3 THEN '1-3 Missed'
        ELSE '4+ Missed Deadlines'
    END AS missed_deadline_tier,
    COUNT(*) AS total_students,
    SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
    ROUND(
        (SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS dropout_rate_pct
FROM student_performance_fct p
GROUP BY 1
ORDER BY dropout_rate_pct DESC;

--Family Income Level

SELECT 
    f.family_income_level,
    COUNT(*) AS total_students,
    SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
    ROUND(
        (SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS dropout_rate_pct
FROM student_financial_dim f
JOIN student_performance_fct p ON f.student_financial_id = p.student_financial_id
GROUP BY f.family_income_level
ORDER BY f.family_income_level;

--Stress Levels
SELECT 
    h.stress_level,
    COUNT(*) AS total_students,
    SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) AS total_dropouts,
    ROUND(
        (SUM(CASE WHEN p.dropout = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS dropout_rate_pct
FROM student_health_info_dim h
JOIN student_performance_fct p ON h.student_health_id = p.student_health_id
GROUP BY h.stress_level
ORDER BY h.stress_level;
