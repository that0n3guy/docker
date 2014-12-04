#!/bin/sh
sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

# Configure apache (docroot and front controller) on startup
cp -a /build/apache/init.sh /etc/my_init.d/00_configure_apache.sh
chmod +x /etc/my_init.d/00_configure_apache.sh

# Configure apache to start as a service
mkdir /etc/service/apache
cp -a /build/apache/runit.sh /etc/service/apache/run
chmod +x /etc/service/apache/run
