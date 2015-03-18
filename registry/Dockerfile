# Dockerfile for Docker Registry
# derived from https://github.com/dotcloud/docker-registry/blob/master/Dockerfile
# Version 1.0
FROM registry

MAINTAINER Lukas Pustina <lukas.pustina@codecentric.de>

ADD config.yml /etc/docker-registry/

VOLUME /docker-registry-storage

ENV DOCKER_REGISTRY_CONFIG /etc/docker-registry/config.yml
ENV SETTINGS_FLAVOR demo

ENV GUNICORN_WORKERS 8
ENV GUNICORN_GRACEFUL_TIMEOUT 3600
ENV GUNICORN_SILENT_TIMEOUT 3600

CMD ["docker-registry"]

