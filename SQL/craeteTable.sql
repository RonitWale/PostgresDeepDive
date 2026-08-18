-- CREATE A TABLE IN POSTGRESQL DATABASE
CREATE TABLE IF NOT EXISTS WEATHER (
    city VARCHAR(50) NOT NULL,
    temp_lo integer NOT NULL,
    temp_hi integer NOT NULL,
    prcp real,
    date DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS cities (
    name VARCHAR(50) NOT NULL,
    location POINT NOT NULL
);

-- Get inside command terminal and run psql -h localhost -p 5432 -U ronitroy -d learningdb -f SQL/craeteTable.sql 
-- This ill create the table in the database learningdb. You can check the table by running \dt command in psql terminal.


-- INSERT DATA INTO POSTGRES SQL DATABASE TABLE
-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES ('San Francisco', 46, 50, 0.25, '1999-11-29');
-- INSERT INTO CITIES (name, location) VALUES ('San Francisco', '(-122.4194, 37.7749)');


INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date)
VALUES
    ('San Francisco', 43, 57, 0.10, '1999-11-30'),
    ('San Francisco', 45, 59, 0.00, '1999-12-01'),
    ('New York', 35, 48, 0.50, '1999-11-29'),
    ('New York', 32, 45, 0.20, '1999-11-30'),
    ('Chicago', 28, 41, 0.75, '1999-11-29'),
    ('Chicago', 30, 44, 0.10, '1999-11-30'),
    ('Boston', 31, 46, 0.35, '1999-11-29'),
    ('Seattle', 42, 51, 0.80, '1999-11-29');


    INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date)
VALUES
    ('San Francisco', 43, 57, 0.10, '1999-11-30'),
    ('San Francisco', 45, 59, 0.00, '1999-12-01'),
    ('New York', 35, 48, 0.50, '1999-11-29'),
    ('New York', 32, 45, 0.20, '1999-11-30'),
    ('Chicago', 28, 41, 0.75, '1999-11-29'),
    ('Chicago', 30, 44, 0.10, '1999-11-30'),
    ('Boston', 31, 46, 0.35, '1999-11-29'),
    ('Seattle', 42, 51, 0.80, '1999-11-29');