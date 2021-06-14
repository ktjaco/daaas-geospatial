import glob
import os
import sys
import logging
import fnmatch
import subprocess
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

# First day of the month
first_day = datetime.today().replace(day=1)
first_day = datetime.strftime(first_day, '%Y%m%d')

# Set files and directories.
rel_time_txt = "C:\\EODM\\geolog\\" + year + yesterday_tbus + "\\REL_TIME.txt"
comp_txt = "C:\\EODM\\comp\\Composite" + year + yesterday_tbus + ".txt"
filter = "C:\\EODM\\geocode\\" + year + yesterday_tbus + "\\NOAA19\\*"
good_orbits = 'C:\\EODM\\run\\MakeListOfGoodOrbits.ps1'
geocode_dir = 'C:\\EODM\\geocode\\'
orbit_nrt = 'C:\\EODM\\run\\OrbitCompositeNRT.exe'
water_mask = 'C:\\EODM\\EODMsoft\\bin\\WaterMask_Canada_New.img'

# Create a new list directory.
if os.path.exists('C:\\EODM\\geocode\\' + year + yesterday_tbus + '\\list.txt'):
    os.remove('C:\\EODM\\geocode\\' + year + yesterday_tbus + '\\list.txt')

# Make a list of good orbits using MakeListOfGoodOrbits.ps1 PowerShell script.
good_orbits_command = [ "powershell.exe", good_orbits, "-d " + geocode_dir + year + yesterday_tbus + '\\' ]

# Execute the PowerShell script.
logger.info("Executing... %s" % str(good_orbits_command))
subprocess.call(good_orbits_command)

# Create a new list directory.
if not os.path.exists('C:\\EODM\\comp\\lists\\'):
    os.mkdir('C:\\EODM\\comp\\lists\\')

# Copy new list file to new list directory with YYYYMMDD.
os.system('copy ' + 'C:\\EODM\\geocode\\' + year + yesterday_tbus + '\\list.txt ' + 'C:\\EODM\\comp\\lists\\list-' + year + yesterday_tbus + '.txt')

# Execute orbit.py for the first time.
os. system('python orbit.py')

# Read the REL_TIME.txt file.
with open(rel_time_txt, "r") as f:

    # Read each of the lines from REL_TIME.txt into a list.
    list = f.readlines()
    # Apply the match filter on the list.
    match = fnmatch.filter(list, filter)
    # Strip out each of the pathway directories for each folder.
    # i.e. C:\EODM\geocode\20210512\NOAA19\D21132.S0148S
    rel_time = [ x[:45] for x in match ]

    # Read the CompositeYYYMMDD.txt file.
    with open(comp_txt, "r") as f:
        # Read each of the lines from CompositeYYYMMDD.txt into a list.
        comp = f.readlines()
        comp = [ x[:-1] for x in comp ]
        # diff = [ x for x in comp if x not in rel_time ]
        # Create a new Composite list that removes the folders that aren't in REL_TIME.txt.
        # This is a list of similar folders.
        new_comp = [ x for x in rel_time if x in comp ]
        # Overwrite the CompositeYYYYMMDD.txt file.
        with open(comp_txt, "w") as f:
            # For each line in the new CompositeYYYYMMDD.txt write it the file.
            for line in new_comp:
                f.write('%s\n' % line)
            # Remove the last blank new line.
            f.write("%s" % new_comp[-1])

# Remove the files in the geolog directory.
files = glob.glob("C:\\EODM\\geolog\\" + year + yesterday_tbus + "\\*")
for f in files:
    os.remove(f)

# Command used in step one: OrbitCompositeNRT.exe
# This is essentially the re-running of orbit.py
command = [orbit_nrt,
           comp_txt,
           "6",
           "C:\\EODM\\geolog\\" + year + yesterday_tbus,
           "55",
           "0",
           "90",
           first_day, # First day of month
           "1000",
           water_mask]

# Call the command in CMD prompt.
logger.info("Executing... " + str(command))
subprocess.call(command)