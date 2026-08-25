# Week 1 — Foundations: Install, Structure, and the Relational Mental Model
### Aug 24–30, 2026 · 12 hours · Module 1 of 6

Goal for the week: get a working Postgres environment, understand what a database/schema/table actually is in Postgres (vs. a Mongo database/collection), and get fluent in the DDL that defines structure. By Sunday you should be able to look at any table and read its full definition from `psql` without needing a GUI.

---

## Session 1 (3h) — Environment & first look

**Setup (45 min)**
1. Install PostgreSQL (latest stable — check postgresql.org/docs for the current version) locally, or via Docker if you prefer a disposable environment: `docker run --name pg-tutor -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres`.
2. Install a GUI client — DBeaver (free, cross-platform) or TablePlus. You'll use `psql` for most work, but a GUI is useful for quickly eyeballing schemas.
3. Connect via `psql -U postgres -h localhost` and confirm you're in.

**Concepts (45 min)**
- Postgres's structural hierarchy: **cluster → database → schema → table**. This has no clean Mongo equivalent — Mongo's "database → collection" is two levels; Postgres has three, and `schema` (default: `public`) is the one that trips people up. A schema is a namespace *inside* a database, not a database itself.
- A database in Postgres is a much harder boundary than a Mongo database — cross-database queries aren't a normal thing the way cross-collection ones are.

**Hands-on (90 min)**
- Create a database: `CREATE DATABASE pgql_practice;`
- Connect to it: `\c pgql_practice`
- Download and load the **Pagila** sample database (a DVD-rental schema — search "pagila github postgres" for the current repo, it's a standard reference dataset with `.sql` files for schema + data).
- Explore with `psql` meta-commands: `\dt` (list tables), `\d film` (describe a table), `\dn` (list schemas). Do this instead of only looking in the GUI — the muscle memory matters.

---

## Session 2 (3h) — Data types deep dive

**Concepts (60 min)**
Postgres has a genuinely large, strict type system compared to what you're used to relying on BSON's looser typing for. Cover: `integer`/`bigint`/`smallint`, `numeric(p,s)` vs `real`/`double precision` (know when you need exact decimal — money — vs floating point), `text`/`varchar(n)`/`char(n)` (and why `text` is usually the right default), `boolean`, `date`/`timestamp`/`timestamptz` (timezone handling is a common real-world bug source — default to `timestamptz`), `uuid`, and a first look at `jsonb` (full deep dive is Week 6).

**Hands-on (2h)**
- In `pgql_practice`, create a new schema for your own experiments: `CREATE SCHEMA sandbox;`
- Design and create a table for a "users" concept from scratch, choosing a type for every column deliberately (not by habit) — id, email, created_at, is_active, account_balance, metadata.
- Try inserting bad data on purpose (a string into an integer column, a duplicate into a would-be unique column) and read the actual error messages. Getting comfortable reading Postgres error output is a real skill.

---

## Session 3 (3h) — DDL: CREATE, ALTER, DROP, and keys

**Concepts (45 min)**
- `CREATE TABLE` full syntax: column definitions, `PRIMARY KEY`, `NOT NULL`, `DEFAULT`, `REFERENCES` (foreign keys, previewed — full constraint deep dive is Week 7).
- `ALTER TABLE` for adding/dropping/renaming columns, changing types, adding constraints after the fact — this is what real schema evolution looks like (you won't design a perfect schema on day one, and Postgres expects that).
- Primary keys: `serial`/`bigserial` (legacy auto-increment) vs `GENERATED ALWAYS AS IDENTITY` (current best practice) vs `uuid` — trade-offs (sequential ints are index-friendly and compact; UUIDs avoid coordination in distributed inserts but fragment indexes).

**Hands-on (2h 15min)**
- Build a small 3-table schema by hand: `authors`, `books`, `books_authors` (a genuine many-to-many, something Mongo would usually model as an embedded array — notice the difference).
- Use `ALTER TABLE` to evolve it: add a column, add a `NOT NULL` constraint to an existing column with data already in it (you'll hit the real-world problem of what happens when existing rows violate a new constraint — work through it), add a foreign key.
- Drop and recreate one table using `DROP TABLE ... CASCADE` and observe what cascades.

---

## Session 4 (3h) — Milestone: map Pagila, start your bridge notes

**Hands-on (2h)**
- Using only `\d` commands in `psql` (no GUI), reconstruct the Pagila schema's ER diagram by hand — on paper or in any diagramming tool. Identify every foreign key relationship and every many-to-many join table.
- Write 10 plain-English questions you could ask of this data ("which actor has appeared in the most films", "total rentals per store per month"). Don't answer them yet — Week 2–3 will give you the tools. Save this list; you'll use it as practice material.

**Reflection & bridge notes (1h)**
Write your own version of the Mongo→Postgres cheat sheet for what you learned this week specifically:
- How does Pagila's `film`/`film_actor`/`actor` structure compare to how you'd have modeled the same data in Mongo (embedded array of actor names on the film document, vs. a real join table)?
- Where did the strict typing catch something a loose Mongo schema would have let through silently?

**Self-check — you should be able to, without looking anything up:**
1. Explain the difference between a Postgres database and a schema.
2. Write a `CREATE TABLE` with a primary key, a foreign key, a `NOT NULL` column, and a `DEFAULT`.
3. Explain why you'd choose `numeric` over `double precision` for a price column.
4. Read a `\d tablename` output and state every constraint on that table.

If any of these feel shaky, that's the sign to revisit before starting Week 2 — everything after this builds on it.

---

**Next:** Week 2 (Aug 31–Sep 6) — DML: SELECT/WHERE/ORDER BY, INSERT/UPDATE/DELETE/UPSERT, and NULL semantics. Tell me when you're starting it and I'll build out the same level of detail.
