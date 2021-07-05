#!/bin/bash

source credentials.sh
STEP=$1

# Check for at least one parameter
if [[ $# -eq 0 ]]; then
    echo "Must pass at least one parameter. Valid parameters include:"
    echo ""
    echo "- build_geoserver"
    echo "- build_elasticsearch"
    echo "- build_geonetwork"
    echo "- download_data"
    echo "- create_database"
    echo "- enable_postgis"
    echo "- "
    exit 0
fi

# Build GeoServer development instance.
if [[ ${STEP} = "build_geoserver" ]]; then
    cd $BUILD_DIR
    git clone https://github.com/ktjaco/docker-geoserver
    cd docker-geoserver
    git checkout 2.19.0
    docker build -t daaas/geoserver_dev .
    docker run -dtp 8085:8080 daaas/geoserver_dev
fi

# Build Elasticsearch development instance.
if [[ ${STEP} = "build_elasticsearch" ]]; then
    docker network create esnet
    docker run \
    -d \
    --name elasticsearch_dev \
    --net esnet \
    -p 9200:9200 \
    -p 9300:9300 \
    -e "discovery.type=single-node" \
    elasticsearch:7.13.0
fi

# Build GeoNetwork development instance.
if [[ ${STEP} = "build_geonetwork" ]]; then
    docker run \
    --name geonetwork_dev \
    -dp 8080:8080 \
    -e POSTGRES_DB_HOST=$PG_HOST \
    -e POSTGRES_DB_PORT=$PG_PORT \
    -e POSTGRES_DB_USERNAME=$PG_USERNAME \
    -e POSTGRES_DB_PASSWORD=$PGPASSWORD \
    -e POSTGRES_DB_NAME=$PG_GN_DB \
    -e ES_HOST=localhost \
    geonetwork:3.10.6
fi

# Download the geospatial datasets.
if [[ ${STEP} = "download_data" ]]; then
    bash scripts/download-data.sh
fi

# Create the sdi, natearth and nrn databases.
if [[ ${STEP} = "create_database" ]]; then
    bash scripts/create-database.sh
fi

# Drop the sdi, natearth and nrn databases.
if [[ ${STEP} = "drop_database" ]]; then
    bash scripts/drop-database.sh
fi

# Enable the PostGIS extension in the databases.
if [[ ${STEP} = "enable_postgis" ]]; then
    bash scripts/enable-postgis.sh
fi

# Import the datasets into the PostGIS database.
if [[ ${STEP} = "import_data" ]]; then
    bash scripts/import-data.sh
fi
