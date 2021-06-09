# Geospatial Platform Spatial Data Infrastructure - Proof of Concept

- [Geospatial Platform Spatial Data Infrastructure - Proof of Concept](#geospatial-platform-spatial-data-infrastructure---proof-of-concept)
  * [Before you begin...](#before-you-begin)
    + [Prerequisites](#prerequisites)
  * [Data Download](#data-download)
  * [Data Import](#data-import)
  * [Build GeoServer](#build-geoserver)

Data Analytics as a Service (DAaaS) spatial data infrastructure Proof of Concept (PoC)  that utilizes PostgreSQL/PostGIS backed geospatial services using GeoServer.

## Before you begin...

### Prerequisites
* PostgreSQL/PostGIS database
* postgresql-client
* shp2pgsql
* wget
* unzip
* tree (optional)
* Docker (optional)

Export the required environment variables to execute the shell scripts.

```sh
$ export DB_HOST={YOUR_HOST}
$ export PORT={YOUR_PG_PORT}
$ export DB_NAME={YOUR_DB_NAME}
$ export USER={YOUR_PG_USER_NAME}
$ export PGPASSWORD={YOUR_PG_PASSWD}
```

## Data Download

The data being used for this proof of concept uses the [2016 Statistics Canada Geography Boundary Files](ttps://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm) and the [National Road Network](https://open.canada.ca/data/en/dataset/3d282116-e556-400c-9306-ca1a3cada77f).

Navigate to the `scripts` directory.

```sh
$ cd scripts
```

Run the data download script.

```sh
$ sh dl-data.sh
```

The `data` directory should now contain the 2016 Statistics Canada Geography boundary files in the Esri Shapefile (.shp) data format.

```sh
$ cd ..
$ tree data
data
├── geca000e16a_e
│   ├── 92-639-g2016001-eng.pdf
│   ├── agricultural_ecumene.html
│   ├── agricultural_regions.html
│   ├── lagecu000e16a_e.CPG
│   ├── lagecu000e16a_e.dbf
│   ├── lagecu000e16a_e.prj
│   ├── lagecu000e16a_e.sbn
│   ├── lagecu000e16a_e.sbx
│   ├── lagecu000e16a_e.shp
│   ├── lagecu000e16a_e.shp.xml
│   ├── lagecu000e16a_e.shx
│   ├── lcdagecu000e16a_e.CPG
│   ├── lcdagecu000e16a_e.dbf
│   ├── lcdagecu000e16a_e.prj
│   ├── lcdagecu000e16a_e.sbn
│   ├── lcdagecu000e16a_e.sbx
│   ├── lcdagecu000e16a_e.shp
│   ├── lcdagecu000e16a_e.shp.xml
│   └── lcdagecu000e16a_e.shx
├── lada000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── aggregate_dissemination_area.html
│   ├── lada000b16a_e.dbf
│   ├── lada000b16a_e.prj
│   ├── lada000b16a_e.shp
│   └── lada000b16a_e.shx
.........
.........
.........
```

## Data Import

Next, import the Esri Shapefiles in the data directory into the PostgreSQL/PostGIS instance using the exported environment variables from above.

```sh
$ sh import.sh
```

## Build GeoServer

Build the Docker image.
```sh
$ docker build -t stc/daaas-geoserver .
```

Run the Docker container.
```sh
$ docker --name=daaas_geoserver run -dtp 8080:8080 stc/daaas-geoserver
```

GeoServer should now be running at `http://{YOUR_HOST}:8080/geoserver/web`.

To enter the Docker container if necessary.
```sh
$ docker exec -it {NAME} /bin/bash
```

Create GeoServer `systemd .service` file.
```sh
$ sudo nano /etc/systemd/system/daaas_geoserver.service
```

```
[Unit] 
Description=GeoServer container 
Requires=docker.service 
After=docker.service 

[Service] 
Restart=always 
ExecStart=/usr/bin/docker start -a daaas_geoserver
ExecStop=/usr/bin/docker stop -t 2 daaas_geoserver

[Install]
WantedBy=default.target
```

Enable the GeoServer service file.
```sh
$ sudo systemctl enable daaas_geoserver.service
```

Restart, stop, or start the GeoServer instance, or check the status.
```sh
$ sudo systemctl [restart | start | stop | status] daaas_geoserver.service
```

