-- SQL VIEW : A virtual table that contains the result of a stored query
-- CREATE VIEW weather_view AS
-- SELECT CITY, MAX(TEMP_HI) AS MAX_TEMP, MIN(TEMP_LO) AS MIN_TEMP
-- FROM WEATHER
-- GROUP BY CITY;

-- HOW TO USE:
SELECT * FROM weather_view;

-- IS VIEW STAYS INSIDE DB : YES
-- DOES VIEW TAKE MEMORY ?  YES