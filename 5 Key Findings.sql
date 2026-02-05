--Global external debt is highly concentrated among a few countries

WITH latest_year AS (
    SELECT 
    MAX(Year) AS yr
    FROM Fact_External_Debt
)
SELECT
    c.Short_Name AS Country,
    SUM(f.Debt_Value) AS Total_Debt
FROM Fact_External_Debt f
JOIN IDSCountry c
    ON f.Country_Code = c.Country_Code
JOIN latest_year ly
    ON f.Year = ly.yr
WHERE c.Region IS NOT NULL
  AND c.Income_Group IS NOT NULL
GROUP BY c.Short_Name
ORDER BY Total_Debt DESC;

--Top 10 countries’ share of global debt

WITH latest_year AS (
    SELECT MAX(Year) AS yr
    FROM Fact_External_Debt
),
country_debt AS (
    SELECT
        c.Short_Name AS Country,
        SUM(f.Debt_Value) AS Total_Debt
    FROM Fact_External_Debt f
    JOIN IDSCountry c
        ON f.Country_Code = c.Country_Code
    JOIN latest_year ly
        ON f.Year = ly.yr
    WHERE c.Region IS NOT NULL
      AND c.Income_Group IS NOT NULL
    GROUP BY c.Short_Name
),
global_total AS (
    SELECT SUM(Total_Debt) AS Global_Debt
    FROM country_debt
)
SELECT TOP 10
    Country,
    Total_Debt,
    ROUND(Total_Debt * 100.0 / (SELECT Global_Debt FROM global_total), 2) AS Share_Percentage
FROM country_debt
ORDER BY Total_Debt DESC;

--Countries with Most Debt Volatility
select * from Fact_External_Debt;

WITH DebtVolatility AS (
    SELECT
        f.Country_Code,
        f.Year,
        f.debt_value,
        LAG(f.debt_value) OVER (PARTITION BY f.Country_Code ORDER BY f.Year) AS prev_debt
    FROM Fact_External_Debt f
)
SELECT
    c.Short_Name AS country,
    AVG(ABS(d.debt_value - d.prev_debt)) AS avg_volatility
FROM DebtVolatility d
JOIN IDSCountry c
    ON d.Country_Code = c.Country_Code
WHERE d.prev_debt IS NOT NULL  -- ignore the first year where LAG is NULL
GROUP BY c.Short_Name
ORDER BY avg_volatility DESC;

--Countries Dominating Specific Debt Types

SELECT *
FROM (
    SELECT
        s.[Series_Code],
        c.[Short_Name] AS country,
        SUM(f.debt_value) AS total_debt,
        RANK() OVER (
            PARTITION BY s.[Series_Code]
            ORDER BY SUM(f.debt_value) DESC
        ) AS rnk
    FROM Fact_External_Debt f
    JOIN IDSCountry c
        ON f.country_code = c.[Country_Code]
    JOIN IDSSeries s
        ON f.[Country_Code] = s.[Series_Code]
    GROUP BY s.[Series_Code], c.[Short_Name]
) t
WHERE rnk = 1;
