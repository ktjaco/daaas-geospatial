#!/bin/sh

for img in `ls -1 .`;
	do gdal_translate -of GTiff $img ${img%%.*}.tif
done
