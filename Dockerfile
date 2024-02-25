FROM postgres:15-alpine
WORKDIR /var/lib/postgresql
COPY ./ddl_constructor.sql ./ddl_constructor.sql
CMD [ "psql -U postgres -f /var/lib/postgresql/ddl_constructor.sql"]
