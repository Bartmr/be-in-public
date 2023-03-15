## Actions

- `CREATE or REPLACE`
  - useful for development, when you just want to set stuff like `CREATE or REPLACE FUNCTION fetch_user_data()`

## Get JSON
  ```sql
  SELECT 
    id, 
    data::json->'name' as name
  FROM books
  ```

## Validation

### `CHECK` constraint

- https://www.postgresql.org/docs/current/ddl-constraints.html

### `pg_jsonschema` extension

- https://supabase.com/blog/pg-jsonschema-a-postgres-extension-for-json-validation

## Types

Create types to be used as `RETURN` or `DECLARE`` types

- https://www.postgresql.org/docs/current/sql-createtype.html

### Composite types

The `CREATE TYPE` statement allows you to create a composite type, which can be used as the return type of a function.

Suppose you want to have a function that returns several values: film_id, title, and release_year. The first step is to create a type e.g., film_summary as follows:

```sql
CREATE TYPE film_summary AS (
    film_id INT,
    title VARCHAR,
    release_year SMALLINT
);
```

To change a user-defined type, you use the `ALTER TYPE` statement. To remove a user-defined type, you use the `DROP TYPE` statement.

### Domains

- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-user-defined-data-types/

They are like base classes to be extended. They contain validation rules and others that will be associated with a type.

```sql
CREATE DOMAIN contact_name AS 
   VARCHAR NOT NULL CHECK (value !~ '\s');

CREATE TABLE mailing_list (
    id serial PRIMARY KEY,
    first_name contact_name,
    last_name contact_name,
    email VARCHAR NOT NULL
);
```

The following statement returns domains in the public schema of the current database:

```sql
SELECT typname 
FROM pg_catalog.pg_type 
  JOIN pg_catalog.pg_namespace 
  	ON pg_namespace.oid = pg_type.typnamespace 
WHERE 
	typtype = 'd' and nspname = 'public';
```