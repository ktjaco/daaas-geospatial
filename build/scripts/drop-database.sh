#!/bin/bash

source credentials.sh

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "DROP DATABASE $PG_NRN_DB;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "DROP DATABASE $PG_SDI_DB;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname='postgres' \
    -c "DROP DATABASE $PG_NAT_DB;"
