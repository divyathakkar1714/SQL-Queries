--DivyaThakkar

--ADVANCE SQL QUERIES

--CTEs
WITH CTE_Employee AS (
SELECT first_name,last_name,gender,salary
,COUNT(gender) OVER (PARTITION BY gender) AS total_gender
,AVG(salary) OVER (PARTITION BY gender) AS avg_salary
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal
	ON demo.employee_id = sal.employee_id
WHERE salary > 45000
)
SELECT first_name,avg_salary
FROM CTE_Employee


--Temp tables
--table1
DROP TABLE IF EXISTS #temp_employee
CREATE TABLE #temp_employee(
employee_id int,
job_title varchar(100),
salary int)

SELECT *
FROM #temp_employee

INSERT INTO #temp_employee VALUES(
1001, 'HR' ,45000
)

--inserting the data into a temp table directly from an existing table
INSERT INTO #temp_employee
SELECT * 
FROM EmployeeSalary

--table2
DROP TABLE IF EXISTS #temp_employee2
Create table #temp_employee2(
job_title varchar(50),
employees_per_job int,
avg_age int,
avg_salary int
)

INSERT INTO #temp_employee2
SELECT job_title, COUNT(job_title),AVG(age),AVG(salary)
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal
ON demo.employee_id = sal.employee_id
GROUP BY job_title

SELECT * FROM #temp_employee2

SELECT avg_age * avg_salary
from #temp_employee2


--String functions
DROP TABLE IF EXISTS employee_errors
CREATE TABLE EmployeeErrors(
employee_id varchar(50),
first_name varchar(50),
last_name varchar(50))

INSERT INTO EmployeeErrors VALUES
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

--TRIM,LTRIM,RTRIM
SELECT employee_id, TRIM(employee_id) AS id_trim
FROM EmployeeErrors

Select employee_id, RTRIM(LTRIM(employee_id)) AS IDTRIM
FROM EmployeeErrors 

--Replace
SELECT last_name, REPLACE(last_name,'- Fired','') AS last_name_Fixed
FROM EmployeeErrors

--Substring
SELECT SUBSTRING(first_name,1,3)
FROM EmployeeErrors

--Fuzzy matching
SELECT SUBSTRING(error.first_name,1,3), SUBSTRING(demo.first_name,1,3)
FROM EmployeeErrors error
JOIN EmployeeDemographics demo
ON SUBSTRING(error.first_name,1,3) = SUBSTRING(demo.first_name,1,3)
--ON error.employee_id = demo.employee_id

--Upper and lower
SELECT first_name,LOWER(first_name),UPPER(first_name)
FROM EmployeeErrors


--Stored Procedures
--basic stored procedure
CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

--run the above stored procedure
EXEC TEST

--complex stored procedure
CREATE PROCEDURE temp_employee
AS
CREATE TABLE #temp_employee3(
job_title varchar(100),
employee_per_job int,
avg_age int,
avg_salary int
)

--insert data
INSERT INTO #temp_employee3
SELECT job_title,COUNT(job_title),AVG(age),AVG(salary)
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal
ON demo.employee_id = sal.employee_id
GROUP BY job_title

SELECT * 
FROM #temp_employee3
--run the complex query till here

--view the data
EXEC temp_employee @job_title = 'Salesman'


--Subqueries
SELECT * 
FROM EmployeeSalary

--subquery in a select statement
--average salary of each employee
SELECT employee_id,salary,
(SELECT AVG(salary) FROM EmployeeSalary) AS avg_salary
FROM EmployeeSalary

--the above query with partition by
SELECT employee_id,salary,AVG(salary) OVER() AS avg_salary 
FROM EmployeeSalary

--with group by function (doesn't work)
SELECT employee_id,salary,AVG(salary) AS avg_salary 
FROM EmployeeSalary
GROUP BY employee_id,salary
ORDER BY 1,2

--subquery in from
SELECT a.employee_id, avg_salary
FROM (SELECT employee_id,salary,AVG(salary) OVER() AS avg_salary 
	FROM EmployeeSalary) a

--subquery in where
SELECT employee_id,job_title,salary
FROM EmployeeSalary
WHERE employee_id IN (SELECT employee_id 
						FROM EmployeeDemographics
						WHERE age>30)


