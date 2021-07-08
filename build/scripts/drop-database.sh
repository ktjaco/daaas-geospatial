#!/bin/bash

# Environment variables.
source credentials.sh

# Drop the NRN database.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "DROP DATABASE $PG_NRN_DB;"

# Drop the SDI database.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "DROP DATABASE $PG_SDI_DB;"

# Drop the NATEARTH database.
psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "DROP DATABASE $PG_NAT_DB;"
