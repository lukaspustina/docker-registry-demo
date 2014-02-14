# Docker Demo #

This demo gives an introduction on how to set up and use a private [Docker][docker] registry. Please see my [blog post][cc-blog] for details. 

The demo works in two steps. In step one, a registry and two Python images for Python 2.7 and 3.3 are build and pushed to a registry running as a Docker container. In a step two, these Python images are pulled and run. The demo is controlled by a `Makefile`. Please have a look at this `Makefile` to see the different Docker commands used. 

The Docker image for the registry is production-ready and we use it at [CenterDevice][centerdevice]. You can use it for your own private Docker registry. Please have a look at the config template `registry/config.yml.template` and the `Makefile` target `start-registry` to customize the registry to your needs. The storage backend is set for flat files. We use S3. If you want to change the storage backend, add another flavor as described [here][docker-registry] and set the environment variable `SETTINGS_FLAVOR` in the `CMD` line in `registry/Dockerfile` accordingly.

Have fun with lightweight virtual machines made simple with Docker and feel free to contact me for any questions or comments.

## Prerequisites ##

Docker builds upon [Linux Containers][lxc] (LXC) and thus only runs on Linux. In order to allow you to also play with Docker on non-Linux machines, there are two ways to run this demo, i.e., inside a [Vagrant Box][vagrant] or directly on Linux. Please see the respective subsections below. For both cases you need to install `make`.

### Vagrant Box ###

If you decide to run the demo inside a Vagrant box, please install Vagrant accordingly. The Vagrantfile provided requires Vagrant version 1.4.0 or higher, because starting from that version Docker can be automatically installed. As provider, VirtualBox is assumed. Once Vagrant is installed, just run
> `vagrant up; vagrant ssh`   
> `cd /vagrant`

in the root directory. Then follow the same instructions as for native Linux.

### Native Linux  ###

If you decide to run the demo on a native Linux, please install Docker according to your distribution. There are How-Tos for many different distributions in the Docker [documentation][docker-install-doc].

## Running the Demo ##

### 1. Build Images ###

In the first step, a Docker image for a private registry is built. The configuration file is generated from the template `registry/config.yml.template`. openssl and sed generate and insert an individual `secret_key` and create a config file. In addition, two Python images for the versions 2.7 and 3.3 are created and used as example images to push to and pull from the registry.
> `make build`

### 2. Run Demo ###

In order to run the demo, run
> `make demo`

### 3. Clean ###

To clean up, run
> `make clean`

[docker]: http://docker.io
[centerdevice]: http://www.centerdevice.com
[cc-blog]: blog
[lxc]: http://linuxcontainers.org/
[vagrant]: http://www.vagrantup.com
[docker-install-doc]: http://docs.docker.io/en/latest/installation/
[docker-registry]: https://github.com/dotcloud/docker-registry

