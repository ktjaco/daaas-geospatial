#!/bin/sh

source credentials.sh

# Build GeoServer development instance.
git clone https://github.com/ktjaco/docker-geoserver

cd docker-geoserver

git checkout 2.19.0

docker build -t daaas/geoserver_dev .

docker run -dtp 8085:8080 daaas/geoserver_dev

# Build Elasticsearch development instance.
docker network create esnet

docker run \
-d \
--name elasticsearch_dev \
--net esnet \
-p 9200:9200 \
-p 9300:9300 \
-e "discovery.type=single-node" \
elasticsearch:7.13.0

# Build GeoNetwork development instance.
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

# Download the geospatial datasets.
sh scripts/dl-data.sh

# Create the sdi, natearth and nrn databases.
sh scripts/create-db.sh
