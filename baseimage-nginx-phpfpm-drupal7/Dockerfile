FROM that0n3guy/baseimage-nginx-phpfpm:latest
MAINTAINER Peter Olson <that0n3guy@users.noreply.github.com>

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN mv /etc/nginx /etc/nginx.old
RUN git clone https://github.com/perusio/drupal-with-nginx.git /etc/nginx
RUN cd /etc/nginx && git checkout D7

# add nginx_ensite for easy use.
RUN git clone https://github.com/perusio/nginx_ensite.git /root/nginx_ensite
RUN cp /root/nginx_ensite/nginx_* /usr/sbin

EXPOSE 80
WORKDIR /app
CMD ["/sbin/my_init"]