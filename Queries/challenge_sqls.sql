-- -- Use Dictinct with Orderby to remove duplicate rows
-- SELECT DISTINCT ON (______) _____,
-- ______,
-- ______,
-- ______

-- INTO nameyourtable
-- FROM _______
-- ORDER BY _____, _____ DESC;
Using the ERD you created in this module as a reference and your knowledge of SQL queries, 
create a Retirement Titles table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955. 
Because some employees may have multiple titles in the database—for example, due to promotions—you’ll need to use the 
DISTINCT ON statement to create a table that contains the most recent title of each employee. 
Then, use the COUNT() function to create a final table that has the number of retirement-age employees by most recent job title.

SELECT emp_no, title FROM titles where  to_date = '9999-01-01'

SELECT e.emp_no, e.first_name, e.last_name , t.title, t.from_date, t.to_date 
INTO retirement_titles
FROM employees e
INNER JOIN titles as t
	ON (t.emp_no = e.emp_no)
WHERE (e.birth_date >= '1952-01-01' and e.birth_date <= '1955-12-31')
ORDER BY e.emp_no ;

-- number of employees by their most recent job title who are about to retire
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name , title   
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no,to_date desc;

SELECT DISTINCT count(title), title FROM unique_titles Group by title ORDER BY 1 DESC
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no),
first_name, last_name , title, from_date, to_date 
--INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;

-- DELIVERABLE #2
---Employees eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no)e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date,t.title
FROM employees as e
INNER JOIN dept_emp de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
	ON (t.emp_no = e.emp_no)
WHERE (e.birth_date >= '1965-01-01' and e.birth_date <= '1965-12-31')
ORDER BY e.emp_no, t.to_date desc

-- INNER JOIN dept_emp as de
-- 	ON (e.emp_no = de.emp_no)

-- WHERE (e.birth_date > '1952-01-01' and e.birth_date > '1955-12-31')
-- 	AND (de.to_date = '9999-01-01')
-- 	AND (t.to_date = '9999-01-01')
-- ORDER BY e.emp_no ;

