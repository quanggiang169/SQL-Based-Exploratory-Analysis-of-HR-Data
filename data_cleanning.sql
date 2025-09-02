/* 

I. Data Cleanning

*/

-------------------------------------------
/* 1. Count the number of rows in each table to see which one has the most data */
SELECT 'employee' AS table_name, COUNT(*) AS row_count FROM dbo.employee
UNION ALL
SELECT 'department', COUNT(*) FROM dbo.department
UNION ALL
SELECT 'department_employee', COUNT(*) FROM dbo.department_employee
UNION ALL
SELECT 'department_manager', COUNT(*) FROM dbo.department_manager
UNION ALL
SELECT 'salary', COUNT(*) FROM dbo.salary
UNION ALL
SELECT 'title', COUNT(*) FROM dbo.title;

-------------------------------------------
/* 2. View the first 20 rows from each table to understand the structure */

SELECT TOP 20 * FROM dbo.employee; 
-- dbo.employee: Each row represents a unique employee's information.

SELECT TOP 20 * FROM dbo.department; 
-- dbo.department: Each row represents a unique department.

SELECT TOP 20 * FROM dbo.department_employee; 
	SELECT TOP 5 employee_id, COUNT(DISTINCT department_id) AS unique_departments
	FROM dbo.department_employee
	GROUP BY employee_id
	ORDER BY unique_departments DESC
		SELECT * FROM dbo.department_employee
		WHERE employee_id = 10010
-- dbo.department_employee: Each row represents a period when an employee worked in a department. 
--                          An employee may belong to multiple departments at different times.

SELECT TOP 20 * FROM dbo.department_manager;
	SELECT *
	FROM dbo.department_manager
	WHERE department_id = 'd001'
	ORDER BY from_date;
-- dbo.department_manager: Each row represents a department manager. 
--                          A department may have different managers over time.

SELECT TOP 20 * FROM dbo.salary;
	SELECT TOP 5 employee_id, COUNT(employee_id) AS id_count
	FROM dbo.salary
	GROUP BY employee_id
	ORDER BY id_count DESC
		SELECT * FROM dbo.salary
		WHERE employee_id = 10009;
-- dbo.salary: Each row represents an employee's salary for a specific time period. 
--             An employee may receive multiple salary adjustments over time.

SELECT TOP 20 * FROM dbo.title;
	SELECT TOP 20 employee_id, COUNT(employee_id) AS id_count
	FROM dbo.title
	GROUP BY employee_id
	ORDER BY id_count DESC
		SELECT * FROM dbo.title
		WHERE employee_id = 10009
		ORDER BY  from_date;
-- dbo.title: Each row represents an employee's job title for a specific time period. 
--            An employee may hold different job titles over time.

-------------------------------------------
/* 3. Check NULL values in tables */

-- Count NULL values in each column of the employee table
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS missing_id,
    SUM(CASE WHEN birth_date IS NULL THEN 1 ELSE 0 END) AS missing_birth_date,
    SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS missing_first_name,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS missing_last_name,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS missing_gender,
    SUM(CASE WHEN hire_date IS NULL THEN 1 ELSE 0 END) AS missing_hire_date
FROM dbo.employee;

-- Count NULL values in each column of the department table
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS missing_id,
    SUM(CASE WHEN dept_name IS NULL THEN 1 ELSE 0 END) AS missing_dept_name
FROM dbo.department;

-- Count NULL values in each column of the department_employee table
SELECT 
    SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS missing_employee_id,
    SUM(CASE WHEN department_id IS NULL THEN 1 ELSE 0 END) AS missing_department_id,
    SUM(CASE WHEN from_date IS NULL THEN 1 ELSE 0 END) AS missing_from_date,
    SUM(CASE WHEN to_date IS NULL THEN 1 ELSE 0 END) AS missing_to_date
FROM dbo.department_employee;

-- Count NULL values in each column of the department_manager table
SELECT 
    SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS missing_employee_id,
    SUM(CASE WHEN department_id IS NULL THEN 1 ELSE 0 END) AS missing_department_id,
    SUM(CASE WHEN from_date IS NULL THEN 1 ELSE 0 END) AS missing_from_date,
    SUM(CASE WHEN to_date IS NULL THEN 1 ELSE 0 END) AS missing_to_date
FROM dbo.department_manager;

-- Count NULL values in each column of the salary table
SELECT 
    SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS missing_employee_id,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS missing_amount,
    SUM(CASE WHEN from_date IS NULL THEN 1 ELSE 0 END) AS missing_from_date,
    SUM(CASE WHEN to_date IS NULL THEN 1 ELSE 0 END) AS missing_to_date
FROM dbo.salary;

-- Count NULL values in each column of the title table
SELECT 
    SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS missing_employee_id,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS missing_title,
    SUM(CASE WHEN from_date IS NULL THEN 1 ELSE 0 END) AS missing_from_date,
    SUM(CASE WHEN to_date IS NULL THEN 1 ELSE 0 END) AS missing_to_date
FROM dbo.title;

-- No NULL values found in these tables

