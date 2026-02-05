Select * from IDSSeries

SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN unit_of_measure IS NOT NULL THEN 1 ELSE 0 END) AS unit_count,
  SUM(CASE WHEN Base_Period IS NOT NULL THEN 1 ELSE 0 END) AS base_period_count,
  SUM(CASE WHEN Other_notes IS NOT NULL THEN 1 ELSE 0 END) AS other_note_count,
  SUM(CASE WHEN Limitations_and_exceptions IS NOT NULL THEN 1 ELSE 0 END) AS limitations_count
FROM IDSSeries;
