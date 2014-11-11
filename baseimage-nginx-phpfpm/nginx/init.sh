#!/bin/sh

# Use the TZ environment variable, otherwise use UTC
NGINX_DOCROOT="/app"
if [ -n "${DOCROOT}" ]
then
    NGINX_DOCROOT="$DOCROOT"
fi

sed -i "s#root .*;#root $NGINX_DOCROOT;#" /etc/nginx/sites-enabled/default
mkdir -p $NGINX_DOCROOT

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
