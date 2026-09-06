# Session 2 — Data Types Deep Dive (Concepts)
### Week 1, Session 2 · Aug 24–30, 2026

Notes from the concepts block, kept here so they don't get lost once the hands-on overwrites working memory.

---

## Why Postgres's type system feels stricter than Mongo/BSON

MongoDB with BSON lets you be loose — a field can hold a string in one document and a number in another, and nothing stops you until application code breaks on it. Postgres enforces a type per column at the schema level. It pays off by catching bugs at insert time instead of in production. Everything below is in service of that: picking a type deliberately per column, not by habit.

---

## Numeric types

- `smallint` — 2 bytes, range up to ~32,767
- `integer` — 4 bytes, range up to ~2.1 billion
- `bigint` — 8 bytes, very large range

Pick based on how large the values could plausibly get — not reflexively the biggest one. Smaller types are more compact in indexes.

**`numeric(precision, scale)` vs `real` / `double precision`:**
- `numeric` stores an exact decimal — no rounding error, ever.
- `real` / `double precision` are IEEE floating point — fast, but imprecise.

Classic failure: store `19.99` as `double precision`, do enough arithmetic on it, and you can get `19.990000000000002`. **For money, always use `numeric`** — exactness matters more than speed for financial data.

---

## Text types

- `varchar(n)` — enforces a length cap
- `char(n)` — pads to a fixed length
- `text` — no limit

The surprising part coming from other databases: in Postgres, `text` and `varchar` have **identical performance** — there's no internal optimization `varchar` gets that `text` doesn't. Default to `text`; reach for `varchar(n)` only when the length cap is an actual business rule you want the database to enforce, not for performance.

---

## Boolean

Just `boolean` — `true` / `false` / `null`. The subtlety is the null: a boolean column without `NOT NULL` has **three** possible states, not two.

---

## Date/time types

- `timestamp` — date and time, **no timezone awareness**. A naive value.
- `timestamptz` — stored internally as UTC, converted on display based on the client's timezone setting.

**Gotcha:** if app servers, the database, and users are ever in different timezones (basically always, eventually), `timestamp` columns become silently ambiguous — `2026-08-25 14:00` means a different real moment depending on who's reading it.

**Default to `timestamptz` almost always**, even if everything's in one timezone today.

---

## UUID

A 128-bit identifier, commonly used as an alternative primary key to auto-incrementing integers.

Trade-off:
- Can be generated client-side with no coordination — useful for distributed systems or merging data from multiple sources.
- Larger than integers, not naturally sortable by creation time, and fragments B-tree indexes more than sequential integers do (random insertion order instead of always-appending at the end).

---

## JSONB

A binary-optimized JSON type — the column type that lets a single Postgres table hold something Mongo-document-shaped, for the part of the data that genuinely doesn't fit a fixed schema.

- Supports indexing (GIN) and querying into nested structure — unlike a plain `text` column holding JSON as a string.
- Full deep dive is **Week 6**. For now: it exists, and it's the answer when a column's shape is legitimately variable per row.

---

## Applying this: the `sandbox.users` table

Six columns, one deliberate type decision each:

| Column | Type decision to make | What to weigh |
|---|---|---|
| `id` | `bigserial` / `GENERATED ALWAYS AS IDENTITY` vs `uuid` | Sequential = compact, index-friendly. UUID = no coordination needed, but fragments indexes. |
| `email` | `text` vs `varchar(n)` | Same performance in Postgres — is a length cap an actual business rule here? |
| `created_at` | `timestamp` vs `timestamptz` | Timezone safety — `timestamptz` is the safer default. |
| `is_active` | `boolean` | Remember: nullable boolean = 3 states, not 2. |
| `account_balance` | `numeric(p,s)` vs `real`/`double precision` | Money needs exactness, not speed. |
| `metadata` | `jsonb` | Use only for the genuinely variable part of the data. |

---

**Next:** write the `CREATE TABLE sandbox.users (...)` statement in `session_2datatype.sql` using the decisions above, run it, then try inserting bad data on purpose (wrong type into a typed column, a duplicate into a unique column) and read what Postgres's error messages actually say.
