#!/bin/sh

# Environment variables.
source ../credentials.sh

# Create the following databases if they do not exist.
psql \
--host=$PG_HOST \
--username=$PG_USERNAME \
--password=$PGPASSWORD \
--port=$PG_PORT \
-tc "SELECT 1 FROM pg_database WHERE datname = '$PG_SDI_DB'" | \
grep -q 1 | \
psql \
--host=$PG_HOST \
--username=$PG_USERNAME \
--password=$PGPASSWORD \
-c "CREATE DATABASE $PG_SDI_DB; CREATE EXTENSION postgis;"

psql \
--host=$PG_HOST \
--username=$PG_USERNAME \
--password=$PGPASSWORD \
--port=$PORT \
-tc "SELECT 1 FROM pg_database WHERE datname = '$PG_NRN_DB'" | \
grep -q 1 | \
psql \
--host=$PG_HOST \
--username=$PG_USERNAME \
--password=$PGPASSWORD \
--port=$PG_PORT \
-c "CREATE DATABASE $PG_NRN_DB; CREATE EXTENSION postgis;"

psql \
--host=$PG_HOST \
--username=$PG_USERNAME \
--password=$PGPASSWORD \
--port=$PORT \
-tc "SELECT 1 FROM pg_database WHERE datname = '$PG_NAT_DB'" | \
grep -q 1 | \
psql \
--host=$PG_HOST \
--username=$PG_USERNAME \
--password=$PGPASSWORD \
--port=$PG_PORT \
-c "CREATE DATABASE $PG_NAT_DB; CREATE EXTENSION postgis;"