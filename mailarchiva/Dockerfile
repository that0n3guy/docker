####################################
# Ubuntu Baseimage MailArchiva Docker Image
# @todo: run this with: docker run -dt --name teamcity_server -p 8090:8090 that0n3guy/docker-teamcity-server
# @todo: build this with: docker build -t teamcity-server .
####################################

FROM phusion/baseimage:0.9.13

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

ENV MAILARCHIVA_BASE_URL https://mailarchiva.com/download?id=440             
ENV MAILARCHIVA_INSTALL_DIR /opt/
ENV MAILARCHIVA_HEAP_SIZE 1024m

# ENV MYSQL_JDBC_PACKAGE mysql-connector-java-5.1.32
# MAILARCHIVA uses this env var to define the datapath
ENV MAILARCHIVA_DATA_PATH /opt/mailarchiva-data

# this is based on http://phusion.github.io/baseimage-docker/
CMD ["/sbin/my_init"]


## update apt and install jre
RUN apt-get update
RUN apt-get install -y expect
# RUN apt-get install -y wget default-jre

# Get the teamcity package and extract it.
RUN wget -q -O - $MAILARCHIVA_BASE_URL | tar xzf - -C $MAILARCHIVA_INSTALL_DIR
RUN mv $MAILARCHIVA_INSTALL_DIR/mailarchiva* $MAILARCHIVA_INSTALL_DIR/mailarchiva

# Install mailarchiva - use expect to automate the interactive install
ADD expect-install $MAILARCHIVA_INSTALL_DIR/mailarchiva
RUN expect $MAILARCHIVA_INSTALL_DIR/mailarchiva/expect-install

# setup runit to run mailarchiva on startup
RUN mkdir /etc/service/mailarchiva
ADD run-mailarchiva.sh /etc/service/mailarchiva/run
RUN chmod +x /etc/service/mailarchiva/run

# web
EXPOSE 8090
#smtp
EXPOSE 8091
#milter - I don't think this is needed.
#EXPOSE 8092

VOLUME ["/opt/mailarchiva/ROOT"]

# RUN apt-get remove -yf expect... leave this hear for easy updates? 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*