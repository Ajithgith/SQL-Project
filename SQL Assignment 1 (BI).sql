


use hr ;

select * from countries ;
select * from departments ;
select * from employees ;
select * from job_history ;
select * from jobs ;
select * from locations ;
select * from regions ;

/******* 1. To display the names (first_name, last_name) using alias name “First Name", "Last Name" *******/

select first_name as 'First Name', last_name as 'Last Name' from employees ;


/******* 2. To get unique department ID from employee table *******/

select distinct department_id from employees ;


/******* 3. To get all employee details from the employee table order by first name, descending *******/

select * from employees order by first_name desc ;


/******* 4. To get the names (first_name, last_name), salary, PF of all the employees (PF is 
calculated as 15% of salary) *******/

select concat(first_name,' ',last_name) as full_name, salary, (15/100*salary) as PF from employees ;


/******* 5. To get the employee ID, names (first_name, last_name), salary in ascending order of 
salary *******/

select employee_id, concat(first_name, ' ',last_name) as full_name, salary from employees order by salary ;


/******* 6. To get the total salaries payable to employees *******/

select sum(salary) as total_salary from employees ;


/******* 7. To get the maximum and minimum salary from employees table *******/

select max(salary) as maximum_salary, min(salary) as minimum_salary from employees ;


/******* 8. To get the average salary and number of employees in the employees table *******/

select avg(salary) as average_salary, count(employee_id) as no_of_employees from employees ;


/******* 9. To get the number of employees working with the company *******/

select count(*) as no_of_employees from employees ;


/******* 10. To get the number of jobs available in the employees table *******/

select count(distinct job_id) as no_of_jobs_available from employees ;


/******* 11. To get all first name from employees table in upper case *******/

select upper(first_name) as FIRST_NAME from employees ;


/******* 12. To get the first 3 characters of first name from employees table *******/

select substr(first_name,1,3) as first_name_trimmed from employees ;


/******* 13.  To get first name from employees table after removing white spaces from both side *******/

select first_name, trim(both '  ' from first_name) as trim from employees ;


/******* 14. To get the length of the employee names (first_name, last_name) from employees table *******/

select concat(first_name,' ',last_name) as fullname, length(concat(first_name,' ',last_name)) as length_fullname from employees ;


/******* 15.  To check if the first_name fields of the employees table contains numbers *******/

select * from employees where first_name regexp '[0-9]' ;


/******* 16. To display the name (first_name, last_name) and salary for all employees whose salary is 
not in the range $10,000 through $15,000 *******/

select concat(first_name,' ',last_name) as full_name, salary from employees where salary not between 10000 and 15000 ;


/******* 17.  To display the name (first_name, last_name) and department ID of all employees in 
departments 30 or 100 in ascending order *******/

select concat(first_name,' ',last_name) as full_name, department_id from employees where department_id in(30,100) order by department_id ;


/******* 18.  To display the name (first_name, last_name) and salary for all employees whose salary is 
not in the range $10,000 through $15,000 and are in department 30 or 100 *******/

select concat(first_name,' ',last_name) as full_name, salary
 from employees
 where salary not between 10000 and 15000 and department_id in(30,100) ;


/******* 19. To display the name (first_name, last_name) and hire date for all employees who were 
hired in 1987 *******/

select concat(first_name,' ',last_name) as full_name, hire_date from employees where year(hire_date) = '1987' ;


/******* 20. To display the first_name of all employees who have both "b" and "c" in their first name *******/

select first_name from employees where first_name like '%b%' and first_name like '%c%' ;


/******* 21. To display the last name, job, and salary for all employees whose job is that of a 
Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000 *******/

select e.last_name, j.job_title, e.salary 
from employees e inner join jobs j on e.job_id = j.job_id 
where j.job_title in('Programmer','Shipping Clerk') and salary not in(4500,10000,15000) ;


/******* 22.  To display the last name of employees whose names have exactly 6 characters *******/

select last_name from employees where length(last_name) = 6 ;


/******* 23. To display the last name of employees having 'e' as the third character *******/

select last_name from employees where last_name like '__e%' ;


/******* 24. To get the job_id and related employee's id *******/

select distinct job_id, group_concat(employee_id, ' ') as Employees_ID from employees group by job_id ;


/******* 25.  To update the portion of the phone_number in the employees table, within the phone 
number the substring '124' will be replaced by '999' *******/

update employees set phone_number = replace(phone_number, '124', '999') where phone_number like '%124%' ;


/******* 26.  To get the details of the employees where the length of the first name greater than or 
equal to 8 *******/

select * from employees where length(first_name) >= 8 ;


/******* 27. To append '@example.com' to email field *******/

select concat(email,'@example.com') as email_id from employees ;


/******* 28. To extract the last 4 character of phone numbers *******/

select right(phone_number,4) from employees ;


/******* 29. To get the last word of the street address *******/

 select street_address, substring_index(replace(replace(replace(street_address, ',',' '),')',' '), '(',' '),' ',-1)
 as last_word_street_address from locations ;


/******* 30. To get the locations that have minimum street length *******/

select * from locations where length(street_address) <= (select min(length(street_address)) from locations) ;


/******* 31. To display the first word from those job titles which contains more than one words *******/

select job_title, substr(job_title, 1, instr(job_title, ' ')-1) as first_word_job_title from jobs ;


/******* 32.  To display the length of first name for employees where last name contain character 'c' 
after 2nd position *******/

select first_name, length(first_name) as len_first_name from employees where last_name like '__c%' ;


/******* 33. To display the first name and the length of the first name for all employees whose 
name starts with the letters 'A', 'J' or 'M' and sorting the results by the 
employees' first names *******/

select first_name, length(first_name) as len_first_name
 from employees
 where first_name like 'A%' or first_name like 'J%' or first_name like 'M%' order by first_name ;
 
 
 /******* 34. To display the first name and salary for all employees, format the salary to be 10 
characters long, left-padded with the $ symbol, label the column SALARY *******/

select first_name, lpad(salary, 10, '$') as 'SALARY' from employees ;


/******* 35. To display the first eight characters of the employees' first names and indicates the 
amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars and sorting the data in 
descending order of salary *******/

select concat(first_name,' ',last_name) as full_name, substr(first_name,1,8) as first_name_trimmed, concat('$',salary/1000) as salary_in_dollars
from employees
order by salary desc ;


/******* 36. To display the employees with their code, first name, last name and hire date who hired 
either on seventh day of any month or seventh month in any year *******/

select employee_id, first_name, last_name, hire_date from employees where day(hire_date) = '7' or month(hire_date) = '7' ;



























