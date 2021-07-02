import logging
import os
import sys
import requests
from itertools import islice

# Set logger.
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s: %(message)s", "%Y-%m-%d %H:%M:%S"))
logger.addHandler(handler)

# File name for the NOAA download.
eodm_noaa = "C:\\EODM\\EODMSoft\\NORAD\\noaa-19.txt"

# URL for the NOAA download.
url = "http://www.celestrak.com/norad/elements/noaa.txt"

# Request sent to NOAA page for text file.
r = requests.get(url)

# Open the NOAA text file and write it to the directory.
noaa = open('noaa.txt', 'wb').write(r.content)

with open("noaa.txt") as f:

    # Loop through each line in the text file.
    for line in f:
        # If the line is equal to "NOAA 19 [+]" strip the next to lines
        if line.rstrip() == "NOAA 19 [+]":
            line_1 = (list(islice(f, 1))[-1])
            line_2 = (list(islice(f, 1))[-1])
            logger.info("Extracted line 1... " + line_1)
            logger.info("Extracted line 2... " + line_2)
            # Append the lines to the file located in the EODM NOAA program directory.
            with open(eodm_noaa, 'a') as f:
                f.write("\n" + line_1)
                f.write(line_2.strip('\n'))
# Remove the unnecessary downloaded test file.
os.remove("noaa.txt")