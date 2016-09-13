# Build a version of Ubuntu 14.04 with all necessary runtime files for 
# geospatial system.
FROM httpd:2.4

RUN apt-get update
RUN apt-get install -y autoconf libtool apache2-dev unzip libmapnik-dev 

RUN mkdir -p ~/src
COPY ./mod_tile-master.zip /tmp/mod_tile-master.zip
RUN cd ~/src && unzip /tmp/mod_tile-master.zip
RUN rm /tmp/mod_tile-master.zip
RUN cd ~/src/mod_tile-master && ./autogen.sh
RUN cd ~/src/mod_tile-master && ./configure
RUN cd ~/src/mod_tile-master && make install install-mod_tile
RUN ldconfig

COPY ./renderd.conf /usr/local/etc/renderd.conf
COPY ./httpd.conf /usr/local/apache2/conf
