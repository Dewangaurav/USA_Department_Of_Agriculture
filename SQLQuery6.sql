
--6. Rank the states by their average annual growth rate in honey production from 2010 to 2022.

with cte as 
(
select state, value, year, row_number() over(partition by state order by state, year) as rn
from honey_production hp
join state_lookup sl on hp.state_ansi=sl.state_ansi
where year between 2010 and 2022
group by state, value, year
)
, cte2 as
(
select state, value, year,LAG(value, 1) OVER (PARTITION BY state ORDER BY year) AS previous_year_value
from cte
)
, cte3 as
(
select state, value, year,previous_year_value , ((value-previous_year_value)/previous_year_value)*100 as annual_growth_rate
from cte2
where previous_year_value is not null
)
, cte4 as 
(
select state, avg(annual_growth_rate) as average_annual_growthrate
from cte3
group by state
)
select *, rank() over(order by average_annual_growthrate desc) as rn2
from cte4
order by average_annual_growthrate desc
