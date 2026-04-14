-- q1: sort employee records in descending order (using a relevant attribute)
select *
from employee
order by salary desc;

-- q2: sort bname and publication of booklist in ascending order
select *
from booklist
order by bname, publication;

-- q3: display top three records from teacher relation
select top(3) *
from teacher;

-- q4: display the sum of salaries of employees
select sum(salary) as total
from employee;

-- q5: display minimum salary of employees
select min(salary) as minimum
from employee;

-- q6: display average price of book written by same author
select avg(price) as average
from book
where author = 'John';

-- q7: display publication name, no. of books published by it from booklist relation publication wise
select publication, count(*) as book_count
from booklist
group by publication;

-- q8: display bid, bname of books whose price is higher than the average price of books
select bid, bname
from book
where price > (select avg(price) from book);

-- q9: find bid, bname and author in ascending order where author name starts with 'S'
select bid, bname, author
from book
where author like 'S%';

-- q10: find teachers name and book taken by him. The teachers salary who takes the book must be maximum salary.
-- idk how to do this

-- q11: find author name who have written more than one book
select author, count(*) as book_count
from book
group by author
having count(*) > 1;

