Select * from IDSData

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'IDSData'
  AND COLUMN_NAME LIKE 'year_%'
ORDER BY COLUMN_NAME;

SELECT
    Country_Code,
    Indicator_Code,
    Year,
    Debt_Value
FROM IDSData
UNPIVOT
(
    Debt_Value FOR Year IN (
       year_1970,
year_1971,
year_1972,
year_1973,
year_1974,
year_1975,
year_1976,
year_1977,
year_1978,
year_1979,
year_1980,
year_1981,
year_1982,
year_1983,
year_1984,
year_1985,
year_1986,
year_1987,
year_1988,
year_1989,
year_1990,
year_1991,
year_1992,
year_1993,
year_1994,
year_1995,
year_1996,
year_1997,
year_1998,
year_1999,
year_2000,
year_2001,
year_2002,
year_2003,
year_2004,
year_2005,
year_2006,
year_2007,
year_2008,
year_2009,
year_2010,
year_2011,
year_2012,
year_2013,
year_2014,
year_2015,
year_2016,
year_2017,
year_2018,
year_2019,
year_2020,
year_2021,
year_2022,
year_2023,
year_2024
    )
) u;


SELECT
    Country_Code,
    Indicator_Code,
    CAST(REPLACE(Year, 'year_', '') AS INT) AS Year,
    Debt_Value
FROM (
    SELECT *
    FROM IDSData
    UNPIVOT (
        Debt_Value FOR Year IN (
            year_1970,
year_1971,
year_1972,
year_1973,
year_1974,
year_1975,
year_1976,
year_1977,
year_1978,
year_1979,
year_1980,
year_1981,
year_1982,
year_1983,
year_1984,
year_1985,
year_1986,
year_1987,
year_1988,
year_1989,
year_1990,
year_1991,
year_1992,
year_1993,
year_1994,
year_1995,
year_1996,
year_1997,
year_1998,
year_1999,
year_2000,
year_2001,
year_2002,
year_2003,
year_2004,
year_2005,
year_2006,
year_2007,
year_2008,
year_2009,
year_2010,
year_2011,
year_2012,
year_2013,
year_2014,
year_2015,
year_2016,
year_2017,
year_2018,
year_2019,
year_2020,
year_2021,
year_2022,
year_2023,
year_2024
        )
    ) u
) t;

CREATE TABLE Fact_External_Debt (
    Country_Code VARCHAR(10),
    Indicator_Code VARCHAR(50),
    Year INT,
    Debt_Value DECIMAL(18,2)
);

INSERT INTO Fact_External_Debt
SELECT
    Country_Code,
    Indicator_Code,
    CAST(REPLACE(Year, 'year_', '') AS INT) AS Year,
    Debt_Value
FROM (
    SELECT *
    FROM IDSData
    UNPIVOT (
        Debt_Value FOR Year IN (
                        year_1970,
year_1971,
year_1972,
year_1973,
year_1974,
year_1975,
year_1976,
year_1977,
year_1978,
year_1979,
year_1980,
year_1981,
year_1982,
year_1983,
year_1984,
year_1985,
year_1986,
year_1987,
year_1988,
year_1989,
year_1990,
year_1991,
year_1992,
year_1993,
year_1994,
year_1995,
year_1996,
year_1997,
year_1998,
year_1999,
year_2000,
year_2001,
year_2002,
year_2003,
year_2004,
year_2005,
year_2006,
year_2007,
year_2008,
year_2009,
year_2010,
year_2011,
year_2012,
year_2013,
year_2014,
year_2015,
year_2016,
year_2017,
year_2018,
year_2019,
year_2020,
year_2021,
year_2022,
year_2023,
year_2024

        )
    ) u
) t;


SELECT  *
FROM Fact_External_Debt

-- Row count check
SELECT COUNT(*) FROM Fact_External_Debt;

-- Null check
SELECT *
FROM Fact_External_Debt
WHERE Debt_Value IS NULL;

-- Year range check
SELECT MIN(Year), MAX(Year)
FROM Fact_External_Debt;


