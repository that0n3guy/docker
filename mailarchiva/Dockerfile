####################################
# Ubuntu Baseimage MailArchiva Docker Image
# @todo: run this with: docker run -dt --name teamcity_server -p 8090:8090 that0n3guy/docker-teamcity-server
# @todo: build this with: docker build -t teamcity-server .
####################################

FROM phusion/baseimage:0.9.13

ENV MAILARCHIVA_BASE_URL https://mailarchiva.com/download?id=440             
# ENV MAILARCHIVA_FILENAME mailarchiva_server_linux_v3.10.11.tar.gz
# ENV MAILARCHIVA_FTP_USERNAME enterprise
# ENV MAILARCHIVA_FTP_PASSWORD fl0w3r
# mailarchiva_server_linux_v3.10.11.tar.gz
ENV MAILARCHIVA_INSTALL_DIR /opt/
ENV MYSQL_JDBC_PACKAGE mysql-connector-java-5.1.32

# MAILARCHIVA uses this env var to define the datapath
ENV MAILARCHIVA_DATA_PATH /opt/mailarchiva-data

# this is based on http://phusion.github.io/baseimage-docker/
CMD ["/sbin/my_init"]


## update apt and install jre
RUN apt-get update
RUN apt-get install -y wget default-jre

# Get the teamcity package and extract it.
RUN wget -q -O - $MAILARCHIVA_BASE_URL | tar xzf - -C $MAILARCHIVA_INSTALL_DIR
RUN mv $MAILARCHIVA_INSTALL_DIR/mailarchiva* $MAILARCHIVA_INSTALL_DIR/mailarchiva

# Get the jdbc drivers for mysql and mv it to the right location
# RUN mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc
# RUN wget -q -O - http://dev.mysql.com/get/Downloads/Connector-J/$MYSQL_JDBC_PACKAGE.tar.gz | tar xzf - -C $TEAMCITY_DATA_PATH/lib/jdbc/
# RUN mv $TEAMCITY_DATA_PATH/lib/jdbc/$MYSQL_JDBC_PACKAGE/$MYSQL_JDBC_PACKAGE-bin.jar $TEAMCITY_DATA_PATH/lib/jdbc
# RUN rm -r $TEAMCITY_DATA_PATH/lib/jdbc/$MYSQL_JDBC_PACKAGE

# setup runit to run teamcity on startup
# RUN mkdir /etc/service/teamcity-server
# ADD run-teamcity-server.sh /etc/service/teamcity-server/run
# RUN chmod +x /etc/service/teamcity-server/run

EXPOSE 8090 # web
EXPOSE 8091 # ??

# this isn't needed:
# CMD .$TEAM_CITY_INSTALL_DIR/TeamCity/bin/teamcity-server.sh run

VOLUME ["/opt/mailarchiva/ROOT"]