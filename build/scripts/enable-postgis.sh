#!/bin/bash

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname=nrn \
    -c "CREATE EXTENSION postgis;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname=sdi \
    -c "CREATE EXTENSION postgis;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    --dbname=natearth \
    -c "CREATE EXTENSION postgis;"