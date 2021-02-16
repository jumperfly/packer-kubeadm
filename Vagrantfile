# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.box = "file://output-kubeadm/package.box"
  config.vm.provision "shell", inline: "kubeadm version"
end
