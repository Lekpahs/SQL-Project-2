-- creating a temp table 
drop table if exists #Employee
create table #Employee(
    id int,
    gender varchar (20),
    educ int,
    jobcat smallint,
    salary int,
    salbegin int,
    jobtime int,
    prevexp int,
    minority smallint
)
-- inserting values into the temp table.
insert into #Employee
select id, gender, educ, jobcat, salary, salbegin, jobtime, prevexp, minority
from Employee_data

--- updating the values in the gender column to male and female.
update #Employee
set gender = 'female'
where gender = 'f'

update #Employee
set gender = 'male'
where gender = 'm'

select *
from #Employee

-- counting the number of male and female employees
select gender, count(gender) as Num_per_gender
from #Employee
group by gender
order by count(gender) desc

-- Finding out the percentage increase in salary for all employees
select id, salary, salbegin, round(cast(salary as float)/cast(salbegin as float),2) as percent_sal_increase
from #Employee
group by id, salary, salbegin
order by percent_sal_increase desc

-- Trimming the gender column.
select trim(gender)
from #Employee

--- trying to find a realtion between the previous experience and the percentage increase in salary, we want to see if experience has played a role.
select id, salary, salbegin, prevexp, round(cast(salary as float)/cast(salbegin as float),2) as percent_sal_increase
from #Employee
group by id, salary, salbegin,prevexp
order by prevexp desc


--- deleting duplicates
with cte_employee as (
select *, row_number() over(partition by id order by id) as rowdup
from #Employee
)
delete from cte_employee
where rowdup > 1
