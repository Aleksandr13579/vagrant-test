CREATE DATABASE "parsing_site";
\connect "parsing_site";
CREATE ROLE parser WITH PASSWORD 'parser' NOSUPERUSER;
CREATE SCHEMA "parse_site";
CREATE TABLE IF NOT EXISTS "parser_site.parsed_data" (title VARCHAR(255), description TEXT);
ALTER SCHEMA "parse_site" OWNER TO parser;
ALTER TABLE "parser_site.parsed_data" OWNER TO parser;
