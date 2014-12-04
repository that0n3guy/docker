#!/bin/sh

# Use the TZ environment variable, otherwise use UTC
APACHE_DOCROOT="/app"
if [ -n "${DOCROOT}" ]
then
    APACHE_DOCROOT="$DOCROOT"
fi

mkdir -p $APACHE_DOCROOT

if [ $SYNC_UID -eq 1 ]
then
    uid=`stat -c '%u' $APACHE_DOCROOT`
    gid=`stat -c '%g' $APACHE_DOCROOT`
    
    echo "Updating www-data ids to ($uid:$gid)"

    if [ ! $uid -eq 0 ]
    then
        sed -i "s#^www-data:x:.*:.*:#www-data:x:$uid:$gid:#" /etc/passwd
    fi

    if [ ! $gid -eq 0 ]
    then
        sed -i "s#^www-data:x:.*:#www-data:x:$gid:#" /etc/group
    fi

    chown www-data /var/log/apache2
fi
