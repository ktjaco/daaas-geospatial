#!/bin/bash

# Environment variables.
source credentials.sh

# Create the NRN database.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "CREATE DATABASE $PG_NRN_DB;"

# Create the SDI database.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "CREATE DATABASE $PG_SDI_DB;"

# Create the NATEARTH database.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "CREATE DATABASE $PG_NAT_DB;"
