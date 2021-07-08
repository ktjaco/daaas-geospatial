# FOSS Geospatial Platform Infrastructure

The following scripts were tested on an Azure Standard D2s v3 (2 vcpus, 8 GiB memory) instance with Ubuntu LTS 20.04 and RHEL 8. It is also recommended to have 100 GiB + of available disk space.

## Initial Setup

Update the OS and install the prerequisite packages.

**Ubuntu**
```bash
$ sudo apt update
$ sudo apt -y upgrade
$ sudo apt -y install git unzip wget
```

### PostgreSQL and PostGIS

Add the Postgresql repository.

**Ubuntu**
```bash
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
```

Install PostgreSQL and PostGIS.

```bash
$ sudo apt update
$ sudo apt -y install postgresql-12 postgresql-client-12
$ sudo apt -y install postgis postgresql-12-postgis-3
```

You should now have the ```psql``` and ```shp2pgsql``` command line interfaces available.
```bash
$ psql --help
$ shp2pgsql --help
```
### Docker

Install the prerequisite packages.

**Ubuntu**
```bash
$ sudo apt update
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

Add the Docker repository.

```bash
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
$ sudo apt update
```

Install Docker.

```bash
$ sudo apt install docker-ce
```

Check to see if Docker is running.

```bash
$ sudo systemctl status docker
```

Add your user to the Docker group. Log out, then back in to take effect.

```bash
$ sudo usermod -aG docker ${USER}
$ exit
```

## Configure Credentials

Copy the credentials template script as ```credentials.sh``` and fill out the appropriate environment variables. ```credentials.sh.template``` outlines an example file.
```bash
$ cp credentials.sh.template credentials.sh
```

## Build GeoServer

Build the GeoServer instance. This GeoServer Dockerfile was forked from [Kartoza](https://github.com/kartoza/docker-geoserver).
```bash
$ ./main.sh build_geoserver
```

GeoServer should now be running at ```http://localhost:8085/geoserver/web/```.
```bash
$ curl http://localhost:8085/geoserver/web/
```

## Build Elasticsearch

Build the Elasticsearch instance required for the GeoNetwork catalog.
```bash
$ ./main.sh build_elasticsearch
```

Elasticsearch should now be running at ```http://localhost:9200/```.
```bash
$ curl http://localhost:9200
```

## Build GeoNetwork

Build the GeoNetwork instance.
```bash
$ ./main.sh build_geonetwork
```

GeoServer should now be running at ```http://localhost:8080/geonetwork/```.
```bash
$ curl http://localhost:8080/geonetwork/srv/eng/catalog.search#/home
```

## Download Data

Download the geospatial datasets and unzip them in the data directory. The main geospatial data that will be downloaded include; Statistics Canada geographic boundaries, National Road Network, Natural Resource Canada place names and Natural Earth foreign land boundaries.
```bash
$ ./main.sh download_data
```

## Database Creation

Create the PostgreSQL databases if they do not already exist.
```bash
$ ./main.sh create_database
```

Drop the PostgreSQL databases if necessary.
```bash
$ ./main.sh drop_database
```

Enable the PostGIS extension on the newly created databases.
```bash
$ ./main.sh enable_postgis
```

## Import Data

Import the geospatial datasets in your data directory into your
```bash
$ ./main.sh import_data
```
