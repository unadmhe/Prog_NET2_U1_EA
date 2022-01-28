# Builds a Docker image with Ubuntu, mysql-server and mysql-workbench
# and some graphic tools.
#

FROM dorowu/ubuntu-desktop-lxde-vnc:latest

USER root
WORKDIR /tmp

ENV MYSQL_USER=mysql \
    MYSQL_VERSION=8.0.1 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql \
	DOCKER_HOME=/root

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
	bison \
	flex \
	geany \
	dos2unix \
	build-essential \
	xterm \
	default-jdk \
	nginx \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*
 
COPY entrypoint.sh /sbin/entrypoint.sh
RUN dos2unix /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3306/tcp

USER $DOCKER_USER

RUN echo "[program:xterm]" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "priority=15" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "directory=/root" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "command=/usr/bin/xterm -e '/root/shared/run.sh'" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "user=root" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "stopwaitsecs=10" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo 'environment=DISPLAY=":1",HOME="/root",USER="root"' >> /etc/supervisor/conf.d/supervisord.conf

USER root

WORKDIR $DOCKER_HOME
