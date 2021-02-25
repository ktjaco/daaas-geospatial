<<<<<<< HEAD
FROM kartoza/geoserver:2.18.0

USER root

=======
FROM kartoza/geoserver:2.18.2

USER root

#COPY . /daaas-geo

WORKDIR /tmp

>>>>>>> 1b21c3f81124a458ac13de616f11cd6b904334f1
RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/extensions/geoserver-2.18.2-wps-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/extensions/geoserver-2.18.2-csw-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/extensions/geoserver-2.18.2-vectortiles-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.2-wps-plugin.zip

<<<<<<< HEAD
RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://build.geoserver.org/geoserver/2.18.x/community-2021-02-23/geoserver-2.18-SNAPSHOT-cog-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://build.geoserver.org/geoserver/2.18.x/community-2021-02-23/geoserver-2.18-SNAPSHOT-s3-geotiff-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-wps-plugin.zip
=======
RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.2-csw-plugin.zip
>>>>>>> 1b21c3f81124a458ac13de616f11cd6b904334f1

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.2-vectortiles-plugin.zip

<<<<<<< HEAD
RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-vectortiles-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18-SNAPSHOT-cog-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18-SNAPSHOT-s3-geotiff-plugin.zip    
=======
>>>>>>> 1b21c3f81124a458ac13de616f11cd6b904334f1
