--DivyaThakkar

--BASIC SQL QUERIES

--Create table1
CREATE TABLE EmployeeDemographics(
employee_id int,
first_name varchar(50),
last_name varchar(50),
age int,
gender varchar(50))

--Create table2
CREATE TABLE EmployeeSalary(
employee_id int,
job_title varchar(50),
salary int)

--Insert data table1
INSERT INTO EmployeeDemographics VALUES
(1001,'Jim','Halpert',30,'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

--Insert data table2
INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

--Select only a bunch
SELECT TOP 5 * 
FROM EmployeeDemographics

--Distinct
SELECT DISTINCT(gender)
FROM EmployeeDemographics

--Count 
SELECT COUNT(age)
FROM EmployeeDemographics

--WHERE Statement
--=,<>,<,>,AND,OR,LIKE,NULL,NOT NULL,IN 

--=
SELECT last_name 
FROM EmployeeDemographics
WHERE employee_id = 1006

--<>
SELECT * 
FROM EmployeeDemographics
WHERE last_name<>'Scott'

--<
SELECT employee_id
FROM EmployeeDemographics
WHERE age<=30

-->
SELECT first_name
FROM EmployeeDemographics
WHERE age>30

--AND 
SELECT * 
FROM EmployeeDemographics
WHERE age>30 AND gender='Male'

--OR
SELECT * 
FROM EmployeeSalary
WHERE job_title='Salesman' OR salary>50000

--Wildcards
--LIKE
SELECT * 
FROM EmployeeDemographics
WHERE last_name LIKE 'S%o%'

--IN(Multiple equals)
SELECT * 
FROM EmployeeDemographics
WHERE first_name IN('Jim','Michael')

--Group by, Order by
SELECT gender, COUNT(gender) AS count_gender
FROM EmployeeDemographics
WHERE age>30
GROUP BY gender
ORDER BY gender DESC

--Order by
SELECT *
FROM EmployeeDemographics
ORDER BY age
