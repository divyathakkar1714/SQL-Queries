
CREATE TABLE PortfolioProject.dbo.employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
)

CREATE TABLE PortfolioProject.dbo.branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  --FOREIGN KEY(mgr_id) REFERENCES PortfolioProject.dbo.employee(emp_id) ON DELETE SET NULL
)

ALTER TABLE PortfolioProject.dbo.branch
ADD FOREIGN KEY(mgr_id)
REFERENCES PortfolioProject.dbo.employee(emp_id)
ON DELETE SET NULL

ALTER TABLE PortfolioProject.dbo.employee
ADD FOREIGN KEY(branch_id)
REFERENCES PortfolioProject.dbo.branch(branch_id)
ON DELETE SET NULL

ALTER TABLE PortfolioProject.dbo.employee
ADD FOREIGN KEY(super_id)
REFERENCES PortfolioProject.dbo.employee(emp_id)
ON DELETE NO ACTION

CREATE TABLE PortfolioProject.dbo.client(
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES PortfolioProject.dbo.branch(branch_id) ON DELETE SET NULL
)

CREATE TABLE PortfolioProject.dbo.works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES PortfolioProject.dbo.employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES PortfolioProject.dbo.client(client_id) ON DELETE CASCADE
)

SELECT * FROM PortfolioProject.dbo.works_with

CREATE TABLE PortfolioProject.dbo.branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES PortfolioProject.dbo.branch(branch_id) ON DELETE CASCADE
)

SELECT * FROM PortfolioProject.dbo.branch_supplier

