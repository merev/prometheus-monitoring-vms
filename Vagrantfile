# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 1024
    v.cpus = 1
  end
  
  # Prometheus Host (Debian 11)
  config.vm.define "vm1" do |vm1|
    vm1.vm.box = "merev/debian-11"
    vm1.vm.hostname = "prom.lab"
    vm1.vm.network "private_network", ip: "192.168.99.100"
    vm1.vm.synced_folder "shared/", "/shared"
    vm1.vm.provision "shell", path: "initial-config/add_hosts.sh"
    vm1.vm.provision "shell", path: "initial-config/prometheus_install.sh"
    vm1.vm.provision "shell", path: "initial-config/node_exporter_install.sh"
    vm1.vm.provision "shell", path: "initial-config/grafana_install.sh"
    vm1.vm.provision "shell", path: "initial-config/grafana_setup.sh"
  end

  # Docker Host (Debian 11)
  config.vm.define "vm2" do |vm2|
    vm2.vm.box = "merev/debian-11"
    vm2.vm.hostname = "docker.lab"
    vm2.vm.network "private_network", ip: "192.168.99.101"
    vm2.vm.synced_folder "shared/", "/shared"
    vm2.vm.provision "shell", path: "initial-config/add_hosts.sh"
    vm2.vm.provision "shell", path: "initial-config/docker_install.sh"
    vm2.vm.provision "shell", path: "initial-config/node_exporter_install.sh"
    vm2.vm.provision "shell", path: "initial-config/test_containers_run.sh"
  end

end
