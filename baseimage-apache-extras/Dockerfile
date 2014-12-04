FROM that0n3guy/baseimage-apache:latest
MAINTAINER Peter Olson <that0n3guy@users.noreply.github.com>

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# run our nginx setup script
RUN bash /app/.docker/logentries/setup.sh

EXPOSE 80
WORKDIR /app
CMD ["/sbin/my_init"]