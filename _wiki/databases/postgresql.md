---
title: PostgreSQL
permalink: "/wiki/databases/postgresql/"

---

## List of databases

```sql
\l
```

## List of roles

```sql
\du
```

## List of schemas

```sql
\dn
```

## Check current/default schema

```sql
show search_path;
```

## Change default schema for session

```sql
set search_path='public';
```

## Top 10 tables
```sql
SELECT
  nspname AS schema_name,
  relname AS table_name,
  pg_size_pretty(pg_relation_size(C.oid)) AS main_data_size,
  pg_size_pretty(pg_total_relation_size(C.oid) - pg_relation_size(C.oid)) AS external_objects_size,
  pg_size_pretty(pg_indexes_size(C.oid)) AS indexes_size
FROM
  pg_class C
LEFT JOIN
  pg_namespace N ON (N.oid = C.relnamespace)
WHERE
  C.relkind = 'r'
ORDER BY
  pg_total_relation_size(C.oid) DESC
LIMIT 10;
```
