#!/bin/sh

for img in `ls -1 *_cog.tif`; 
	do rio cogeo validate $img
done
