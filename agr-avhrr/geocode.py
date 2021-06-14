import logging
import os
import sys
import subprocess
from datetime import datetime, timedelta

# Set logger.
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s: %(message)s", "%Y-%m-%d %H:%M:%S"))
logger.addHandler(handler)

# Set the directories.
raw_dir = 'C:\\EODM\\raw\\'
eodm_nrt = 'C:\\EODM\\run\\EODM_NRT.exe'
good_orbits = 'C:\\EODM\\run\\MakeListOfGoodOrbits.ps1'
output = 'C:\\EODM\\geocode\\'
work_dir = 'C:\\EODM\\run\\'

# Yesterday's date.
yesterday = datetime.now() - timedelta(1)

# Yesterday's date, MMDD.
yesterday_tbus = datetime.strftime(yesterday, '%m%d')

# Yesterday's year, YYYY.
year = datetime.strftime(yesterday, '%Y')

# Loop through each file in the raw directory and execute the EODM_NRT.exe
for file in os.listdir(raw_dir):
    # Change the working directory.
    os.chdir(work_dir)
    # command used in step one: EODM_NRT.exe [RAW_IMAGERY_DIR] [OUTPUT_DIR] 1//2
    command = [eodm_nrt,
               raw_dir + file,
               output,
               "1"]
    # call the command in CMD prompt
    logger.info("Executing... " + str(command))
    subprocess.call(command, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
