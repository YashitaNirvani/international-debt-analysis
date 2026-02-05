select * from IDSCountry

select * from Fact_External_Debt

select 
f.Country_Code,
c.Short_Name,
c.Region,
c.Income_Group,
f.Year,
f.Debt_Value
from Fact_External_Debt f
inner join IDSCountry c
on f.Country_Code = c.Country_Code

--Top 10 countries by debt (latest year)

WITH latest_year AS (
    SELECT MAX(Year) AS yr FROM Fact_External_Debt
)
SELECT TOP 10
    c.Short_Name,
    f.Debt_Value
FROM Fact_External_Debt f
JOIN IDSCountry c ON f.Country_Code = c.Country_Code
JOIN latest_year ly ON f.Year = ly.yr
ORDER BY f.Debt_Value DESC;

--Year-over-Year debt growth (per country)

SELECT
    c.Short_Name,
    f.Year,
    f.Debt_Value,
    f.Debt_Value
      - LAG(f.Debt_Value) OVER (
            PARTITION BY f.Country_Code
            ORDER BY f.Year
        ) AS YoY_Change
FROM Fact_External_Debt f
JOIN IDSCountry c ON f.Country_Code = c.Country_Code;

--Countries with 3 consecutive years of debt increase

WITH growth AS (
    SELECT
        Country_Code,
        Year,
        Debt_Value,
        CASE
            WHEN Debt_Value >
                 LAG(Debt_Value) OVER (PARTITION BY Country_Code ORDER BY Year)
            THEN 1 ELSE 0
        END AS increased
    FROM Fact_External_Debt
)
SELECT Country_Code
FROM growth
GROUP BY Country_Code
HAVING SUM(increased) >= 3;

--Region & Income Group analysis

--Total debt by region

SELECT
    c.Region,
    SUM(f.Debt_Value) AS Total_Debt
FROM Fact_External_Debt f
JOIN IDSCountry c ON f.Country_Code = c.Country_Code
GROUP BY c.Region
ORDER BY Total_Debt DESC;

--Debt by income group over time

SELECT
    c.Income_Group,
    f.Year,
    SUM(f.Debt_Value) AS Total_Debt
FROM Fact_External_Debt f
JOIN IDSCountry c ON f.Country_Code = c.Country_Code
GROUP BY c.Income_Group, f.Year
ORDER BY f.Year;

--Countries growing faster than regional average

WITH yoy AS (
    SELECT
        f.Country_Code,
        c.Region,
        f.Year,
        f.Debt_Value -
        LAG(f.Debt_Value) OVER (
            PARTITION BY f.Country_Code
            ORDER BY f.Year
        ) AS YoY_Growth
    FROM Fact_External_Debt f
    JOIN IDSCountry c ON f.Country_Code = c.Country_Code
)
SELECT *
FROM yoy
WHERE YoY_Growth >
    (
        SELECT AVG(YoY_Growth)
        FROM yoy y2
        WHERE y2.Region = yoy.Region
          AND y2.Year = yoy.Year
    );

   



