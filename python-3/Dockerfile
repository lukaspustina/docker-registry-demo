# Dockerfile for python 3
# Version 1.0
FROM docker-registry-demo/base

MAINTAINER Lukas Pustina <lukas.pustina@centerdevice.com>

RUN apt-get install -y python3

CMD /usr/bin/python3 -c "import platform; print('Python version is', platform.python_version())"

