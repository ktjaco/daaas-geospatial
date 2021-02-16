#!/bin/sh

# environment variables
# export DB_HOST=localhost
# export PORT=5432
# export DB_NAME=stc
# export USER=geoadm
# export PGPASSWORD=geoadm

# import STC boundary files into PostGIS
for shp in `ls -1 ../data/*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
done

for shp in `ls -1 ../data/nrn*/NRN*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
done

for shp in `ls -1 ../data/nrn*/NRN*/*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
done

for shp in `ls -1 ../data/nrn*/RRN*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
done

for shp in `ls -1 ../data/nrn*/RRN*/*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
done