#!/bin/bash
rm -rf output*
if [[ -d "$HOME/.vagrant.d/boxes/.-VAGRANTSLASH-output-kubeadm-VAGRANTSLASH-package.box" ]]; then
  vagrant box remove ./output-kubeadm/package.box
fi
if [[ -d "$HOME/.vagrant.d/boxes/.-VAGRANTSLASH-output-kubeadm-master-VAGRANTSLASH-package.box" ]]; then
  vagrant box remove ./output-kubeadm-master/package.box
fi
packer build -except 'vagrant-cloud,kubeadm-master.*' -var build_number=0 -var skip_shrink=1 .
packer build -except 'vagrant-cloud,kubeadm.*' -var build_number=0 -var skip_shrink=1 .
