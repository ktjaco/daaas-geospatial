import bs4
import fnmatch
import logging
import os
import requests
import sys
from datetime import datetime, timedelta

# Set logger.
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s: %(message)s", "%Y-%m-%d %H:%M:%S"))
logger.addHandler(handler)

# Yesterday's date.
yesterday = datetime.now() - timedelta(1)

# Yesterday's date, MMDD.
yesterday_tbus = datetime.strftime(yesterday, '%m%d')

# Yesterday's year, YYYY.
year = datetime.strftime(yesterday, '%Y')

# Yesterday's year in short, YY.
year_short = datetime.strftime(yesterday, '%y')

# Set directory where raw imagery will be downloaded.
tbus_dir = 'C:\\EODM\\EODMsoft\\TBUS\\' + year + '\\'

# NRCan's EODMS Base URL.
base_url = "https://data.eodms-sgdot.nrcan-rncan.gc.ca"

# Concatenate date's to create the AVHRR repository.
url = base_url + "/public/avhrr/TBUS/" + year + "/"

# Using the URL, request the AVHRR NRCan page.
r = requests.get(url)

# Scrap the HTML page so it can be used to extract the file names.
data = bs4.BeautifulSoup(r.text, "html.parser")

# Loop that extracts the href files names and download each of the files for yesterday's date.
for l in data.find_all("a"):
    # Move to the TBUS directory.
    os.chdir(tbus_dir)
    # Empty list to store the TBUS file names.
    list = []
    # Using the URL, request the AVHRR NRCan page with the file names (HREF).
    r = requests.get(base_url + l["href"])
    # Append the file name to the empty list.
    list.append(l["href"].split("/")[-1])
    # Filter the file name given yesterday's date.
    match = fnmatch.filter(list, "TBUS" + year_short + yesterday_tbus + ".*")

    # Loop that will download the files only in the list.
    for file in match:
        # Open the file.
        file = open(file, 'wb')
        # Log the file that is being downloaded.
        logger.info(f"Downloading... " + l["href"].split("/")[-1])
        # Write the file to the current folder.
        file.write(r.content)
        # Close the file.
        file.close()
