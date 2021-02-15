FROM kartoza/geoserver:latest

ARG DB_HOST=

ARG PORT=

ARG DB_NAME=

ARG USER=

ARG PGPASSWORD=

ARG 

USER root

COPY . /daaas-geo

WORKDIR /daaas-geo/scripts/