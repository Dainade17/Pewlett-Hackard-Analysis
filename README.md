# Pewlett-Hackard-Analysis

The purpose of this analysis:
The purpose of this analysis is to find the total number of employees who would retire in the upcoming 3 years and create a robust mentorship program where the retiring employees can mentor the new talents

Results: 

Deliverable 1-
We focused on finding the total number of employees who are going to retire.
 - We first created a table where we stored list of employees we are going to retire by filtering on their DOB
 
 Query used: \
  SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date \
  INTO retiring_emp \
  FROM employees as e \
  join Titles as t \
  on e.emp_no = t.emp_no \
  WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') \
  order by emp_no; 
  
  - We then refactored the code to remove any old emp positions which are no longer eligible due to employee promotions, we did this by ordering "title to date" in descending order \

Query used:
SELECT distinct on (emp_no) emp_no,first_name,last_name,title \
into unique_titles \
from retiring_emp as rt \
order by emp_no asc, to_date desc; 

- We further refactored the code to find the final number of employees who will retire by only keeping current employees and grouped them by titles

Query used:

SELECT count(ut.emp_no) as emp_count , ut.title \
into Retiring_Titles \
from unique_titles as ut \
join current_emp as ce \
on ut.emp_no = ce.emp_no \
where ce.to_date = '9999-01-01' \
group by title \
order by emp_count desc;


Deliverable 2-

We analysed and found out who are eligible to mentor new talents by only extracting employees whose DOB is between 1965-01-01' AND '1965-12-31 i.e. employees who would retire first and grouped them by their department so that they are paired with the right candidates with in their department

Query used:
SELECT distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, d.from_date, d.to_date, t.title \
Into mentorship_eligibility \
FROM employees AS e \
JOIN dept_emp as d \
ON (e.emp_no= d.emp_no) \
JOIN titles as t \
ON (e.emp_no = t.emp_no) \
where (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') \
and d.to_date = '9999_01_01' \
order by e.emp_no


Summary:
Total roles that needs to be filled : 33118

Query used:
select sum(emp_count) from retiring_titles;

Total eligible mentors: 1549

Query used:
select sum(emp_count) from retiring_titles;
