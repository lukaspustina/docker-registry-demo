USERNAME=lukaspustina
REGISTRY=localhost:5000
REGISTRY_VERSION=0.9.1

.PHONY: base registry/docker-registry registry run-registry python-2 python-3 pull run-python-2 run-python-3

all:
	@echo "make build -- build docker images"
	@echo "make demo -- demos pull and and runs pulled python containers"
	@echo ""
	@echo "make start-registry -- starts registry"
	@echo "make pull -- pulls python images from registry"
	@echo "make run-python-2 -- run python 2 image"
	@echo "make run-python-3 -- run python 3 image"
	@echo "make stop-registry -- stops registry"
	@echo "make clean -- removes containers, images, and downloads"

build: base registry start-registry python-2 python-3 build-clean stop-registry
	docker images

registry: registry/config.yml registry/docker-registry
	docker build --rm -t $(USERNAME)/$@ $@

registry/config.yml:
	cat $@.template | sed "s/@@SEC_KEY@@/`openssl rand -hex 32`/" > $@

registry/docker-registry:
	-git clone https://github.com/dotcloud/docker-registry.git $@
	cd $@; git checkout master
	cd $@; git pull --rebase
	cd $@; git checkout $(REGISTRY_VERSION)
	cd $@; docker build --rm -t docker/docker-registry .

base:
	docker build --rm -t $(USERNAME)/$@ $@

start-registry: registry/docker-registry-storage
	docker run --name registry -d -p 5000:5000 -v `pwd`/registry/docker-registry-storage:/docker-registry-storage $(USERNAME)/registry
	-@sleep 2

registry/docker-registry-storage:
	mkdir $@

stop-registry:
	docker kill registry
	docker rm registry

python-2:
	docker build --rm -t $(USERNAME)/python $@
	docker tag -f $(USERNAME)/python $(USERNAME)/python:$@
	docker tag -f $(USERNAME)/python $(REGISTRY)/python:$@
	docker push $(REGISTRY)/python

python-3:
	docker build --rm -t $(USERNAME)/python $@
	docker tag -f $(USERNAME)/python $(USERNAME)/python:$@
	docker tag -f $(USERNAME)/python $(REGISTRY)/python:$@
	docker push $(REGISTRY)/python

build-clean:
	-@docker ps -a | xargs docker rm > /dev/null 2>&1
	-@docker images | grep 'python\|none' | awk '{print $$1}' | xargs docker rmi > /dev/null 2>&1
	-@docker images | grep 'python\|none' | awk '{print $$3}' | xargs docker rmi > /dev/null 2>&1

demo: start-registry pull run-python-2 run-python-3 stop-registry

pull:
	docker pull $(REGISTRY)/python:python-2
	docker pull $(REGISTRY)/python:python-3
	docker images

run-python-2:
	docker run localhost:5000/python:python-2

run-python-3:
	docker run localhost:5000/python:python-3

clean: clean-images clean-downloads clean-registry-storage

clean-images:
	-@docker ps -a -q | xargs docker rm > /dev/null 2>&1
	-@docker images -a -q | xargs docker rmi > /dev/null 2>&1

clean-downloads:
	-@rm -rf registry/docker-registry

clean-registry-storage:
	rm -rf registry/docker-registry-storage

