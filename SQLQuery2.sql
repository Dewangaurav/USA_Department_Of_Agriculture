
--2. Calculate the percentage increase or percentage decrease in milk production in California from 2022 to 2023.
with cte as
(
select sl.state, year, sum(value) as total_milk_production, row_number() over(partition by year order by year desc) as rn
from milk_production mp
join state_lookup sl on mp.state_ansi=sl.state_ansi
where year in('2022','2023') and state= 'California'
group by sl.state, year
)
, cte2 as
(
select * , total_milk_production - LAG(total_milk_production, 1) OVER (ORDER BY year) as production_difference
from cte
)
select *, concat(production_difference/LAG(total_milk_production, 1) OVER (ORDER BY year) * 100,'%') as percent_decrease
from cte2






