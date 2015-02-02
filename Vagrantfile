# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">= 1.4.0"

BOX_NAME = "docker-registry-demo"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define BOX_NAME do |t| end

  config.vm.hostname = "#{BOX_NAME}.localdomain"
  config.vm.provider :virtualbox do |vbox|
    vbox.name = BOX_NAME
    vbox.memory = 1024
  end

  config.vm.provision :shell, :inline => "mkdir -p /var/lib/cloud/instance; touch /var/lib/cloud/instance/locale-check.skip"
  config.vm.provision :shell, :inline => "curl -sSL https://get.docker.com/ubuntu/ | sudo sh"
  config.vm.provision :shell, :inline => "apt-get install -y git"
end

