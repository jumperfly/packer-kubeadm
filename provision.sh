#!/bin/bash

# Configure network
systemctl disable firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
echo 'br_netfilter' > /etc/modules-load.d/containerd.conf
echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/50-kubernetes.conf
echo 'net.bridge.bridge-nf-call-iptables=1' >> /etc/sysctl.d/50-kubernetes.conf

# Install packages
curl -o /etc/yum.repos.d/docker.repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install containerd.io-$CONTAINERD_VERSION
yum -y install kubelet-$KUBE_VERSION kubeadm-$KUBE_VERSION kubectl-$KUBE_VERSION --disableexcludes=kubernetes

# Enable containerd cri plugin and enable service
sed -i 's/disabled_plugins = \["cri"\]//' /etc/containerd/config.toml

# Enable services
systemctl enable containerd
systemctl enable kubelet
