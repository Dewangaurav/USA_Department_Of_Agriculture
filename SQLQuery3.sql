
--3. Find the top 3 states in terms of total production for all commodities combined in 2023.

with cte as 
(
select  sl.state, value
from state_lookup sl
join cheese_production cp on sl.state_ansi=cp.state_ansi
where year=2023
union all
select sl.state, value
from state_lookup sl
join egg_production ep on sl.state_ansi=ep.state_ansi
where year=2023
union all
select sl.state, value
from state_lookup sl
join honey_production hp on sl.state_ansi=hp.state_ansi
where year=2023
union all
select sl.state, value
from state_lookup sl
join milk_production mp on sl.state_ansi=mp.state_ansi
where year=2023
union all
select sl.state, value
from state_lookup sl
join milk_production ccp on sl.state_ansi=ccp.state_ansi
where year=2023
union all
select sl.state, value
from state_lookup sl
join yogurt_production yp on sl.state_ansi=yp.state_ansi
where year=2023
)
select top 3 state, sum(value) as total_production
from cte 
group by state















