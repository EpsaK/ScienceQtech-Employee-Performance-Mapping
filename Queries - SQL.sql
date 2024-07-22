1) Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.
create database employee
use employee

2) Create an ER diagram for the given employee database.
Screenshot taken separately

3) Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table
 
4) Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
a) less than two
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
from emp_record_table
where EMP_RATING <2

b) greater than four 
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
from emp_record_table
where EMP_RATING>4

c) between two and four
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
from emp_record_table
where EMP_RATING between 2 and 4
 
5) Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
select concat(first_name, ' ', last_name) as Name
from emp_record_table
where DEPT = 'Finance'
 
6) Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
select MANAGER_ID, count(*)
from emp_record_table
where MANAGER_ID is not Null
group by MANAGER_ID


7) Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.
select * from emp_record_table
where DEPT = 'Finance'
union
select * from emp_record_table
where DEPT = 'Healthcare'
 
8) Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.
select * from (select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING from emp_record_table)
as t1
left join
(select dept, max(EMP_RATING) from emp_record_table
group by dept) as t2
on t1.DEPT =t2.dept

9 Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
select ROLE, min(salary), max(salary) from emp_record_table
group by ROLE

10) Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
select *, rank() over (order by EXP desc) from emp_record_table
 
11) Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
create view vw_employee
as
select * from emp_record_table
where SALARY>6000
select * from vw_employee

12) Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
select * from 
(select * from emp_record_table
where EXP >10) as nestedquery
 
13) Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.
delimiter //
create procedure emp_exp_three()
begin
select * from emp_record_table
where EXP >3;
end //
delimiter ;

call emp_exp_three
 

14) Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.

select *, if(EXP<=2, 'JUNIOR DATA SCIENTIST',
if(EXP<=5, 'ASSOCIATE DATA SCIENTIST',
if(EXP<=10, 'SENIOR DATA SCIENTIST',
if(EXP<=12, 'LEAD DATA SCIENTIST',
if(EXP<=16, 'MANAGER',
null))))) as Job_Role
from emp_record_table

 15) Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
alter table emp_record_table
modify FIRST_NAME char(100)
create index ix_fname_tb on emp_record_table(FIRST_NAME)
select * from emp_record_table where FIRST_NAME ='Eric'

16) Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
select *, salary*0.05*EMP_RATING as Bonus from emp_record_table
 

17) Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
 select CONTINENT, COUNTRY, avg(SALARY) from emp_record_table
 group by CONTINENT, COUNTRY
