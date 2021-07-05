#!/bin/bash

source ../credentials.sh

# move to data directory
cd $DATA_DIR

# download STC Geography boundary files
cat $LINK | while read line 
do
   wget --no-check-certificate $line
done

# unzip zip files
for f in `ls -1 *.zip`;
	do unzip $f -d `basename $f .zip`;
done

# remove zip files
rm *.zip
