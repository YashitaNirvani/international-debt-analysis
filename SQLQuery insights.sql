SELECT TOP 5 * FROM Fact_External_Debt;
SELECT TOP 5 * FROM IDSCountry;
SELECT TOP 5 * FROM IDSSeries;
SELECT TOP 5 * FROM [IDSSeries-Time];
Select * from [IDSCountry-Series]
Select * from IDSFootNote


SELECT
    c.Country_Code,
    c.Short_Name       AS Country,
    c.Region,
    c.Income_Group,

    s.Series_Code      AS Indicator_Code,
    s.Indicator_Name,
    s.Topic,

    f.Year,
    f.Debt_Value
FROM Fact_External_Debt f
JOIN IDSCountry c
    ON f.Country_Code = c.Country_Code
JOIN IDSSeries s
    ON f.Indicator_Code = s.Series_Code;

    --Use IDSCountry-Series

SELECT
    c.Short_Name AS Country,
    s.Indicator_Name,
    f.Year,
    f.Debt_Value
FROM Fact_External_Debt f
JOIN [IDSCountry-Series] cs
    ON f.Country_Code = cs.CountryCode
   AND f.Indicator_Code = cs.SeriesCode
JOIN IDSCountry c
    ON c.Country_Code = f.Country_Code
JOIN IDSSeries s    
    ON s.Series_Code = f.Indicator_Code;

--Use IDSFootNote

SELECT
    c.Short_Name AS Country,
    s.Indicator_Name,
    f.Year,
    f.Debt_Value,
    fn.DESCRIPTION
FROM Fact_External_Debt f
LEFT JOIN IDSFootNote fn
    ON f.Country_Code = fn.CountryCode
   AND f.Indicator_Code = fn.SeriesCode
JOIN IDSCountry c
    ON c.Country_Code = f.Country_Code
JOIN IDSSeries s
    ON s.Series_Code = f.Indicator_Code;



 CREATE VIEW vw_IDS_Debt_Analytics AS
    (
    SELECT
        c.Country_Code,
        c.Short_Name     AS Country,
        c.Region,
        c.Income_Group,
        s.Series_Code    AS Indicator_Code,
        s.Indicator_Name    AS Indicator_Name,
        s.Topic,
        f.Year,
        f.Debt_Value
    FROM Fact_External_Debt f
    JOIN IDSCountry c
        ON f.Country_Code = c.Country_Code
    JOIN IDSSeries s
        ON f.Indicator_Code = s.Series_Code
    )


SELECT * FROM vw_IDS_Debt_Analytics;
