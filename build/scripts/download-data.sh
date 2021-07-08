#!/bin/bash

source credentials.sh

cd $DATA_DIR

# Download geospatial datasets from the link.txt file.
cat $LINKS | while read line 
do
   wget --no-check-certificate $line
done

# Unzip the .zip files.
for f in `ls -1 *.zip`;
do unzip $f -d `basename $f .zip`;
done

# Remove zip files.
rm *.zip
