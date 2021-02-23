FROM kartoza/geoserver:2.18.0

USER root

COPY . /daaas-geo

WORKDIR /daaas-geo

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/extensions/geoserver-2.18.0-wps-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/extensions/geoserver-2.18.0-csw-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/extensions/geoserver-2.18.0-vectortiles-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://build.geoserver.org/geoserver/2.18.x/community-2021-02-23/geoserver-2.18-SNAPSHOT-cog-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://build.geoserver.org/geoserver/2.18.x/community-2021-02-23/geoserver-2.18-SNAPSHOT-s3-geotiff-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-wps-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-csw-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-vectortiles-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18-SNAPSHOT-cog-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18-SNAPSHOT-s3-geotiff-plugin.zip    
