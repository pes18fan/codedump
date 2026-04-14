-- new table for some questions
create table student (
    roll int primary key,
	sname varchar(50),
	batch int,
	faculty varchar(10)
);

insert into student values
(1, 'Ram', '2079', 'BCT'),
(2, 'Shyam', '2080', 'BEI'),
(3, 'Hari', '2081', 'BCE');

-- q1: display all employee details
create procedure employee_details as
	select * from employee;

exec employee_details;

-- q2: display employee name and salary using employee id
create procedure employee_name_salary
@eid int as
	select ename, salary
	from employee
	where eid = @eid;

exec employee_name_salary @eid = 1;

-- q3: create a stored procedure to update teacher salaryby percentage.
-- procedure should take tid and percentage increment from user
create procedure update_teacher_salary_by_percentage
@tid int,
@percentage int
as
	update employee
	set salary = salary + 0.01 * @percentage * salary
	where eid = @tid;	-- assuming eid and tid are the same

exec update_teacher_salary_by_percentage @tid = 1, @percentage = 10;

-- q4: display highest paid employee
create procedure display_highest_paid_employee as
	select * from employee
	where salary = (
		select max(salary) from employee
	);

exec display_highest_paid_employee;

-- q5: display books by author
create procedure display_books_by_author
@author varchar(50)
as
	select author, bname
	from book
	where author = @author;

drop procedure display_books_by_author;

exec display_books_by_author @author = 'Tim';

-- q6: display total salary of teachers and employee
create procedure total_salary
as
	select sum(salary) as total_salary
	from employee;

exec total_salary;

-- q7: display students by batch
create procedure display_students_by_batch 
@batch int
as
	select batch, sname
	from student
    where batch = @batch;

exec display_students_by_batch
