CREATE ROLE {{ db_user }} WITH PASSWORD '{{ db_password }}' NOSUPERUSER LOGIN;
CREATE SCHEMA {{ db_schema }};
CREATE TABLE IF NOT EXISTS {{ db_schema }}.{{ db_table }} (title VARCHAR(255), description TEXT);
ALTER SCHEMA {{ db_schema }} OWNER TO {{ db_user }};
ALTER TABLE {{ db_schema }}.{{ db_table }} OWNER TO vagrant;
