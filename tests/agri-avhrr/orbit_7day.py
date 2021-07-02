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
raw_dir = "C:\\EODM\\raw\\"
output = "C:\\EODM\\geolog\\2021W15\\"
orbit_nrt = "C:\\EODM\\run\\OrbitCompositeNRT.exe"
water_mask = "C:\\EODM\\EODMsoft\\bin\\WaterMask_Canada_New.img"

# Yesterday's date.
yesterday = datetime.now() - timedelta(1)

# Yesterday's date, MMDD.
yesterday_tbus = datetime.strftime(yesterday, '%m%d')

# Yesterday's year, YYYY.
year = datetime.strftime(yesterday, '%Y')

# Yesterday's year in short, YY.
year_short = datetime.strftime(yesterday, '%y')

# First day of the month
first_day = datetime.today().replace(day=1)
first_day = datetime.strftime(first_day, '%Y%m%d')

# The new Composite.txt that will be created based on yesterday's date.
comp_text = "C:\\EODM\\comp\\Composite" + year + yesterday_tbus + ".txt"

# Command used in step one: OrbitCompositeNRT.exe
command = [orbit_nrt,
           comp_text,
           "1",
           output,
           "55",
           "0",
           "90",
           first_day, # First day of month
           "1000",
           water_mask]

# Call the command in CMD prompt.
logger.info("Executing... %s" % str(command))
subprocess.call(command)