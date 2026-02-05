use international_debt_db;

select * from IDSCountry

--Handle NULLs

-- Remove rows without a Country Code
DELETE FROM IDSCountry
WHERE [Country_Code] IS NULL;

-- Replace missing currency unit with 'Unknown'
UPDATE IDSCountry
SET [Currency_Unit] = 'Unknown'
WHERE [Currency_Unit] IS NULL;

UPDATE IDSCountry
SET Region = 'Unknown'
WHERE Region IS NULL;

UPDATE IDSCountry
SET [Special_Notes] = 'Unknown'
WHERE [Special_Notes] IS NULL;

--Trim extra spaces

UPDATE IDSCountry
SET [Short_Name] = TRIM([Short_Name] ),
    [Long_Name]  = TRIM([Long_Name]),
    [Table_Name]  = TRIM([Table_Name] );

    --Standardize codes and names

    UPDATE IDSCountry
SET [Country_Code] = UPPER([Country_Code]),
   [_2_alpha_code] = UPPER([_2_alpha_code]);

   --Normalize special notes

   UPDATE IDSCountry
SET [Special_Notes] = LEFT([Special_Notes] , 255);  -- if you want to limit to 255 chars

