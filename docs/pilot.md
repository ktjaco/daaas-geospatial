# Pilot Project - Software Installation Documentation
- [Technical Documentation](#technical-documentation)
- [Preparatory Stage](#preparatory-stage)
- [Database Loading](#database-loading)
  * [Setup](#setup)
  * [Data Import](#data-import)
  * [Preparation](#preparation)
- [Application Installation](#application-installation)
  * [Preparation](#preparation-1)
  * [Apache Tomcat](#apache-tomcat)
    + [Installation](#installation)
- [GeoServer](#geoserver)

# Preparatory Stage
SSH into the EC2 Instance.
```
$ ssh -i "DAaaS.pem" ec2-user@ip
```
Connect to AWS RDS once logged into the EC2 instance.
```
$ psql --host=DB_HOST --port=PORT --username=USER --password
```
Install GDAL and PostGIS needed for data prepartation and database imports.
```
$ sudo -i
# yum install gdal postgis
```
Create the project directory.
```
# cd ~
# mkdir -P pilot/geobounds
# mkdir -P pilot/data
```
# Database Loading
## Setup
Run setup script to initialize the pilot database.
```
$ sudo -i
# psql --host=DB_HOST --port=PORT --username=USER --file=/home/$USER/pilot/db-setup.sql
```
## Data Import
Download and unzip Economic Regions Esri Shapefile.
```
# wget -P geobounds http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/ler_000b16a_e.zip
# unzip geobounds/ler_000b16a_e.zip -d geobounds
# ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 -s_srs EPSG:3347 geobounds/ler_000b16a_e_4326.shp geobounds/ler_000b16a_e.shp
```
Download and unzip Province boundaries Esri Shapefile.
```
# wget -P geobounds http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lpr_000b16a_e.zi
# unzip geobounds/lpr_000b16a_e.zip -d geobounds
# ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 -s_srs EPSG:3347 geobounds/lpr_000b16a_e_4326.shp geobounds/lpr_000b16a_e.shp
```
Download and unzip Dissemination Areas Esri Shapefile.
```
# wget -P geobounds http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lda_000b16a_e.zip
# unzip geobounds/lda_000b16a_e.zip -d geobounds
# ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 -s_srs EPSG:3347 geobounds/lda_000b16a_e_4326.shp geobounds/lda_000b16a_e.shp
```
Download and unzip the Canadian Index of Multiple Deprivation (CIMD) .csv dataset.
```
# wget -P data https://www150.statcan.gc.ca/n1/en/pub/45-20-0001/2019001/csv/can_scores_quintiles-eng.zip
# unzip data/can_scores_quintiles-eng.zip -d data
```
Download and unzip the Canadian Labour force characteristics survey dataset.
```
# wget -O lfs.csv "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=1410029301&amp;latestN=5&amp;startDate=&amp;endDate=&amp;csvLocale=en&amp;selectedMembers=%5B%5B1%2C2%2C3%2C4%2C5%2C7%2C8%2C9%2C10%2C11%2C12%2C13%2C14%2C15%2C16%2C17%2C18%2C19%2C20%2C21%2C22%2C23%2C24%2C25%2C26%2C27%2C28%2C29%2C30%2C31%2C32%2C33%2C34%2C35%2C36%2C37%2C38%2C39%2C40%2C41%2C42%2C43%2C44%2C45%2C46%2C47%2C48%2C49%2C50%2C51%2C52%2C54%2C55%2C56%2C57%2C58%2C59%2C60%2C61%2C62%2C63%2C64%2C65%2C66%2C67%2C68%2C69%2C71%2C72%2C73%2C74%2C75%2C76%2C77%2C78%2C79%5D%2C%5B8%5D%2C%5B1%5D%5D&"
# mv lfs.csv data
```
Import raw data into AWS RDS.
```
# ogr2ogr -f "PostgreSQL" PG:"host=DB_HOST port=PORT user=USER dbname=DB_NAME password=PASSWORD" data/can_scores_quintiles_EN.csv -nln "can_scores_quintiles"
# ogr2ogr -f "PostgreSQL" PG:"host=DB_HOST port=PORT user=USER dbname=DB_NAME password=PASSWORD" data/lfs.csv -nln "lfs"
# shp2pgsql -W latin1 -s 3347 -g geom -I -D geobounds/ler_000b16a_e.shp ler_000b16a_e | psql --host=DB_HOST --port=PORT --username=USER --dbname=DB_NAME
# shp2pgsql -W latin1 -s 3347 -g geom -I -D geobounds/lpr_000b16a_e.shp lpr_000b16a_e | psql --host=DB_HOST --port=PORT --username=USER --dbname=DB_NAME
# shp2pgsql -W latin1 -s 3347 -g geom -I -D geobounds/lda_000b16a_e.shp lda_000b16a_e | psql --host=DB_HOST --port=PORT --username=USER --dbname=DB_NAME
```
## Preparation
Join each of the CIMD and LFC datasets with their respective STC geography boundary unique identifiers.
```
# psql --host=DB_HOST --port=PORT --username=USER --dbname=DB_NAME --password --file=/home/$USER/pilot/db-joins.sql
```
# Application Installation
## Preparation
Update the operating system, and install EPEL repository.
```
$ sudo -i
# yum update
# yum install epel-release
```
Install the required software.
```
# yum install htop mc nano wget zip unzip
```
Install Java 8.
```
# yum install java-1.8.0-openjdk.x86\_64 java-1.8.0-openjdk-devel.x86\_64
# java -version
```
## Apache Tomcat
### Installation
Download the Apache Tomcat source .zip file and unpack it.
```
# cd /home
# wget http://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-9/v9.0.39/bin/apache-tomcat-9.0.39.zip
# unzip apache-tomcat-9.0.39.zip -d /opt
```
Rename the folder to ```tomcat```.
```
# mv /opt/apache-tomcat-9.0.39.zip -d /opt
```
Set the ```CATALINA_HOME``` variable.
```
# echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.bashr
# source ~/.bashrc
```
It is not recommended to start the Apache Tomcat server as root, so we have to create a user named tomcat to start the service. We will also have to change the permissions of the /opt/tomcat directory to the new tomcat user.
```
# useradd -r tomcat --shell /bin/false
# chown -R tomcat:tomcat /opt/tomcat/
```
Create a system.d service file to start, stop and restart Apache Tomcat.
```
# nano /etc/systemd/system/tomcat.service

[Unit]
 Description=Apache Tomcat 9
 After=syslog.target network.target

[Service]
 User=tomcat
 Group=tomcat
 Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-1.amzn2.0.1.x86_64
 Environment=CATALINA_PID=/opt/tomcat/tomcat.pid
 Environment=CATALINA_HOME=/opt/tomcat
 Environment=CATALINA_BASE=/opt/tomcat
 ExecStart=/opt/tomcat/bin/startup.sh
 ExecStop=/opt/tomcat/bin/shutdown.sh
 Restart=always

[Install]
 WantedBy=multi-user.target
```
Restart systemd.
```
# systemctl daemon-reload
```
### Setup
Make the startup and shutdown scripts executable so the Tomcat service can function properly.
```
# chmod a+x /opt/tomcat/bin/startup.sh
# chmod a+x /opt/tomcat/bin/shutdown.sh
```
Install ```authbind``` so Tomcat can listen on ports 80 and 443.
```
# rpm -Uvh https://s3.amazonaws.com/aaronsilber/public/authbind-2.1.1-0.1.x86_64.rpm
# touch /etc/authbind/byport/80
# chmod 500 /etc/authbind/byport/80
# chown tomcat /etc/authbind/byport/80
# touch /etc/authbind/byport/443
# chmod 500 /etc/authbind/byport/443
# chown tomcat /etc/authbind/byport/443
```
Change the last line in ```/opt/tomcat/bin/startup.sh``` from…
```
exec "$PRGDIR"/"$EXECUTABLE" start "$@"
```
TO...
```
exec authbind --deep "$PRGDIR"/"$EXECUTABLE" start "$@"
```
```
# nano /opt/tomcat/bin/startup.sh
```
Change the ports from 8080 and 8443 to 80 and 443.
```
# nano /opt/tomcat/conf/server.xml
```
Start Tomcat and enable it to start on boot.
```
# systemctl start tomcat.service
# systemctl enable tomcat.service
```
Modify the firewall rules so the Tomcat console is accessible through the browser.
```
# firewall-cmd --zone=public --permanent --add-port=80/tcp
# firewall-cmd --zone=public --permanent --add-port=443/tcp
# firewall-cmd --reload
```
Restart Tomcat.
```
# systemctl restart tomcat
```
### Adding Tomcat Users.

In order to open the Tomcat Manager, you have to add the following lines.
```
# nano /opt/tomcat/conf/tomcat-users.xml

<role rolename="admin"/>
<role rolename="admin-gui"/> 
<role rolename="admin-script"/>
<role rolename="manager"/>
<role rolename="manager-gui"/>
<!-- <role rolename="manager-script"/> -->
<!-- <role rolename="manager-jmx"/> -->
<!-- <role rolename="manager-status"/> -->
<user name="admin" password="YOURpassword" roles="admin,manager,admin-gui,admin-script,manager-gui,manager-script,manager-jmx,manager-status" />
</tomcat-users>
```
Right now the Tomcat console page is only accessible through the host machine. To remove this, uncomment or remove the following line.
```
# nano /opt/tomcat/webapps/manager/META-INF/content.xml

<!--
<Valve className="org.apache.catalina.valves.RemoteAddrValve"
allow="127.d+.d+.d+|::1|0:0:0:0:0:0:0:1" />
-->
```
Restart Tomcat.
```
# systemctl restart tomcat
```
## Geoserver
Download the GeoServer source code and unpack it.
```
# cd /home
# wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/geoserver-2.18.0-war.zip
# unzip geoserver-2.18.0-war.zip -d /opt/geoserver
```
Transfer the geoserver.war file to the Tomcat webapps directory.
```
# mv /opt/geoserver/geoserver.war /opt/tomcat/webapps/geoserver.war
```
Restart Tomcat
```
# systemctl restart tomcat
```
GeoServer should now be accessible at ```http://localhost/geoserver/web```.
