USE mystery;

SHOW tables;

DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;

SHOW CREATE TABLE titles; /* Show primary keys + foreign keys */

SELECT COUNT(*) FROM employees;
SELECT emp_no, first_name, last_name, title FROM titles INNER JOIN employees USING (emp_no);
SELECT MAX(salary) FROM salaries;
SELECT MIN(salary) FROM salaries;
SELECT SUM(salary) / COUNT(*) FROM salaries;
SELECT first_name, last_name, salary FROM salaries INNER JOIN employees USING (emp_no) ORDER BY salary DESC LIMIT 10;
SELECT SUM(salary) FROM salaries;
SELECT MIN(birth_date) FROM employees;
SELECT first_name, last_name FROM employees WHERE birth_date = 19520201;
SELECT MAX(birth_date) FROM employees;
SELECT first_name, last_name FROM employees WHERE birth_date = 19650201;
SELECT MAX(hire_date) FROM employees;
SELECT first_name, last_name FROM employees WHERE hire_date = 20000128;
SELECT COUNT(*) FROM employees WHERE gender = 'F';
SELECT COUNT(*) FROM employees WHERE gender = 'M';
SELECT 120051/179973;
SELECT first_name, last_name FROM employees WHERE birth_date > 19610000;
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd001';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd002';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd003';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd004';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd005';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd006';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd007';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd008';
SELECT first_name, last_name, emp_no, dept_no FROM dept_emp INNER JOIN employees USING (emp_no) where dept_no = 'd009';
SELECT MAX(CHARACTER_LENGTH(first_name)) FROM employees;
SELECT MAX(CHARACTER_LENGTH(last_name)) FROM employees;
SELECT first_name FROM employees WHERE CHARACTER_LENGTH(first_name) = 14;
SELECT last_name FROM employees WHERE CHARACTER_LENGTH(last_name) = 16;
/* 11  */
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date < 20060000;

SELECT emp_no, count(DISTINCT dept_no) FROM dept_emp GROUP BY emp_no;

SELECT emp_no, COUNT(*) FROM salaries
  INNER JOIN employees USING (emp_no)
  INNER JOIN dept_emp USING (emp_no)
  INNER JOIN departments USING (dept_no)
    WHERE departments.dept_name = 'Development'
    AND first_name = "Moon"
    AND birth_date LIKE '1952-12%'
  GROUP BY emp_no HAVING COUNT(*) = 6;

SELECT first_name, last_name, emp_no, COUNT(*) FROM salaries
  INNER JOIN employees USING (emp_no)
  WHERE FLOOR(emp_no/1000) = 14
  AND employees.first_name LIKE 'G%'
  GROUP BY emp_no HAVING COUNT(*) = 1;

SELECT emp_no, first_name, last_name FROM employees
  INNER JOIN dept_emp USING (emp_no)
  INNER JOIN departments USING (dept_no)
  INNER JOIN salaries USING (emp_no)
    WHERE dept_name LIKE 'Research'
    AND first_name LIKE 'Ba%'
    AND dept_emp.to_date LIKE '2000%'
  GROUP BY emp_no HAVING COUNT(*) = 10;

SELECT * FROM employees;

/* first name - kk; last name - tt; emp num includes two 7s */
SELECT emp_no, first_name, last_name FROM employees
  WHERE first_name LIKE "%kk%"
  AND last_name LIKE "%tt%"
  AND emp_no LIKE '%7%7%';

SELECT emp_no, first_name, last_name FROM employees
  INNER JOIN salaries USING (emp_no)
  WHERE first_name LIKE "Al%o"
  AND emp_no LIKE '%1%1%'
  GROUP BY emp_no HAVING COUNT(*) = 10;
