 ---- Basic Data Cleaning---
 
select * from hr_data
SELECT COUNT(*) 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'hr_data'
AND TABLE_SCHEMA = 'hr_analysis';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'hr_data';


SELECT 
    CONCAT(
        column_name, ' IS NULL'
    ) AS condition_part
FROM information_schema.columns
WHERE table_name = 'hr_data';

SELECT * FROM hr_data LIMIT 50;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(Age) AS age_not_null,
    COUNT(Gender) AS gender_not_null
FROM hr_data;

SELECT COUNT(*) 
FROM hr_data
WHERE age  = '';

SELECT MIN(age), MAX(age)
FROM hr_data;

SELECT COUNT(*) 
FROM hr_data
WHERE 
    age IS NULL;
   
    
ALTER TABLE hr_data
ADD id INT AUTO_INCREMENT PRIMARY KEY;

SELECT *
FROM hr_data
GROUP BY id
HAVING COUNT(*) > 1;

SELECT Age, Gender, Department, MonthlyIncome, COUNT(*) 
FROM hr_data
GROUP BY Age, Gender, Department, MonthlyIncome
HAVING COUNT(*) > 1;

SELECT *
FROM hr_data
WHERE (Age, Gender, Department, JobRole, MonthlyIncome) IN (
    SELECT Age, Gender, Department, JobRole, MonthlyIncome
    FROM hr_data
    GROUP BY Age, Gender, Department, JobRole, MonthlyIncome
    HAVING COUNT(*) > 1
);



SELECT 
    Age, Gender, Department, JobRole, MonthlyIncome, COUNT(*) 
FROM hr_data
GROUP BY Age, Gender, Department, JobRole, MonthlyIncome
HAVING COUNT(*) > 1;


SELECT DISTINCT Gender FROM hr_data;

SELECT DISTINCT Attrition FROM hr_data;
SELECT DISTINCT Department FROM hr_data;

UPDATE hr_data
SET Department =
CASE 
    WHEN Department = 'Human Resources' THEN 'HR'
    WHEN Department = 'Research & Development' THEN 'R&D'
    ELSE Department
END;

SET SQL_SAFE_UPDATES = 0;

SELECT JobRole, COUNT(*) AS total_employees
FROM hr_data
GROUP BY JobRole
ORDER BY total_employees 

SELECT
  COUNT(*) AS total_rows,
SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_missing,
  SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_missing,
  SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Department_missing,
  SUM(CASE WHEN JobRole IS NULL THEN 1 ELSE 0 END) AS JobRole_missing,
  SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS Income_missing
FROM hr_data;

SELECT *
FROM hr_data
WHERE MonthlyIncome < 0 OR Age < 0;
	SELECT ID, COUNT(*)
	FROM hr_data
	GROUP BY ID
	HAVING COUNT(*) > 1;

SELECT 
    COUNT(*) 
FROM hr_data
WHERE 
    Age IS NULL 
    OR Department IS NULL 
    OR MonthlyIncome IS NULL;
    
    SELECT COUNT(*) 
FROM (
    SELECT Age, Gender, Department, JobRole, MonthlyIncome, COUNT(*) 
    FROM hr_data
    GROUP BY Age, Gender, Department, JobRole, MonthlyIncome
    HAVING COUNT(*) > 1
) t;

SELECT DISTINCT Gender FROM hr_data;
SELECT DISTINCT Department ,jobrole FROM hr_data;
SELECT DISTINCT Attrition FROM hr_data;

SELECT 
    MIN(MonthlyIncome), 
    MAX(MonthlyIncome)
FROM hr_data;


