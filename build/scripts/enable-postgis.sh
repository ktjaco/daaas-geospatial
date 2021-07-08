#!/bin/bash

# Environment variables.
source credentials.sh

# Create the PostGIS extension for NRN.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname=$PG_NRN_DB \
    -c "CREATE EXTENSION postgis;"

# Create the PostGIS extension for SDI.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname=$PG_SDI_DB \
    -c "CREATE EXTENSION postgis;"

# Create the PostGIS extension for NATEARTH.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname=$PG_NAT_DB \
    -c "CREATE EXTENSION postgis;"
