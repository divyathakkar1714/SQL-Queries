--DivyaThakkar

--INTERMEDIATE SQL QUERIES

--insert data table1
INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

--insert data table2
INSERT INTO EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL,'Salesman',43000)

--Table 3 Query:
Create Table WareHouseEmployeeDemographics 
(employee_id int, 
first_name varchar(50), 
last_name varchar(50), 
age int, 
gender varchar(50)
)

--Table 3 Insert:
Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

--Inner joins
SELECT * 
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.employee_id=EmployeeSalary.employee_id

--Full outer join
SELECT * 
FROM EmployeeDemographics
FULL OUTER JOIN EmployeeSalary
ON EmployeeDemographics.employee_id=EmployeeSalary.employee_id

--Left Outer join
SELECT * 
FROM EmployeeDemographics
LEFT OUTER JOIN EmployeeSalary
ON EmployeeDemographics.employee_id=EmployeeSalary.employee_id

--Right Outer join
SELECT * 
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
ON EmployeeDemographics.employee_id=EmployeeSalary.employee_id

--Desired output
SELECT EmployeeSalary.employee_id,first_name,last_name,job_title,salary
FROM EmployeeDemographics
Right OUTER JOIN EmployeeSalary
ON EmployeeDemographics.employee_id=EmployeeSalary.employee_id

--Highest salary paid
SELECT EmployeeDemographics.employee_id,first_name,last_name,salary
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.employee_id=EmployeeSalary.employee_id
WHERE first_name <> 'Michael'
ORDER BY salary DESC


--Union and union all
--outer joining two tables EmployeeDemographics and WareHouseEmployeeDemographics
SELECT * 
FROM EmployeeDemographics
FULL OUTER JOIN WareHouseEmployeeDemographics
ON EmployeeDemographics.employee_id=WareHouseEmployeeDemographics.employee_id

--Union two tables
SELECT * 
FROM EmployeeDemographics
UNION
SELECT * 
FROM WareHouseEmployeeDemographics

--Union all the above query
SELECT * 
FROM EmployeeDemographics
UNION ALL
SELECT * 
FROM WareHouseEmployeeDemographics

--Case Statements
SELECT first_name,last_name,age,
CASE
	WHEN age > 30 THEN 'Old'
	ELSE 'Young'
END
FROM EmployeeDemographics
WHERE age is NOT NULL
ORDER BY age

--Case 2
--giving raises to different job titles 
SELECT first_name,last_name,job_title,salary,
CASE 
	WHEN job_title = 'Salaesman' THEN salary + (salary * .10)
	WHEN job_title = 'Accountant' THEN salary + (salary * .05)
	WHEN job_title = 'HR' THEN salary + (salary * .000001)
	ELSE salary + (salary * .03)
END AS salary_after_raise
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.employee_id = EmployeeSalary.employee_id


--Having clause
--finding the number of emplyees in different departments having more than 1 employee
SELECT job_title,COUNT(job_title)
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.employee_id = EmployeeSalary.employee_id
GROUP BY job_title
HAVING COUNT(job_title) > 1

--finding the average salary of different departmants having an average more than 45000
SELECT job_title,AVG(salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.employee_id = EmployeeSalary.employee_id
GROUP BY job_title
HAVING AVG(salary) > 45000
ORDER BY AVG(salary)


--Updating data
SELECT * 
FROM EmployeeDemographics
--filling the missing values for Holly Flax
UPDATE EmployeeDemographics
SET employee_id = 1012, age = 32, gender = 'Female'
WHERE first_name= 'Holly' AND last_name = 'Flax'
--filling the missing values for employee_id 1013
UPDATE EmployeeDemographics
SET age= 37
WHERE employee_id=1013

--Delete Statement
--deleting a row in the table
DELETE FROM EmployeeDemographics
WHERE employee_id = 1013


--Aliasing
--aliasing column names
SELECT first_name + ' ' + last_name AS full_name
FROM EmployeeDemographics

--aliasing table names
SELECT demo.employee_id
FROM EmployeeDemographics AS demo

--aliasing and finidng the salary of each employee id joining two tables
SELECT demo.employee_id,sal.salary
FROM EmployeeDemographics AS demo
JOIN EmployeeSalary AS sal
ON demo.employee_id = sal.employee_id

--joining three tables and fetching data using aliasing
SELECT demo.employee_id, demo.first_name,demo.last_name,sal.job_title,ware.age
FROM EmployeeDemographics demo
LEFT JOIN EmployeeSalary sal
	ON demo.employee_id = sal.employee_id
LEFT JOIN WareHouseEmployeeDemographics ware
	ON demo.employee_id = ware.employee_id

SELECT * 
FROM WareHouseEmployeeDemographics


--Partition By vs Group By
--partition by
SELECT first_name,last_name,gender,salary
,COUNT(gender) OVER (PARTITION BY gender) as total_gender
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal
ON demo.employee_id = sal.employee_id
--group by
SELECT gender, COUNT(gender) as total_gender
FROM EmployeeDemographics demo
JOIN EmployeeSalary sal
ON demo.employee_id=sal.employee_id
GROUP BY gender