CREATE ROLE vagrant WITH PASSWORD 'vagrant' NOSUPERUSER LOGIN;
CREATE SCHEMA parser_site
	CREATE TABLE IF NOT EXISTS parsed_data (title VARCHAR(255), description TEXT);
ALTER SCHEMA parser_site OWNER TO vagrant;
ALTER TABLE parser_site.parsed_data OWNER TO vagrant;
