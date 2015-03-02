#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
# this forces dpkg not to call sync() after package extraction and speeds up install
echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need an apt cache in a container
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

apt-get update && \
    apt-get --no-install-recommends -yq install \
        curl \
        nginx-extras \
        git \
        php5-fpm \
        php5-mysql \
        php5-imagick \
        php5-mcrypt \
        php5-curl \
        php5-cli \
        php5-memcache \
        php5-intl \
        php5-gd \
        php5-xdebug \
        php5-gd \
        php5-mongo \
        php5-imap \
        php5-redis \
        php-pear \
        unzip \
        php-apc && \
    rm -rf /var/lib/apt/lists/*

php5enmod imap

# Cleanup
apt-get clean
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
find /tmp /var/tmp -mindepth 2 -delete
