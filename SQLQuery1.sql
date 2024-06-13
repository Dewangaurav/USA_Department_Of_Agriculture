
--1. Which state had the highest total cheese production every year and if the state is same then calculate the percentage increase in cheese production in %.(only display positive differences in cheese production)

with cte as
(
select sl.state,year,value as total_cheese_production, row_number() over(partition by year order by value desc) as rn
from cheese_production cp
join state_lookup sl on cp.state_ansi=sl.state_ansi
group by sl.state,value, year
)
, cte2 as
(
select *,case when total_cheese_production - LAG(total_cheese_production, 1) OVER (ORDER BY year) >=0 then total_cheese_production - LAG(total_cheese_production, 1) OVER (ORDER BY year)  else 0 end as production_difference 
from cte
where rn =1
)
select *, concat(round(production_difference/total_cheese_production * 100,2),'%')  as production_growth_rate
from cte2