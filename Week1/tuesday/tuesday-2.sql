CREATE TABLE IF NOT EXISTS sandbox.check_demo(qty integer CHECK(qty>0));

INSERT INTO sandbox.check_demo(qty) VALUES (10);
INSERT INTO sandbox.check_demo(qty) VALUES (-10);
INSERT INTO sandbox.check_demo(qty) VALUES (NULL);

/*
CREATE TABLE
INSERT 0 1
psql:Week1/tuesday-2.sql:4: ERROR:  new row for relation "check_demo" violates check constraint "check_demo_qty_check"
DETAIL:  Failing row contains (-10).
INSERT 0 1
*/