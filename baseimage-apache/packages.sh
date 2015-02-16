#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
# this forces dpkg not to call sync() after package extraction and speeds up install
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need an apt cache in a container
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

apt-get update && \
    apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-gd \
        php5-curl \
        php-pear \
        php5-imap \
        unzip \
        php-apc && \
    rm -rf /var/lib/apt/lists/*

php5enmod imap

# Cleanup
apt-get clean
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
find /tmp /var/tmp -mindepth 2 -delete
