/* 

Data Processing

*/

-------------------------------------------
/* Count the number of rows in each table to see which one has the most data */
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
/* View the first 20 rows from each table to understand the structure */

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
/* Check NULL values in tables */

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

-- ✅ No NULL values found in these tables

-------------------------------------------
/* Check for Duplicate data */

-- Find duplicate employee IDs in dbo.employee
SELECT id, COUNT(*) AS duplicate_count
FROM dbo.employee
GROUP BY id
HAVING COUNT(*) > 1;


