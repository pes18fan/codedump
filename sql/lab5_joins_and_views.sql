-- q1: perform join operation on teacher and employee tables and display ename, faculty and salary
select e.ename, t.faculty, e.salary
from teacher as t
join employee as e
	on t.tid = e.eid;

-- q2: perform left join on booklist and book table
select *
from booklist as bl
left join book as b
	on bl.isbn = b.bid;

-- q3: perform right join on booklist and book table
select *
from booklist as bl
right join book as b
	on bl.isbn = b.bid;

-- q4: perform full join on students and issues table (where name starts with 'C')
select *
from booklist as bl
left join book as b
	on bl.isbn = b.bid
where b.bname like 'C%'

union

select *
from booklist as bl
right join book as b
	on bl.isbn = b.bid
where b.bname like 'C%';

-- q5: display name of employee who is also a teacher
select t.tname
from employee as e
join teacher as t
	on e.eid = t.tid;

-- q6: display name of the employee who is also teacher (use intersect)
select ename from employee
intersect
select tname from teacher;

-- q7: display all employees name except the name who are teachers (use except)
select ename from employee
except
select tname from teacher;

-- q8: create a view employee_view which consists of eid, ename, salary as attributes
create view employee_view as
select eid, ename, salary
from employee;

-- q9: insert a new record in recently created view, and also display the contents of primary table
insert into employee_view values
(6, 'Sabin', 4000);

-- q10: delete information from view whose salary are less than 5000
delete from employee_view
where salary < 5000;

select * from employee_view;

