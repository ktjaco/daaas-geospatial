#!/bin/bash

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    -c "CREATE DATABASE nrn;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    -c "CREATE DATABASE sdi;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    -c "CREATE DATABASE natearth;"