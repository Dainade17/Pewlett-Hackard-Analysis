--# deliverable 1

--1. Retrieve the emp_no, first_name, and last_name columns from the Employees table
select emp_no, first_name, last_name
from Employees

--2. Retrieve the title, from_date, and to_date columns from the Titles table
select title, from_date, to_date
from Titles

--3. Create a new table using the INTO clause
--4. Join both table on primary key
--5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. 
    --Then, order by the employee number

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO emp_info_1952to1955
FROM Employees as e
join Titles as t
on e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by emp_no;

--9. Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
    --These columns will be in the new table that will hold the most recent title of each employee.
--10. Use Dictinct on with Orderby to remove duplicate rows from the created table 
    --and paste the value in a new table with 4 columns emp_no, first_name,last_name,title
--11. Create a Unique Titles table using the INTO clause.
--12. Sort the Unique Titles table in ascending order by the employee number and descending order by 
    -- the last date (i.e. to_date) of the most recent title.

SELECT distinct on (emp_no) emp_no,first_name,last_name,title
into unique_titles
from emp_info_1952to1955 as rt
order by emp_no asc, to_date desc;

-- 15. Write another query in the Employee_Database_challenge.sql file to 
    --retrieve the number of employees by their most recent job title who are about to retire
--16. First, retrieve the number of titles from the Unique Titles table.
--17. Then, create a Retiring Titles table to hold the required information.
--18. Group the table by title, then sort the count column in descending order.

SELECT count(ut.emp_no) as emp_count , ut.title
into Retiring_Titles
from unique_titles as ut
join current_emp as ce
on ut.emp_no = ce.emp_no
where ce.to_date = '9999-01-01'
group by title
order by emp_count desc;

-- # Deliverable 2

--1. Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
--2. Retrieve the from_date and to_date columns from the Department Employee table.
--3. Retrieve the title column from the Titles table.
--4. Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
--5. Create a new table using the INTO clause.
--6. Join the Employees and the Department Employee tables on the primary key.
--7. Join the Employees and the Titles tables on the primary key.
--8. Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns 
    --to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
--9. Order the table by the employee number.

SELECT distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, d.from_date, d.to_date, t.title 
Into mentorship_eligibility
FROM employees AS e
JOIN dept_emp as d
ON (e.emp_no= d.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
where (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
and d.to_date = '9999_01_01'
order by e.emp_no
