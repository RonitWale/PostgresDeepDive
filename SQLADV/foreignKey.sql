-- FOREIGN KEY: A column or a set of columns in a table that provides a link between data in two tables. It references the primary key of another table.
-- more info: https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-FK

-- CREATE A TABLE IN POSTGRESQL DATABASE
CREATE TABLE IF NOT EXISTS cities (
    name VARCHAR(50) NOT NULL primary key,
    location POINT NOT NULL
);
CREATE TABLE IF NOT EXISTS WEATHER (
    city VARCHAR(50) NOT NULL references cities(name) ON DELETE CASCADE,
    temp_lo integer NOT NULL,
    temp_hi integer NOT NULL,
    prcp real,
    date DATE NOT NULL
);
