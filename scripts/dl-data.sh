#!/bin/sh

cd ../data

cat ../scripts/link.txt | while read line 
do
   wget --no-check-certificate $line
done

for f in `ls -1 *.zip`; do unzip $f -d `basename $f .zip`; done

rm *.zip
