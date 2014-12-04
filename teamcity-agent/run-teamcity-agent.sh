#!/bin/sh
exec ${TEAM_CITY_INSTALL_DIR}TeamCity/bin/teamcity-server.sh run >>/var/log/teamcity-server.log 2>&1