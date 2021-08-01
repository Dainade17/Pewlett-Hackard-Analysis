--# deliverable 1

--Retrieve the emp_no, first_name, and last_name columns from the Employees table
select emp_no, first_name, last_name
from Employees

--Retrieve the title, from_date, and to_date columns from the Titles table
select title, from_date, to_date
from Titles

--Create a new table using the INTO clause

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO emp_info_1952to1955
FROM Employees as e
join Titles as t
on e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by emp_no;


-- Use Dictinct on with Orderby to remove duplicate rows from the created table 
--and paste the value in a new table with 4 columns emp_no, first_name,last_name,title
-- (Covers Challenge bullet 8 to 14)

SELECT distinct on (emp_no) emp_no,first_name,last_name,title
--into unique_titles
from emp_info_1952to1955 as rt
order by emp_no asc, to_date desc;

select * from unique_titles;

-- 15. Write another query in the Employee_Database_challenge.sql file to 
--retrieve the number of employees by their most recent job title who are about to retire
SELECT count(emp_no) as emp_count , title
into Retiring_Titles
from unique_titles
group by title
order by emp_count desc;

-- # Deliverable 2
