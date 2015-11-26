#!/bin/sh
# move the jdbc to the correct location
#if [ ! -f "$TEAMCITY_DATA_PATH/lib/jdbc/$MYSQL_JDBC_PACKAGE-bin.jar" ];
#then
  mv /opt/$MYSQL_JDBC_PACKAGE/$MYSQL_JDBC_PACKAGE-bin.jar $TEAMCITY_DATA_PATH/lib/jdbc
#fi
exec ${TEAM_CITY_INSTALL_DIR}TeamCity/bin/teamcity-server.sh run >>/var/log/teamcity-server.log 2>&1
