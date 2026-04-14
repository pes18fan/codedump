-- q1: find bookname, publication name and author name whose publication is Ekta
select b.bname, bl.publication, b.author
from book as b,
	 booklist as bl
where b.bid = bl.isbn and 
      bl.publication = 'Ekta';

-- q2: find all the teachers name and faculty who issued book on Jan 1, 2015
select t.tname, t.faculty
from teacher as t,
	 issues as i
where t.tname = i.iname;	-- assuming t.tname and i.iname are both a teacher's name

-- q3: find employee name whose salary is greater than 10000 and faculty is "Computer"
select t.tname
from teacher as t,
	 employee as e
where t.tname = e.ename and t.faculty = 'Computer';

-- q4: add attribute 'bid' on 'issues' relation
alter table issues
add   bid int;

alter table issues
add foreign key(bid) references book(bid);

-- q5: insert data in bid column (use update)
update issues
set issues.bid = 1;

-- q6: find teacher's name and book name issued by teacher whose name starts with 'S'
select i.iname, b.bname
from teacher as t,
	 book as b,
	 issues as i
where i.iname = t.tname and b.bid = i.bid and i.iname like 'S%';

-- q7: update all salary by 10%
update employee
set salary = 1.1 * salary;

-- q8: update bookname DBMS as Database
insert into book
values
(5, 'DBMS', 'Karan', 600);

update book
set bname = 'Database'
where bname = 'DBMS';

-- q9: update salary of all employee by 20% whose salary is less than 5000.
insert into employee
values
(6, 'Shyam', '2019-07-12', 3000);

update employee
set salary = 1.2 * salary
where salary < 5000;

-- q10: provide 5% increment to all salaries whose salary is greater than 20000 and 20% increment to rest of salaries
update employee
set salary = 
case
	when salary > 20000 then 1.05 * salary
	else 1.2 * salary
end;

-- q11: delete the records from employee table whose eid is 111
delete from employee
where eid = 111;

-- q12: use sub query to find all teacher's name and faculty whose date of joining is 2016-05-25.
select tname, faculty 
from teacher
where tname in (
	select ename
	from employee
	where dateofemploy = '2016-05-25'
);

-- q13: use sub query to find all the bookname and author name whose publication is 'Ekta'
select bname, author
from book
where bid in (
	select isbn
	from booklist
	where publication = 'Ekta'
);
