#!/bin/bash
vagrant destroy
if [[ -d "$HOME/.vagrant.d/boxes/.-VAGRANTSLASH-output-kubeadm-VAGRANTSLASH-package.box" ]]; then
  vagrant box remove ./output-kubeadm/package.box
fi
vagrant up
