#!/bin/sh
# Configure logentries to start as a service
mkdir /etc/service/logentries
cp -a /app/.docker/logentries/runit.sh /etc/service/logentries/run
chmod +x /etc/service/logentries/run

# Install logentries
export DEBIAN_FRONTEND=noninteractive
# this forces dpkg not to call sync() after package extraction and speeds up install
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need an apt cache in a container
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

echo 'deb http://rep.logentries.com/ trusty main' > /etc/apt/sources.list.d/logentries.list
gpg --keyserver pgp.mit.edu --recv-keys C43C79AD && gpg -a --export C43C79AD | apt-key add -

apt-get update && \
    apt-get --no-install-recommends -yq install logentries php5-mongo && \
        rm -rf /var/lib/apt/lists/*

# Cleanup
apt-get clean
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
find /tmp /var/tmp -mindepth 2 -delete


# stop log entries... don't start it at start.  We will use runit for this.
service logentries stop
update-rc.d logentries disable

# add our startup script that will copy them back after mounting.
cp -a /build/logentries/init.sh /etc/my_init.d/00_logentries.sh
chmod +x /etc/my_init.d/00_logentries.sh