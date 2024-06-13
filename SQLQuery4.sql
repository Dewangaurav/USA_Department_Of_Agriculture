--4. Identify the state with the highest compound annual growth rate (CAGR) in milk production from 2015 to 2023.


with cte as 
(
select sl.state, sum(case when year = 2015 then value else 0 end) as starting_value, sum(case when year = 2023 then value  else 0 end) as end_value
from milk_production mp
join state_lookup sl on mp.state_ansi=sl.state_ansi
where year = 2015
group by sl.state
)
select top 1 state, Power(end_value/starting_value,1/8)-1 as Cagr
from cte 
order by Cagr desc


