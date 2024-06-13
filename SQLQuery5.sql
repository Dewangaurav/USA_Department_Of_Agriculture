
--5.  Identify the state and year with the highest percentage share of national coffee production.

WITH Coffee_Prod AS 
(
SELECT s.State, cp.Year, value AS Coffee_Production
FROM coffee_production cp
JOIN state_lookup s ON cp.State_ANSI = s.State_ANSI
),
Total_National_Prod AS
(
SELECT Year, SUM(Coffee_Production) AS National_Production
FROM Coffee_Prod
GROUP BY Year
)
SELECT 
top 1 c.State, 
c.Year, 
(c.Coffee_Production / t.National_Production) * 100 AS Percentage_Share
FROM Coffee_Prod c
JOIN Total_National_Prod t ON c.Year = t.Year
ORDER BY Percentage_Share DESC
