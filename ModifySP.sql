USE [SQL_Queries]
GO
/****** Object:  StoredProcedure [dbo].[temp_employee]    Script Date: 1/9/2023 8:48:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[temp_employee]
@job_title nvarchar(50)
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
WHERE job_title=@job_title
GROUP BY job_title

SELECT * 
FROM #temp_employee3