

--7. Which state had the highest percentage increase in honey production from 2021 to 2022?

with cte as
(
select state, value,year, row_number() over(partition by state order by year) as rn
from honey_production hp
join state_lookup sl on hp.state_ansi=sl.state_ansi
where year in ('2021','2022')
)
select state, value, (value- LAG(value, 1) OVER (PARTITION BY state ORDER BY year)) /100 as percent_production_increase
from cte 
group by state, value, year
order by percent_production_increase desc

