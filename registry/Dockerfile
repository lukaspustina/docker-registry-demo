# Dockerfile for Docker Registry
# derived from https://github.com/dotcloud/docker-registry/blob/master/Dockerfile
# Version 1.0
FROM docker-registry-demo/base

MAINTAINER Lukas Pustina <lukas.pustina@centerdevice.com>

ADD docker-registry /docker-registry
ADD config.yml /etc/docker/

RUN apt-get install -y git-core build-essential python-dev libevent1-dev python-openssl liblzma-dev wget; rm /var/lib/apt/lists/*_*
RUN cd /tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN cd /tmp; python ez_setup.py; easy_install pip; rm ez_setup.py

RUN cd /docker-registry && pip install -r requirements.txt

VOLUME /docker-registry-storage
EXPOSE 5000

CMD cd /docker-registry; SETTINGS_FLAVOR=demo DOCKER_REGISTRY_CONFIG=/etc/docker/config.yml gunicorn -k gevent -b 0.0.0.0:5000 --max-requests 100 --graceful-timeout 3600 -t 3600 -w 8 wsgi:application

