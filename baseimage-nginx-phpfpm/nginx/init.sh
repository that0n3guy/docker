#!/bin/sh

# Use the TZ environment variable, otherwise use UTC
NGINX_DOCROOT="/app"
if [ -n "${DOCROOT}" ]
then
    NGINX_DOCROOT="$DOCROOT"
fi

DEFAULT_FILE="/etc/nginx/sites-enabled/default"
if [ -f $DEFAULT_FILE ]; then
    sed -i "s#root .*;#root $NGINX_DOCROOT;#" /etc/nginx/sites-enabled/default
fi

mkdir -p $NGINX_DOCROOT

if [ -n "$SYNC_UID" ]; then
    if [ $SYNC_UID -eq 1 ]
    then
        uid=`stat -c '%u' $DOCROOT`
        gid=`stat -c '%g' $DOCROOT`

        echo "Updating www-data ids to ($uid:$gid)"

        if [ ! $uid -eq 0 ]
        then
            sed -i "s#^www-data:x:.*:.*:#www-data:x:$uid:$gid:#" /etc/passwd
        fi

        if [ ! $gid -eq 0 ]
        then
            sed -i "s#^www-data:x:.*:#www-data:x:$gid:#" /etc/group
        fi

        chown www-data /var/log/nginx
    fi
fi