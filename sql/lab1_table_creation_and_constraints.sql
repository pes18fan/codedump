-- q1: create tables given
create table employee (
	eid           int,
	ename         varchar(30),
	dateofemploy  date,
	salary        int,
	primary       key(eid)
);

create table booklist (
	isbn        int,
	bname       varchar(30),
	publication varchar(30),
	primary     key(isbn)
);

create table book (
	bid     int,
	bname   varchar(30),
	author  varchar(30),
	price   int,
	primary key(bid)
);

create table issues (
	iid         int,
	iname       varchar(30),
	dateofissue date,
	primary     key(iid)
);

-- q2:  add iid foreign key on eid, bid foreign key on isbn
alter table employee
add iid int;

alter table employee
add foreign key(iid) references issues(iid);

alter table booklist
add bid int;

alter table booklist
add foreign key(bid) references book(bid);

-- q3: price of book must not be over 5000
alter table book
add check (price < 5000);

-- q4: ename, book.bname and booklist.bname must contain some value
alter table employee
alter column ename varchar(30) not null;

alter table booklist
alter column bname varchar(30) not null;

alter table book
alter column bname varchar(30) not null;

-- q5: add 5 records into each
insert into employee
values
( 1, 'a', '2025-07-12', 30000 ),
( 2, 'b', '2025-07-12', 20000 ),
( 3, 'c', '2025-07-12', 40000 ),
( 4, 'd', '2025-07-12', 35000 ),
( 5, 'e', '2025-07-12', 25000 );

insert into booklist
values
( 1, 'a', 'Penguin' ),
( 2, 'b', 'Macmillan' ),
( 3, 'c', 'Penguin' ),
( 4, 'd', 'Penguin' ),
( 5, 'e', 'Macmillan' );

insert into book
values
( 1, 'a', 'f', 4000 ),
( 2, 'b', 'g', 3000 ),
( 3, 'c', 'h', 4500 ),
( 4, 'd', 'i', 4000 ),
( 5, 'e', 'j', 2000 );

insert into issues
values
( 1, 'a', '2025-07-12' ),
( 2, 'b', '2025-07-12' ),
( 3, 'c', '2025-07-13' ),
( 4, 'd', '2025-08-29' ),
( 5, 'e', '2025-09-21' );

-- q6: set default value of dateofemploy to 1st Jan, 2010.
alter table employee
add constraint df_dateofemploy
default '2010-01-01' for dateofemploy;

-- q7: display eid and name of all employees with salary less than 10000
select eid, name from employee
where salary < 30000;

-- q8: display all record of book whose price ranges from 3000 to 5000
select * from book
where price between 3000 and 5000;

-- q9: display all record from booklist relation where publication name starts from 'E'
select * from booklist
where publication like 'E%';

-- q10: display all records from books where bid is in range 1001 to 2000 or price in range 1000 to 2500
select * from book
where bid between 1001 and 2000 and price between 1000 and 2500;

-- q11: display records from employee where name ends with 'a'
select * from employee
where ename like '%a';

-- q12: display iid, name where name consists exactly of 5 characters
select iid, iname from issues
where iname like '_____';

-- q13: display all records from salary where name starts with 'S' and salary greater than 20000
select salary from employee
where ename like 'S%' and salary > 20000;

-- q14: display those employee names and salary whose name starts with 'S' and whose name consists 'ni' as substring
select ename, salary from employee
where ename like 'S%ni%';

-- qx: display all
select * from employee;
select * from booklist;
select * from book;
select * from issues;
