CREATE SCHEMA IF NOT EXISTS sandbox;

CREATE TABLE IF NOT EXISTS sandbox.order_demo AS
SELECT g as n from GENERATE_SERIES(1, 100) as g;

SELECT n from sandbox.order_demo;

update sandbox.order_demo set n = n * 10 where n < 50;
select n from sandbox.order_demo;