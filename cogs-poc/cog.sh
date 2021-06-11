#!/bin/sh

for img in `ls -1 *.tif`;
	do gdal_translate ${img%%.*}.tif ${img%%.*}_cog.tif -of COG -co COMPRESS=LZW
done
