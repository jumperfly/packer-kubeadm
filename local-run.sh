#!/bin/bash
vagrant destroy
if [[ -d "$HOME/.vagrant.d/boxes/file:-VAGRANTSLASH--VAGRANTSLASH-output-kubeadm-VAGRANTSLASH-package.box" ]]; then
  vagrant box remove file://output-kubeadm/package.box
fi
vagrant up
