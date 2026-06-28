-- Q1: Which employee received the highest percentage salary hike?
---Ans1
Select e.employeenumber,r.percentsalaryhike,
RANK() OVER (ORDER BY r.percentsalaryhike desc )as highest_rank_hike
 from employee_master e
 join record r on
e.id= r.id
 limit 1;
-----------------------------------------------------------------------

--- Q2 What is the distribution of employees across 
-- different marital statuses in the company
SELECT 
    MaritalStatus,
    COUNT(*) AS total_marital_status
FROM employee_master
GROUP BY MaritalStatus;
------------------------------------------------------------------

---- Q3 Classify employees into Low, Medium, High salary groups based on 
-- MonthlyIncome ?
---Ans 3 
SELECT 
    MonthlyIncome,
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
        WHEN MonthlyIncome > 7000 THEN 'High'
        ELSE 'Unknown'
    END AS Salary_Group
FROM record; 
--------------------------------------------------------------------------


---- Q4- Categorize employees based on job satisfaction
 into “Satisfied” and “Not Satisfied”.
 
Ans 4 SELECT 
    e.EmployeeNumber,
    r.JobSatisfaction,
    CASE
        WHEN r.JobSatisfaction <= 1 THEN 'Not Satisfied'
        WHEN r.JobSatisfaction > 1 THEN 'Satisfied'
        ELSE 'Unknown'
    END AS Satisfaction_Status
FROM record r
JOIN employee_master e
ON e.id = r.id;

--------------------------------------------------------------------------
--- Q5 Who are the top 5 highest-paid employees in the company using CTE?
- Ans5      
   With top_five AS (
 Select e.employeenumber, r.Department, r.monthlyincome as Highest_Paid 
  from record r
 join employee_master e
 on e.id= r.id
order by r.monthlyincome desc 
limit 5)
Select employeenumber, Department,Highest_paid 
from top_five;

---------------------------------------------------------------------------
-- Q6 How many employees travel frequently for work
-- Ans 6 - 
Select r.Department,e.Employeenumber,Businesstravel
 as Most_Frequent_Travel
from record r
join employee_master e on
e.id= r.id
where businesstravel = 'Travel_Frequently';


--------------------------------------------------------------------------

-- Q7 Find employees whose salary is above the average salary of their job role
--Ans 
SELECT 
    e.EmployeeNumber,
    r.JobRole,
    r.MonthlyIncome
FROM employee_master e
JOIN record r
ON e.id = r.id
WHERE r.MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM record
    WHERE JobRole = r.JobRole
);

---------------------------------------------------------------------------
-- Q8  Which job roles have employees with the Second and
-- Fourth highest salary hikes?
-- Ans 8 
SELECT Distinct Percentsalaryhike, Highest_salary_hike
FROM (
    SELECT 
        Percentsalaryhike,
        DENSE_RANK() OVER (ORDER BY Percentsalaryhike DESC) 
        AS Highest_salary_hike
    FROM record
) t
WHERE Highest_salary_hike IN (2,4)

---------------------------------------------------------------------------
-- Q9 Which salary hike levels have the highest attrition?”
Select min(PercentSalaryHike), max(PercentSalaryHike) from record
SELECT 
    CASE 
        WHEN PercentSalaryHike <12 THEN 'Low Hike' 
        ELSE 'High Hike'
    END AS hike_category,
    COUNT(*) AS total_attrition
FROM record
WHERE Attrition = 'Yes'
GROUP BY hike_category

------------------------------------------------------------------------
-- Q 10  Generate all possible combinations of overtime status and
-- relationship satisfaction levels.
-- Ans10- SELECT 
    OverTime,
    COUNT(*) AS Total_Relationship_Count
FROM record
GROUP BY OverTime;
-------------------------------------------

-- Q11 Which department has highest attrition?
Select department, count(*) as total_attrition
 from record
 where attrition = 'Yes'
 group by department
order by total_attrition desc limit 1;	

	------------------------------------------------------------------
  
    -- Q12  Show all employees with their business travel details and performance ratings, including employees who may not
    -- have matching performance records.
   -- Ans12  SELECT e.EmployeeNumber,
    r.department, r.BusinessTravel,
    r.PerformanceRating
FROM employee_master e
LEFT JOIN record r
ON e.id = r.id;
    
    
    
    

    
    