-------------------------------------------
/* 4. Check for Duplicate data */

-- Find duplicate employee IDs in dbo.employee
SELECT id, COUNT(*) AS duplicate_count
FROM dbo.employee
GROUP BY id
HAVING COUNT(*) > 1;

-- Find duplicate department IDs in dbo.department
SELECT id, COUNT(*) AS duplicate_count
FROM dbo.department
GROUP BY id
HAVING COUNT(*) > 1;

-- Find duplicate department assignments for employees
SELECT employee_id, department_id, from_date, to_date, COUNT(*) AS duplicate_count
FROM dbo.department_employee
GROUP BY employee_id, department_id, from_date, to_date
HAVING COUNT(*) > 1;

-- Find duplicate department manager assignments
SELECT employee_id, department_id, from_date, to_date, COUNT(*) AS duplicate_count
FROM dbo.department_manager
GROUP BY employee_id, department_id, from_date, to_date
HAVING COUNT(*) > 1;

-- Find duplicate salary records for employees
SELECT employee_id, amount, from_date, to_date, COUNT(*) AS duplicate_count
FROM dbo.salary
GROUP BY employee_id, amount, from_date, to_date
HAVING COUNT(*) > 1;

-- Find duplicate job title records for employees
SELECT employee_id, title, from_date, to_date, COUNT(*) AS duplicate_count
FROM dbo.title
GROUP BY employee_id, title, from_date, to_date
HAVING COUNT(*) > 1;

-------------------------------------------
/* 5. Check for anomalies in time data */

-- Find records where to_date is before from_date
SELECT 'department_employee' AS table_name, employee_id, from_date, to_date 
FROM dbo.department_employee 
WHERE to_date < from_date

UNION ALL

SELECT 'department_manager' AS table_name, employee_id, from_date, to_date
FROM dbo.department_manager 
WHERE to_date < from_date

UNION ALL

SELECT 'salary' AS table_name, employee_id, from_date, to_date
FROM dbo.salary 
WHERE to_date < from_date

UNION ALL

SELECT 'title' AS table_name, employee_id, from_date, to_date
FROM dbo.title 
WHERE to_date < from_date;

-- Find overlapping department assignments
SELECT a.employee_id, a.department_id, a.from_date, a.to_date, 
       b.from_date AS overlapping_from, b.to_date AS overlapping_to
FROM dbo.department_employee a
JOIN dbo.department_employee b
ON a.employee_id = b.employee_id
AND a.department_id = b.department_id
AND a.from_date < b.to_date
AND a.to_date > b.from_date
AND a.from_date <> b.from_date;

-- Find salary records where salary starts before hire date
SELECT s.employee_id, s.from_date, s.to_date, e.hire_date
FROM dbo.salary s
JOIN dbo.employee e
ON s.employee_id = e.id
WHERE s.from_date < e.hire_date;

-- Find title records where an employee gets a new title before the previous one ends
SELECT a.employee_id, a.title AS old_title, a.from_date AS old_from, a.to_date AS old_to, 
       b.title AS new_title, b.from_date AS new_from, b.to_date AS new_to
FROM dbo.title a
JOIN dbo.title b
ON a.employee_id = b.employee_id
AND a.to_date > b.from_date
AND a.title <> b.title
ORDER BY a.employee_id, a.from_date;
-- Many cases of employees getting new titles before the old titles end were discovered.

	SELECT employee_id, title, COUNT(*) as count_records
	FROM dbo.title
	GROUP BY employee_id, title
	HAVING COUNT(*) > 1;
	-- No employee has the same title more than once.

-------------------------------------------
/* 6. Ensure that all the values in the foreign key columns actually exist in the referenced table. */

-- Verify that each employee_id in department_employee exists in employee
SELECT DISTINCT de.employee_id
FROM dbo.department_employee de
LEFT JOIN dbo.employee e ON de.employee_id = e.id
WHERE e.id IS NULL;

-- Verify that each department_id in department_employee exists in department
SELECT DISTINCT de.department_id
FROM dbo.department_employee de
LEFT JOIN dbo.department d ON de.department_id = d.id
WHERE d.id IS NULL;

-- Verify that each employee_id in department_manager exists in employee
SELECT DISTINCT dm.employee_id
FROM dbo.department_manager dm
LEFT JOIN dbo.employee e ON dm.employee_id = e.id
WHERE e.id IS NULL;
-- There are 24 employee_id values in department_manager that do not exist in employee.

-- Verify that each department_id in department_manager exists in department
SELECT DISTINCT dm.department_id
FROM dbo.department_manager dm
LEFT JOIN dbo.department d ON dm.department_id = d.id
WHERE d.id IS NULL;

-- Verify that each employee_id in salary exists in employee
SELECT DISTINCT s.employee_id
FROM dbo.salary s
LEFT JOIN dbo.employee e ON s.employee_id = e.id
WHERE e.id IS NULL;

-- Verify that each employee_id in title exists in employee
SELECT DISTINCT t.employee_id
FROM dbo.title t
LEFT JOIN dbo.employee e ON t.employee_id = e.id
WHERE e.id IS NULL;