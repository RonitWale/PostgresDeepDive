SELECT * FROM WEATHER;
SELECT * FROM cities;

SELECT city, temp_lo, temp_hi, prcp, date FROM WEATHER ;

-- column references
SELECT city, (temp_lo + temp_hi) / 2 AS average_temp FROM WEATHER;

-- where clause
SELECT * FROM WEATHER WHERE city = 'San Francisco' AND prcp < 0.0;
SELECT * FROM WEATHER WHERE city = 'San Francisco' AND prcp > 0.0;

-- sorted order (ascending or descending)
SELECT * FROM WEATHER ORDER BY city ASC;
SELECT * FROM WEATHER ORDER BY city DESC;

-- duplicate removal from query
SELECT DISTINCT city FROM WEATHER ORDER BY city ASC;