# PGQL(R): MongoDB → PostgreSQL Mastery Program
### A 17-week, 12 hrs/week program (Aug 24 – Dec 20, 2026) — ~204 hours total

**Starting point:** Proficient MongoDB developer, basic aggregation pipeline knowledge.
**Target:** Real-world-ready PostgreSQL proficiency across application development, analytics, and operations.
**Format:** Weekly modules, each with theory, hands-on labs, and a MongoDB→SQL bridge to leverage what you already know. A detailed session-by-session doc gets built out one week at a time — starting with Week 1, attached separately.

---

## How to read this roadmap

Every week lists: the topics, a suggested hour split, the MongoDB-to-Postgres bridge concept (your fastest path to intuition), and a hands-on deliverable. Treat the hands-on deliverable as non-negotiable — reading about indexes and building one that actually changes a query plan are different skills, and the second one is what "real-world ready" means.

Suggested weekly rhythm for your 12 hours: four 3-hour sessions (e.g., Mon/Tue/Thu/Sat) work well — enough to go deep in one sitting without burning out. Split however fits your schedule; just protect the hands-on block, don't compress it in favor of only reading.

---

## Module 1 — Foundations & Mental Model Shift (Weeks 1–3, 36h)

Goal: stop thinking in documents, start thinking in relations, sets, and constraints.

| Week | Dates | Topics | Bridge from Mongo | Hands-on deliverable |
|---|---|---|---|---|
| 1 | Aug 24–30 | Install Postgres + psql + a GUI client (pgAdmin/DBeaver/TablePlus); databases/schemas/tables; data types deep dive; DDL (CREATE/ALTER/DROP TABLE); primary & foreign keys | Collections → tables, but with enforced structure instead of a flexible schema | Load a sample DB (Pagila or Chinook), map its ER diagram by hand |
| 2 | Aug 31–Sep 6 | DML: SELECT/WHERE/ORDER BY/LIMIT/DISTINCT; INSERT/UPDATE/DELETE; UPSERT via `ON CONFLICT`; NULL semantics (three-valued logic) | `find()` filters → `WHERE`; `updateOne(upsert:true)` → `ON CONFLICT DO UPDATE` | Rewrite 15 of your own past Mongo `find()` queries as SQL against the sample DB |
| 3 | Sep 7–13 | JOINs (INNER/LEFT/RIGHT/FULL/CROSS/self-join) and the set theory behind them; GROUP BY + aggregates (COUNT/SUM/AVG/MIN/MAX); HAVING vs WHERE | `$lookup` → JOIN; `$group` → GROUP BY; `$match` after `$group` → HAVING | **Milestone project:** take 10 aggregation pipelines you've written in Mongo and reimplement them as SQL, side by side |

## Module 2 — Intermediate SQL Mastery (Weeks 4–6, 36h)

Goal: the tools that separate "can write a SELECT" from "can express any data question in one query."

| Week | Dates | Topics | Bridge from Mongo | Hands-on deliverable |
|---|---|---|---|---|
| 4 | Sep 14–20 | Subqueries (scalar, correlated, IN/EXISTS/ANY/ALL); CTEs (`WITH`); recursive CTEs | Recursive CTE → `$graphLookup` (hierarchies, org charts, category trees) | Build a recursive CTE that walks a category tree; compare to a `$graphLookup` version |
| 5 | Sep 21–27 | Window functions (ROW_NUMBER, RANK, DENSE_RANK, LAG/LEAD, NTILE, frame clauses); set operations (UNION/INTERSECT/EXCEPT) | `$setWindowFields` / `$bucket` → window functions — this is the single highest-leverage topic for someone with your background | Running totals, rank-within-group, and period-over-period deltas on a sales/orders dataset |
| 6 | Sep 28–Oct 4 | JSONB deep dive (operators, containment, GIN indexing, when to reach for it vs normalizing); full text search (tsvector/tsquery); array types | This is Postgres speaking your native language — a JSONB column *is* a Mongo document, with SQL wrapped around it | Design a hybrid schema: relational core + one JSONB column for a genuinely variable attribute set |

## Module 3 — Schema Design & Data Modeling (Weeks 7–8, 24h)

Goal: design schemas that hold up under real traffic and real change, not just the happy path.

| Week | Dates | Topics | Bridge from Mongo | Hands-on deliverable |
|---|---|---|---|---|
| 7 | Oct 5–11 | Normalization (1NF–3NF/BCNF) as an explicit trade-off, not dogma; constraints (CHECK/UNIQUE/NOT NULL); FK actions (CASCADE/RESTRICT/SET NULL); ENUM & custom domain types | Embedding vs referencing (Mongo) maps directly onto normalize vs denormalize (SQL) — same trade-off, different vocabulary | Take a Mongo schema you've designed before and produce a properly normalized Postgres equivalent, documenting each trade-off |
| 8 | Oct 12–18 | Index types deep dive: B-tree, Hash, GIN, GiST, BRIN; partial indexes, expression indexes, covering indexes (`INCLUDE`), multi-column index ordering; migration tooling concepts (Flyway/Liquibase/Alembic) | Compound indexes exist in Mongo too, but Postgres's index *variety* (GIN for JSONB/arrays, BRIN for time-series, partial for filtered hot paths) has no single Mongo equivalent | Design and justify a full indexing strategy for the Week 7 schema; verify each index actually gets used |

## Module 4 — Transactions, Concurrency & Performance (Weeks 9–11, 36h)

Goal: understand what's actually happening under a query, and why it's slow or blocked.

