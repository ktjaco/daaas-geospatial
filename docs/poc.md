# Geospatial Platform Spatial Data Infrastructure - Proof of Concept

- [Geospatial Platform Spatial Data Infrastructure - Proof of Concept](#geospatial-platform-spatial-data-infrastructure---proof-of-concept)
  * [Before you begin...](#before-you-begin)
    + [Prerequisites](#prerequisites)
  * [Data Download](#data-download)
  * [Data Import](#data-import)
  * [Using Docker](#using-docker)

Data Analytics as a Service (DAaaS) spatial data infrastructure Proof of Concept (PoC)  that utilizes PostgreSQL/PostGIS backed geospatial services using GeoServer.

## Before you begin...

### Prerequisites
* PostgreSQL/PostGIS database
* postgresql-client
* shp2pgsql
* wget
* unzip
* tree (optional)

Export the required environment variables to execute the shell scripts.

```sh
$ export DB_HOST=<YOUR_HOST>
$ export PORT=<YOUR_PG_PORT>
$ export DB_NAME=<YOUR_DB_NAME>
$ export USER=<YOUR_PG_USER_NAME>
$ export PGPASSWORD=<YOUR_PG_PASSWD>
```

## Data Download

The data being used for this proof of concept uses the 2016 Statistics Canada Geography boundary files that can be found over the [internet](https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm).

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
├── lcar000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── agricultural_regions.html
│   ├── lcar000b16a_e.dbf
│   ├── lcar000b16a_e.prj
│   ├── lcar000b16a_e.shp
│   └── lcar000b16a_e.shx
├── lccs000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── consolidated_census_subdivisions.html
│   ├── lccs000b16a_e.dbf
│   ├── lccs000b16a_e.prj
│   ├── lccs000b16a_e.shp
│   └── lccs000b16a_e.shx
├── lcd_000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── census_division.html
│   ├── lcd_000b16a_e.dbf
│   ├── lcd_000b16a_e.prj
│   ├── lcd_000b16a_e.shp
│   └── lcd_000b16a_e.shx
├── lcma000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── census_metropolitan_area.html
│   ├── lcma000b16a_e.dbf
│   ├── lcma000b16a_e.prj
│   ├── lcma000b16a_e.shp
│   └── lcma000b16a_e.shx
├── lcsd000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── census_subdivision.html
│   ├── lcsd000b16a_e.dbf
│   ├── lcsd000b16a_e.prj
│   ├── lcsd000b16a_e.shp
│   └── lcsd000b16a_e.shx
├── lct_000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── census_tract.html
│   ├── lct_000b16a_e.dbf
│   ├── lct_000b16a_e.prj
│   ├── lct_000b16a_e.shp
│   └── lct_000b16a_e.shx
├── lda_000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── dissemination_area.html
│   ├── lda_000b16a_e.dbf
│   ├── lda_000b16a_e.prj
│   ├── lda_000b16a_e.shp
│   └── lda_000b16a_e.shx
├── ldb_000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── dissemination_blocks.html
│   ├── ldb_000b16a_e.dbf
│   ├── ldb_000b16a_e.prj
│   ├── ldb_000b16a_e.shp
│   └── ldb_000b16a_e.shx
├── ldpl000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── designated_place.html
│   ├── ldpl000b16a_e.dbf
│   ├── ldpl000b16a_e.prj
│   ├── ldpl000b16a_e.shp
│   └── ldpl000b16a_e.shx
├── lecu000e16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── lcd_000e16a_e.dbf
│   ├── lcd_000e16a_e.prj
│   ├── lcd_000e16a_e.shp
│   ├── lcd_000e16a_e.shx
│   ├── lecu000e16a_e.dbf
│   ├── lecu000e16a_e.prj
│   ├── lecu000e16a_e.shp
│   ├── lecu000e16a_e.shx
│   ├── lhy_000e16a_e.dbf
│   ├── lhy_000e16a_e.prj
│   ├── lhy_000e16a_e.shp
│   ├── lhy_000e16a_e.shx
│   ├── lpr_000e16a_e.dbf
│   ├── lpr_000e16a_e.prj
│   ├── lpr_000e16a_e.shp
│   ├── lpr_000e16a_e.shx
│   └── population_ecumene.html
├── ler_000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── economic_region.html
│   ├── ler_000b16a_e.dbf
│   ├── ler_000b16a_e.prj
│   ├── ler_000b16a_e.shp
│   └── ler_000b16a_e.shx
├── lfed000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── federal_electoral_district.html
│   ├── lfed000b16a_e.dbf
│   ├── lfed000b16a_e.prj
│   ├── lfed000b16a_e.shp
│   └── lfed000b16a_e.shx
├── lfsa000b16a_e
│   ├── 92-179-g2016001-eng.pdf
│   ├── forward_sortation_area.html
│   ├── lfsa000b16a_e.dbf
│   ├── lfsa000b16a_e.prj
│   ├── lfsa000b16a_e.shp
│   └── lfsa000b16a_e.shx
├── lhy_000c16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── lakes_rivers_poly.html
│   ├── lhy_000c16a_e.dbf
│   ├── lhy_000c16a_e.prj
│   ├── lhy_000c16a_e.shp
│   └── lhy_000c16a_e.shx
├── lhy_000d16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── lhy_000d16a_e.dbf
│   ├── lhy_000d16a_e.prj
│   ├── lhy_000d16a_e.shp
│   ├── lhy_000d16a_e.shx
│   └── rivers_lines.html
├── lhy_000h16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── coastal_waters.html
│   ├── lhy_000h16a_e.dbf
│   ├── lhy_000h16a_e.prj
│   ├── lhy_000h16a_e.shp
│   └── lhy_000h16a_e.shx
├── lpc_000b16a_e
│   ├── 92-160-g2016002-eng.pdf
│   ├── lpc_000b16a_e.dbf
│   ├── lpc_000b16a_e.prj
│   ├── lpc_000b16a_e.shp
│   ├── lpc_000b16a_e.shx
│   └── population_center.html
└── lpr_000b16a_e
    ├── 92-160-g2016002-eng.pdf
    ├── lpr_000b16a_e.dbf
    ├── lpr_000b16a_e.prj
    ├── lpr_000b16a_e.shp
    ├── lpr_000b16a_e.shx
    └── province_territory.html
```

## Data Import

Next, import the Esri Shapefiles in the data directory into the PostgreSQL/PostGIS instance using the exported environment variables from above.

```sh
$ sh import.sh
```

## Using Docker

