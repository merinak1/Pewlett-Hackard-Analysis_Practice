SELECT * FROM departments;
SELECT * FROM employees;

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--DROP TABLE retirement_info
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- using aliases
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments d
INNER JOIN dept_manager dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info ri
LEFT JOIN dept_emp de
ON ri.emp_no = de.emp_no;


SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
	ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--1 Employee Information: A list of employees containing their unique 
-- employee number, their last name, first name, gender, and salary
SELECT  e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees e 
INNER JOIN salaries as s
	ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
 	AND (de.to_date = '9999-01-01');

--2) Management: A list of managers for each department, including the
-- department number, name, and the manager's employee number, last name, first name, 
-- and the starting and ending employment dates
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT * FROM dept_manager where to_date = '9999-01-01'


-- 3) Department Retirees: An updated current_emp list that includes everything it 
-- currently has, but also the employee's departments
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


/* Create a query that will return only the information relevant to the Sales team.
The requested list includes:
Employee numbers
Employee first name
Employee last name
Employee department name
*/

SELECT ei.emp_no,ei.first_name,ei.last_name, d.dept_name
FROM emp_info ei
INNER JOIN dept_emp de
	on ei.emp_no = de.emp_no
INNER JOIN departments d
	ON de.dept_no = d.dept_no
WHERE d.dept_name ='Sales'

/* Create another query that will return the following information for the Sales and Development teams:
The requested list includes:
Employee numbers
Employee first name
Employee last name
Employee department name
*/
SELECT ei.emp_no,ei.first_name,ei.last_name, d.dept_name
FROM emp_info ei
INNER JOIN dept_emp de
	on ei.emp_no = de.emp_no
INNER JOIN departments d
	ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales','Development')