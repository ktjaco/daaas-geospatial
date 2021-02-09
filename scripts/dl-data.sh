#!/bin/sh

echo "Download Statistics Canada Geography boundary files."
sleep 2s

echo "Downloading... Provinces/Territories."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lpr_000b16a_e.zip
sleep 2s

echo "Downloading... Federal Electoral Districts."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lfed000b16a_e.zip
sleep 2s

echo "Downloading... Economic Regions."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/ler_000b16a_e.zip
sleep 2s

echo "Downloading... Census Divisions."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lcd_000b16a_e.zip
sleep 2s

echo "Downloading... Aggregate Dissemination Areas."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lada000b16a_e.zip
sleep 2s

echo "Downloading... Census Agriculture Regions."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lcar000b16a_e.zip
sleep 2s

echo "Downloading... Census Consolidated Subdivisions."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lccs000b16a_e.zip
sleep 2s

echo "Downloading... Census Subdivisions."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lcsd000b16a_e.zip
sleep 2s

echo "Downloading... Census Metropolitan Areas and Census Agglomerations."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lcma000b16a_e.zip
sleep 2s

echo "Downloading... Census Tracts."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lct_000b16a_e.zip
sleep 2s

echo "Downloading... Dissemination Areas."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lda_000b16a_e.zip
sleep 2s

echo "Downloading... Dissemination Blocks."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/ldb_000b16a_e.zip
sleep 2s

echo "Downloading... Designated Places."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/ldpl000b16a_e.zip
sleep 2s

echo "Downloading... Population Centres."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lpc_000b16a_e.zip
sleep 2s

echo "Downloading... Population Ecumene."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lecu000e16a_e.zip
sleep 2s

echo "Downloading... Agriculture Ecumene."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/geca000e16a_e.zip
sleep 2s

echo "Downloading... Forward Sortation Areas."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lfsa000b16a_e.zip
sleep 2s

echo "Downloading... Lakes and Rivers."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lhy_000c16a_e.zip
sleep 2s

echo "Downloading... Rivers."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lhy_000d16a_e.zip
sleep 2s

echo "Downloading... Coastal Waters."
wget --no-check-certificate https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lhy_000d16a_e.zip
sleep 2s
