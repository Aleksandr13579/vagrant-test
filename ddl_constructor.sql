CREATE DATABASE "parsing_site";
\connect "parsing_site";
CREATE ROLE vagrant WITH PASSWORD 'vagrant' NOSUPERUSER, LOGIN;
CREATE SCHEMA "parse_site";
CREATE TABLE IF NOT EXISTS "parser_site.parsed_data" (title VARCHAR(255), description TEXT);
ALTER SCHEMA "parse_site" OWNER TO 'vagrant';
ALTER TABLE "parser_site.parsed_data" OWNER TO 'vagrant';
