#!/bin/sh

# move to data directory
cd ../data

# download STC Geography boundary files
cat ../scripts/link.txt | while read line 
do
   wget --no-check-certificate $line
done

# unzip zip files
for f in `ls -1 *.zip`;
	do unzip $f -d `basename $f .zip`;
done

# remove zip files
rm *.zip
