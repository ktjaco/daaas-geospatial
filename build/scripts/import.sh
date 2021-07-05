#!/bin/sh

# Environment variables.
source ../credentials.sh

# Import STC boundary files into PostGIS.
for shp in `ls -1 ../data/l*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_SDI_DB
done

for shp in `ls -1 ../data/g*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_SDI_DB
done

# Import NRN files into PostGIS
for shp in `ls -1 ../data/nrn*/NRN*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NRN_DB
done

for shp in `ls -1 ../data/nrn*/NRN*/NRN*/*.shp`;	
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NRN_DB
done

for shp in `ls -1 ../data/ne*/*.shp`;
	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
	psql --host=$PG_HOST --port=$PG_PORT --username=$PG_USERNAME --dbname=$PG_NAT_DB
done

# for shp in `ls -1 ../data/nrn*/RRN*/*.shp`;	
# 	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
# 	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
# done

# for shp in `ls -1 ../data/nrn*/RRN*/*/*.shp`;	
# 	do shp2pgsql -W latin1 -s 3347 -g geom -I -D $shp `basename $shp .shp` | \
# 	psql --host=$DB_HOST --port=$PORT --username=$USER --dbname=$DB_NAME
# done
