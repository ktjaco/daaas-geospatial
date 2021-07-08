#!/bin/bash

# Environment variables.
source credentials.sh

# Import STC boundary files into PostGIS.
for shp in `ls -1 $DATA_DIR/l*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_SDI_DB
done

for shp in `ls -1 $DATA_DIR/g*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_SDI_DB
done

for shp in `ls -1 $DATA_DIR/c*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_SDI_DB
done

# Import NRN files into PostGIS.
for shp in `ls -1 $DATA_DIR/nrn*/NRN*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NRN_DB
done

for shp in `ls -1 $DATA_DIR/nrn*/NRN*/NRN*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NRN_DB
done

for shp in `ls -1 $DATA_DIR/nrn*/RRN*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NRN_DB
done

for shp in `ls -1 $DATA_DIR/nrn*/RRN*/*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NRN_DB
done

# Import Natural Earth files into PostGIS.
for shp in `ls -1 $DATA_DIR/ne*/*.shp`;
do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NAT_DB
done
