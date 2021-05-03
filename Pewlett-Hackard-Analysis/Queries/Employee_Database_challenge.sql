-- Get the list of employees and their titles who are 
-- likely to retire soon
SELECT employees.first_name, 
	employees.last_name, 
	employees.emp_no,
	titles.title, 
	titles.from_date, 
	titles.to_date
INTO retiree_title
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-1-1' AND '1955-12-31')
ORDER BY employees.emp_no;

SELECT * from retiree_title;

DROP TABLE retiree_title;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retiree_title.emp_no) 
	retiree_title.first_name, 
	retiree_title.last_name, 
	retiree_title.emp_no,
	retiree_title.title
INTO Unique_Titles
FROM retiree_title
ORDER BY retiree_title.emp_no, retiree_title.to_date DESC;

SELECT * FROM Unique_Titles; 

-- Get the count of employees for their most recent title
SELECT COUNT(Unique_Titles.emp_no), Unique_Titles.title
INTO Retiring_Titles
FROM Unique_Titles
GROUP BY Unique_Titles.title
ORDER BY COUNT(Unique_Titles.emp_no) DESC;

SELECT * FROM Retiring_Titles; 

DROP TABLE Retiring_Titles;

-- Get the list of employees eligible for the mentorship program
SELECT DISTINCT ON (employees.emp_no) 
	employees.first_name, 
	employees.last_name, 
	employees.emp_no,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship
FROM employees
	INNER JOIN titles
		ON employees.emp_no = titles.emp_no
	INNER JOIN dept_emp
		ON employees.emp_no = dept_emp.emp_no
WHERE (dept_emp.to_date = '9999-1-1') 
AND (employees.birth_date BETWEEN '1965-1-1' AND '1965-12-31')
ORDER BY employees.emp_no;

SELECT * FROM mentorship;

DROP TABLE mentorship;