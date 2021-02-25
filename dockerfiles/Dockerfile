FROM kartoza/geoserver:2.18.0

USER root

WORKDIR /tmp

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/extensions/geoserver-2.18.2-wps-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \ 
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/extensions/geoserver-2.18.2-csw-plugin.zip

RUN wget -P /usr/local/tomcat/webapps/geoserver/WEB-INF/lib \
    https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/extensions/geoserver-2.18.2-vectortiles-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.2-wps-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.2-csw-plugin.zip

RUN unzip -o /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/geoserver-2.18.2-vectortiles-plugin.zip
