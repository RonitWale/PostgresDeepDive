-- WINDOW FUNCTIONS: applies aggreagte , ranking, and analytical functions over a particular window; for ex: sum, avg or ro_number
-- EXPRESSION: is the name of the column that we want the window function operated on. This may not be necessary depending on what function is being used.
-- PARTITION BY: divides the result set into partitions to which the window function is applied.
-- ORDER BY: defines the logical order of the rows within each partition of the result set.
-- ROWS BETWEEN: defines the window frame for the window function. It specifies the number of rows before 
-- and after the current row to include in the window frame. 
-- The default is "RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW", which means that the window frame includes all rows from the beginning of the partition up to the current row.
-- OVER: is just to signify that the function is a window function and not an aggregate function.

-- WINDOW FUNCTIONS : AGGREGATE FUNCTIONS => SUM, AVG, COUNT, MIN, MAX
--                    RANKING FUNCTIONS => ROW_NUMBER, RANK, DENSE_RANK, PERFECT_RANK
--                    ANALYTICAL FUNCTIONS => LEAD, LAG, FIRST_VALUE, LAST_VALUE


-- Practice Task 
-- SELECT CITY, DATE, TEMP_HI,
-- ROW_NUMBER() OVER (PARTITION BY CITY ORDER BY TEMP_HI DESC) AS ROW_NUMBER
-- FROM WEATHER

-- SELECT CITY, DATE, TEMP_HI,
-- RANK() OVER (PARTITION BY CITY ORDER BY TEMP_HI DESC) AS RANK
-- FROM WEATHER

-- SELECT CITY, DATE, TEMP_HI,
-- DENSE_RANK() OVER (PARTITION BY CITY ORDER BY TEMP_HI DESC) AS DENSE_RANK
-- FROM WEATHER

-- SELECT CITY, DATE, TEMP_HI
-- FROM (
--   SELECT CITY, DATE, TEMP_HI,
--          ROW_NUMBER() OVER (PARTITION BY CITY ORDER BY TEMP_HI DESC) AS rn
--   FROM WEATHER
-- ) ranked
-- WHERE rn = 1

-- SELECT CITY, DATE, TEMP_HI
-- FROM (
--   SELECT CITY, DATE, TEMP_HI,
--          RANK() OVER (PARTITION BY CITY ORDER BY TEMP_HI DESC) AS rank
--   FROM WEATHER
-- ) ranked
-- WHERE rank = 2

-- SELECT CITY, DATE, TEMP_HI,
-- AVG(TEMP_HI) OVER (PARTITION BY CITY ORDER BY DATE ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS CITY_AVG_TEMP
-- FROM WEATHER WHERE CITY = 'Kolkata' AND DATE BETWEEN '2026-08-01' AND '2026-08-04'

-- SELECT CITY, DATE, TEMP_HI,
--        TEMP_HI - AVG(TEMP_HI) OVER (PARTITION BY CITY) AS DIFFERENCE
-- FROM WEATHER
