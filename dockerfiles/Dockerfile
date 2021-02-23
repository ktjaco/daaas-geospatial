FROM kartoza/geoserver:latest

USER root

COPY . /daaas-geo

WORKDIR /daaas-geo

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/extensions/geoserver-2.18.0-wps-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/extensions/geoserver-2.18.0-csw-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.0/extensions/geoserver-2.18.0-vectortiles-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-wps-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-csw-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.0-vectortiles-plugin.zip
