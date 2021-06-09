#!/bin/sh

for img in `ls -1 .`;
	do gdalwarp -t_srs EPSG:4326 ${img%%.*}.tif ${img%%.*}_4326.tif 
done
