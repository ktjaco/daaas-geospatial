#!/bin/bash

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    -c "DROP DATABASE nrn;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    -c "DROP DATABASE sdi;"

psql \
    --host=$PG_HOST \
    --username=$PG_USERNAME \
    --port=$PG_PORT \
    -c "DROP DATABASE natearth;"
