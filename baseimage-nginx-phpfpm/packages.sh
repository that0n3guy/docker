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
        php7.0-fpm \
        php7.0-mysql \
        php7.0-imagick \
        php7.0-mcrypt \
        php7.0-curl \
        php7.0-cli \
        php7.0-memcache \
        php7.0-intl \
        php7.0-gd \
        php7.0-mongo \
        php7.0-imap \
        php7.0-redis \
        php-pear \
        unzip \
        php-apc && \
    rm -rf /var/lib/apt/lists/*

phpenmod imap

# Cleanup
apt-get clean
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
find /tmp /var/tmp -mindepth 2 -delete
