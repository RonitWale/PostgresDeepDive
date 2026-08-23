-- TRANSACTION: A sequence of one or more SQL statements that are executed as a single unit of work.
-- DESCRIPTION: A transaction is a logical unit of work that contains one or more SQL statements. 
-- A transaction is started with the BEGIN statement and ends with either a COMMIT or ROLLBACK statement. 
-- If a transaction is committed, all changes made during the transaction are saved to the database. 
-- If a transaction is rolled back, all changes made during the transaction are discarded.
-- more info: https://www.postgresql.org/docs/current/tutorial-transactions.html

-- a transaction is started with the BEGIN statement and ends with either a COMMIT or ROLLBACK statement.
-- A group of statements surrounded by BEGIN and COMMIT is sometimes called a transaction block.

-- SAVEPOINTS: A transaction can be divided into smaller parts using savepoints. 
-- A savepoint is a point within a transaction that you can roll back to without rolling back the entire transaction.

-- BASED ON THE DATA INSIDE THIS FOLDER GIVE ME TASK TOPRACTICE TRANSACTION AND SAVEPOINTS IN POSTGRESQL.

-- part 1: 
-- BEGIN;
-- -- Insert a new city into the cities table
-- INSERT INTO cities (name, location) VALUES ('Ranchi', POINT(85.3096, 23.3441));

-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES 
-- ('Ranchi', 20, 30, 5.0, '2026-08-01');

-- SELECT * FROM CITIES WHERE name = 'Ranchi';
-- SELECT * FROM WEATHER WHERE city = 'Ranchi';

-- ROLLBACK; -- Rollback the transaction to undo the changes made above

-- part 2: 
-- BEGIN ; 
-- -- -- Insert a new city into the cities table
-- INSERT INTO cities (name, location) VALUES ('Ranchi', POINT(85.3096, 23.3441));

-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES 
-- ('Ranchi', 20, 30, 5.0, '2026-08-01');

-- COMMIT;

--part 3: 
-- BEGIN;

-- UPDATE WEATHER
-- SET temp_hi = 40 where city = 'Kolkata' and date = '2026-08-01';

-- ROLLBACK; -- Rollback the transaction to undo the changes made above

-- SELECT * FROM WEATHER WHERE city = 'Kolkata' and date = '2026-08-01';

-- part 4: 
-- BEGIN;

-- INSERT INTO CITIES (name, location) VALUES ('Ranchi', POINT(85.3096, 23.3441));
-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES 
-- ('Ranchi', 20, 30, 5.0, '2026-08-01');

-- UPDATE WEATHER 
-- SET temp_hi = 40 where city = 'Kolkata' and date = '2026-08-01';

-- DELETE FROM WEATHER WHERE city = 'Delhi' and date = '2026-08-01';
-- ROLLBACK; -- Rollback the transaction to undo the changes made above

-- SELECT * FROM CITIES WHERE name = 'Ranchi';
-- SELECT * FROM WEATHER WHERE city = 'Ranchi';
-- SELECT * FROM WEATHER WHERE city = 'Kolkata' and date = '2026-08-01';
-- SELECT * FROM WEATHER WHERE city = 'Delhi' and date = '2026-08-01';

-- part 5:
-- BEGIN;

-- UPDATE weather
-- SET temp_hi = temp_hi + 2
-- WHERE city = 'Kolkata';

-- UPDATE weather
-- SET temp_hi = temp_hi + 1
-- WHERE city = 'Mumbai';

-- DELETE FROM weather
-- WHERE prcp = 0.0;

-- SELECT *
-- FROM weather
-- WHERE city IN ('Kolkata', 'Mumbai');

-- SELECT *
-- FROM weather
-- WHERE prcp = 0.0;

-- ROLLBACK;

-- SELECT *
-- FROM weather
-- WHERE city IN ('Kolkata', 'Mumbai');

-- SELECT *
-- FROM weather
-- WHERE prcp = 0.0;

-- part 6: 
-- BEGIN;
-- INSERT INTO cities (name, location) VALUES ('Jalandhar', POINT(75.5762, 31.3260));
-- SAVEPOINT city_created;
-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES 
-- ('Jalandhar', 22, 32, 3.0, '2026-08-01');
-- ROLLBACK TO SAVEPOINT city_created; -- Rollback to the savepoint, undoing the insert into WEATHER but keeping the insert into cities
-- COMMIT; -- Commit the transaction, saving the insert into cities

-- part 7: 
-- BEGIN ;
-- INSERT INTO cities (name, location) VALUES ('Ajmer', POINT(75.5762, 31.3260));
-- SAVEPOINT SP1;
-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES 
-- ('Ajmer', 22, 32, 3.0, '2026-08-01');
-- SAVEPOINT SP2;
-- UPDATE WEATHER
-- SET temp_hi = 35
-- WHERE city = 'Mumbai' and date = '2026-08-01';
-- SAVEPOINT SP3;
-- DELETE FROM WEATHER
-- WHERE city = 'Delhi' and date = '2026-08-01';
-- ROLLBACK TO SAVEPOINT SP3;  
-- COMMIT; -- Rollback to the savepoint, undoing the

-- BEGIN;
-- INSERT INTO cities (name, location) VALUES ('Rampurhat', POINT(88.5762, 31.3260));
-- INSERT INTO WEATHER (city, temp_lo, temp_hi, prcp, date) VALUES 
-- ('Rampurhat', 22, 32, 3.0, '2026-08-01');

-- UPDATE WEATHER 
-- SET temp_hi = 35
-- WHERE city = 'Kolkata' and date = '2026-08-01';

-- UPDATE WEATHER
-- SET temp_hi = 30
-- WHERE city = 'Mumbai' and date = '2026-08-01';

-- SAVEPOINT SP1;

-- UPDATE WEATHER
-- SET temp_hi = 28
-- WHERE city = 'Delhi' and date = '2026-08-01';

-- ROLLBACK TO SAVEPOINT SP1; -- Rollback to the savepoint, undoing the update to Delhi but keeping the updates to Kolkata and Mumbai

-- COMMIT;