| Week | Dates | Topics | Bridge from Mongo | Hands-on deliverable |
|---|---|---|---|---|
| 9 | Oct 19–25 | ACID deep dive; isolation levels (Read Committed/Repeatable Read/Serializable); MVCC internals; row/table locking, deadlocks; `SELECT ... FOR UPDATE` | Mongo added multi-document transactions late and they're weaker by default — this week is where Postgres's guarantees genuinely exceed what you're used to | Reproduce a deadlock on purpose in two sessions, then fix it |
| 10 | Oct 26–Nov 1 | `EXPLAIN` / `EXPLAIN ANALYZE`; query planner internals; statistics (`ANALYZE`, `pg_stats`); seq scan vs index scan vs bitmap scan; common anti-patterns, N+1 queries | `.explain()` exists in Mongo too, but Postgres's planner and cost model are far more transparent and tunable | Take 5 deliberately slow queries, diagnose each with EXPLAIN ANALYZE, fix them, prove the fix with before/after plans |
| 11 | Nov 2–8 | VACUUM/autovacuum and table bloat; `pg_stat_statements`; connection basics; end-to-end query optimization workshop | No real Mongo equivalent — MVCC's cost (dead tuples) is a genuinely new concept | **Milestone project:** performance audit of a seeded 1M+ row dataset — find and fix the 5 worst queries |

## Module 5 — Advanced Postgres & Real-World Systems (Weeks 12–14, 36h)

Goal: the features that show up in production systems and in interviews about production systems.

| Week | Dates | Topics | Bridge from Mongo | Hands-on deliverable |
|---|---|---|---|---|
| 12 | Nov 9–15 | PL/pgSQL functions & procedures, triggers, exception handling; views and materialized views | Change streams → triggers (conceptually: "react to data changes"), though the mechanics differ completely | Write a trigger that maintains a denormalized summary table automatically; compare to a materialized view refresh approach |
| 13 | Nov 16–22 | Partitioning (range/list/hash); extensions ecosystem overview (pg_trgm, PostGIS, pgcrypto, pg_cron); logical replication & CDC concepts | Sharding (Mongo) vs partitioning (Postgres) — related idea, different mechanism and different scaling ceiling; CDC via logical replication ≈ change streams' server-side cousin | Partition a large table by date range; benchmark query performance before/after |
| 14 | Nov 23–29 | Roles & permissions, Row-Level Security (RLS); backup & restore (`pg_dump`, `pg_basebackup`, WAL); streaming replication basics, read replicas; connection pooling (PgBouncer); HA concepts (Patroni overview) | Replica sets → streaming replication — same goal (durability, read scaling, failover), different implementation | Set up a primary + streaming replica locally (Docker); take and restore a backup |

## Module 6 — Real-World Readiness & Capstone (Weeks 15–17, 36h)

Goal: prove it end to end, and be ready for what actually gets thrown at you on the job.

| Week | Dates | Topics | Hands-on deliverable |
|---|---|---|---|
| 15 | Nov 30–Dec 6 | Application integration: ORMs vs raw SQL trade-offs, connection pooling from the app side, migrations in CI/CD, batching, avoiding N+1 from app code | Wire a small app (any stack you're comfortable in) to Postgres with a migration tool and a connection pool configured correctly |
| 16 | Dec 7–13 | **Capstone, part 1:** pick a real MongoDB-modeled dataset/app you've built before. Design its Postgres schema, write the migration/transform/load script, define the indexing strategy | Working migration script + populated Postgres database + documented schema decisions |
| 17 | Dec 14–20 | **Capstone, part 2** + real-world troubleshooting drills: simulate lock contention, bloat, a slow query in production, replication lag; set up basic monitoring (`pg_stat` views); mock technical interview on Postgres internals; roadmap for what's next (Citus/sharding, logical decoding, extension development) | Incident runbook you wrote yourself from the drills, capstone demo, and a personal "next 90 days" advanced-topics plan |

---

## MongoDB → PostgreSQL cheat sheet

A quick-reference mapping you'll build out further as we go — this is the seed version:

- Collection → Table (but with an enforced schema and typed columns)
- Document → Row (or a JSONB column, if you genuinely need document flexibility)
- `_id` → Primary key (serial/identity or UUID)
- `find()` → `SELECT ... WHERE`
- `$lookup` → `JOIN`
- `$group` → `GROUP BY` (+ `HAVING` for post-aggregation filtering)
- `$match` → `WHERE` (pre-aggregation) or `HAVING` (post-aggregation)
- `$project` → column list in `SELECT`
- `$unwind` → `JOIN` against an unnested array, or `jsonb_array_elements()`
- `$setWindowFields` → window functions (`OVER (...)`)
- `$graphLookup` → recursive CTE
- Embedding vs referencing → denormalization vs normalization
- Sharding → partitioning (related, not identical)
- Replica set → streaming replication
- Change streams → triggers / logical replication (CDC)
- Compound index → multi-column B-tree index
- Schema validation rules → CHECK constraints + NOT NULL + foreign keys

## Resources to have on hand

- Official docs: postgresql.org/docs — the single best reference for exact syntax and version-specific behavior; check the version number against whatever you install
- Sample databases for practice: Pagila (a Postgres port of the classic Sakila DVD-rental dataset) and Chinook (a digital media store) — both give you a real schema instead of toy tables
- `psql` itself — get comfortable with `\d`, `\dt`, `\di`, `\timing`, and `EXPLAIN (ANALYZE, BUFFERS)` early; the terminal workflow is worth the friction

## How we'll actually run this

Each week, tell me you're starting it (or ahead/behind — the schedule flexes) and I'll build out that week's detailed session-by-session doc with exercises, sample datasets, and check-your-understanding questions, the way I did for Week 1. That keeps every week's content current to how the previous ones actually went, rather than everything being pre-written and generic.
