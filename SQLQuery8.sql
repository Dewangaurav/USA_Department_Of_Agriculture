select * from cheese_production
select * from egg_production
select * from milk_production
select * from coffee_production
select * from honey_production
select * from state_lookup
select * from yogurt_production



--8. Find the states where yogurt production was reported in most of years available in the dataset and calculate the average production per year for these states.

select  state,
count(*) as number_of_years,
avg(value) as avg_production
from yogurt_production yp
join state_lookup sl on yp.state_ansi=sl.state_ansi
group by state
HAVING COUNT(DISTINCT year) = (SELECT COUNT(DISTINCT year) FROM yogurt_production)
order by number_of_years desc