-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO PortfolioProject.dbo.employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO PortfolioProject.dbo.branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE PortfolioProject.dbo.employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO PortfolioProject.dbo.employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO PortfolioProject.dbo.employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO PortfolioProject.dbo.branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE PortfolioProject.dbo.employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO PortfolioProject.dbo.employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO PortfolioProject.dbo.employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO PortfolioProject.dbo.employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO PortfolioProject.dbo.employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO PortfolioProject.dbo.branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE PortfolioProject.dbo.employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO PortfolioProject.dbo.employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO PortfolioProject.dbo.employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO PortfolioProject.dbo.branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO PortfolioProject.dbo.client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO PortfolioProject.dbo.client VALUES(401, 'Lackawana Country', 2);
INSERT INTO PortfolioProject.dbo.client VALUES(402, 'FedEx', 3);
INSERT INTO PortfolioProject.dbo.client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO PortfolioProject.dbo.client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO PortfolioProject.dbo.client VALUES(405, 'Times Newspaper', 3);
INSERT INTO PortfolioProject.dbo.client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO PortfolioProject.dbo.works_with VALUES(105, 400, 55000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(102, 401, 267000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(108, 402, 22500);
INSERT INTO PortfolioProject.dbo.works_with VALUES(107, 403, 5000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(108, 403, 12000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(105, 404, 33000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(107, 405, 26000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(102, 406, 15000);
INSERT INTO PortfolioProject.dbo.works_with VALUES(105, 406, 130000);


--DROP TABLE PortfolioProject.dbo.employee
--DROP TABLE PortfolioProject.dbo.branch
--DROP TABLE PortfolioProject.dbo.client
--DROP TABLE PortfolioProject.dbo.works_with
--DROP TABLE PortfolioProject.dbo.branch_supplier

----DROP CONSTRAINTS
ALTER TABLE PortfolioProject.dbo.branch
DROP CONSTRAINT FK__branch__mgr_id__66603565

ALTER TABLE PortfolioProject.dbo.branch
DROP CONSTRAINT FK__branch__mgr_id__123EB7A3

ALTER TABLE PortfolioProject.dbo.branch
DROP CONSTRAINT FK__branch__mgr_id__30C33EC3

ALTER TABLE PortfolioProject.dbo.employee
DROP CONSTRAINT FK__employee__branch__31B762FC

ALTER TABLE PortfolioProject.dbo.employee
DROP CONSTRAINT FK__employee__super___3B40CD36


--ORDER BY
--find all employees ordered by salary
SELECT * FROM PortfolioProject.dbo.employee
ORDER BY salary DESC

--find all employees ordered by sex then name
SELECT * FROM PortfolioProject.dbo.employee
ORDER BY sex, first_name, last_name

--find the first 5 employees in the table
SELECT TOP 5 * FROM PortfolioProject.dbo.employee

--find first and last names of all emoloyees
SELECT first_name, last_name from PortfolioProject.dbo.employee

--DISTINCT
--find out all the different genders
SELECT DISTINCT sex from PortfolioProject.dbo.employee

--FUNCTIONS
--find total count of genders
SELECT COUNT(DISTINCT sex) as no_of_genders from PortfolioProject.dbo.employee

--find total number of employees
SELECT COUNT(emp_id) FROM PortfolioProject.dbo.employee

--find the average of all employee salary
SELECT AVG(salary) as avg_salary from PortfolioProject.dbo.employee

--max salary
SELECT MAX(salary) as avg_salary from PortfolioProject.dbo.employee

--min salary
SELECT MIN(salary) as avg_salary from PortfolioProject.dbo.employee

--how to calculate age?
--SELECT *,DATEDIFF(MONTH,date_birth,GETDATE())/12 age from PortfolioProject.dbo.employee
SELECT *,
DATEDIFF(YY,birth_day,GETDATE()) AS age
FROM PortfolioProject.dbo.employee

--GROUP BY 
--find total number of males and females
SELECT COUNT(sex), sex
FROM PortfolioProject.dbo.employee
GROUP BY sex

--extract total number of departments and employees in those departments
SELECT COUNT(branch_id) AS no_employees,branch_id
FROM PortfolioProject.dbo.employee
GROUP BY branch_id

--find the total sales of each salesmen
SELECT * from PortfolioProject.dbo.works_with
SELECT emp_id, SUM(total_sales) AS total_sales
FROM PortfolioProject.dbo.works_with
GROUP BY emp_id

--find out how much money each client spent on products
SELECT client_id, SUM(total_sales) AS total_sales
FROM PortfolioProject.dbo.works_with
GROUP BY client_id

--WILDCARD
--find any clients that are an LLC through wildcard
SELECT * FROM PortfolioProject.dbo.client
WHERE client_name LIKE '%LLC'

SELECT * FROM PortfolioProject.dbo.client
WHERE client_name LIKE 'Times%'

--find any branch suppliers who are in the label business
SELECT * from PortfolioProject.dbo.branch_supplier
WHERE supplier_name LIKE '%Labels'
--updating the supplier name in the branch supplier table
UPDATE PortfolioProject.dbo.branch_supplier
set supplier_name='Stamford Labels'
WHERE branch_id=3 and supplier_name='Stamford Lables'

--find any employee born in October through wildcard
SELECT * from PortfolioProject.dbo.employee
WHERE birth_day LIKE '____-10%'


--UNION
--find a list of all the money spent or earned by the company
SELECT salary from PortfolioProject.dbo.employee
UNION
SELECT total_sales from PortfolioProject.dbo.works_with

--JOINS

--add a new record in branch table
INSERT INTO PortfolioProject.dbo.branch VALUES(4,'Buffalo',NULL,NULL)
SELECT * FROM PortfolioProject.dbo.branch

--find all branches and the names of their managers (inner join)
SELECT PortfolioProject.dbo.employee.emp_id, PortfolioProject.dbo.employee.first_name,
PortfolioProject.dbo.branch.branch_name
FROM PortfolioProject.dbo.employee
JOIN PortfolioProject.dbo.branch
ON PortfolioProject.dbo.employee.emp_id = PortfolioProject.dbo.branch.mgr_id

--find all branches and the names of their managers (left join)
SELECT PortfolioProject.dbo.employee.emp_id, PortfolioProject.dbo.employee.first_name,
PortfolioProject.dbo.branch.branch_name
FROM PortfolioProject.dbo.employee
LEFT JOIN PortfolioProject.dbo.branch
ON PortfolioProject.dbo.employee.emp_id = PortfolioProject.dbo.branch.mgr_id

--find all branches and the names of their managers (right join)
SELECT PortfolioProject.dbo.employee.emp_id, PortfolioProject.dbo.employee.first_name,
PortfolioProject.dbo.branch.branch_name
FROM PortfolioProject.dbo.employee
RIGHT JOIN PortfolioProject.dbo.branch
ON PortfolioProject.dbo.employee.emp_id = PortfolioProject.dbo.branch.mgr_id

--Join. no. of employees in respective branch ids and the name of the branch from the branch table
SELECT PortfolioProject.dbo.branch.branch_id, PortfolioProject.dbo.branch.branch_name
FROM PortfolioProject.dbo.branch
JOIN PortfolioProject.dbo.employee
ON PortfolioProject.dbo.branch.branch_id = PortfolioProject.dbo.employee.branch_id

--no. of employees in each branch (Just one branch)
SELECT PortfolioProject.dbo.branch.branch_name, PortfolioProject.dbo.employee.branch_id
FROM PortfolioProject.dbo.branch
JOIN PortfolioProject.dbo.employee
ON PortfolioProject.dbo.branch.branch_id = PortfolioProject.dbo.employee.branch_id
WHERE PortfolioProject.dbo.branch.branch_name = 'Corporate'

--no. of employees in each branch 
SELECT PortfolioProject.dbo.employee.branch_id , COUNT(*) AS total_employees, PortfolioProject.dbo.branch.branch_name
FROM PortfolioProject.dbo.employee
JOIN PortfolioProject.dbo.branch
ON PortfolioProject.dbo.branch.branch_id = PortfolioProject.dbo.employee.branch_id
GROUP BY PortfolioProject.dbo.employee.branch_id , PortfolioProject.dbo.branch.branch_name

--find a list of money spent and earned by the company (cash flow)
SELECT PortfolioProject.dbo.works_with.emp_id, SUM(total_sales) AS revenue, COUNT(*) as total_sales, 
PortfolioProject.dbo.employee.salary as expenditure
FROM PortfolioProject.dbo.works_with
JOIN PortfolioProject.dbo.employee
ON PortfolioProject.dbo.works_with.emp_id = PortfolioProject.dbo.employee.emp_id
GROUP BY PortfolioProject.dbo.works_with.emp_id , PortfolioProject.dbo.employee.salary


--NESTED QUERIES
--find names of all employees who have sold over 30,000 to a single client
SELECT PortfolioProject.dbo.employee.first_name, PortfolioProject.dbo.employee.last_name
FROM PortfolioProject.dbo.employee
WHERE PortfolioProject.dbo.employee.emp_id IN (
	SELECT PortfolioProject.dbo.works_with.emp_id 
	FROM PortfolioProject.dbo.works_with
	WHERE PortfolioProject.dbo.works_with.total_sales > 30000
) 

--find all clients who are handled by the branch that Michael Scott manages assuming you know Michael's ID
SELECT PortfolioProject.dbo.client.client_name
FROM PortfolioProject.dbo.client
WHERE PortfolioProject.dbo.client.branch_id IN (
	SELECT PortfolioProject.dbo.branch.branch_id
	FROM PortfolioProject.dbo.branch
	WHERE PortfolioProject.dbo.branch.mgr_id = 102
)


--ON DELETE
--SET NULL

DELETE FROM PortfolioProject.dbo.employee
WHERE PortfolioProject.dbo.employee.emp_id=102

--CASCADE
DELETE FROM PortfolioProject.dbo.branch
WHERE PortfolioProject.dbo.branch.branch_id=2

SELECT * FROM PortfolioProject.dbo.employee
SELECT * FROM PortfolioProject.dbo.branch
SELECT * FROM PortfolioProject.dbo.client
SELECT * FROM PortfolioProject.dbo.works_with
SELECT * FROM PortfolioProject.dbo.branch_supplier

--TRIGGERS
USE
PortfolioProject
GO

CREATE TABLE trigger_test(
message VARCHAR(100))

USE
PortfolioProject
GO

CREATE 
TRIGGER PortfolioProject.my_trigger
	ON dbo.employee
	FOR INSERT 
	AS
	BEGIN
		INSERT INTO trigger_test VALUES('added new employee')
	END

INSERT INTO PortfolioProject.dbo.employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3)

SELECT * FROM trigger_test

