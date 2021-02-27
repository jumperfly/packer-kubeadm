source "vagrant" "kubeadm" {
  provider = "virtualbox"
  source_path = "jumperfly/centos-7"
  box_version = "7.9.17"
  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "vagrant"
}

build {
  name = "kubeadm"
  sources = ["sources.vagrant.kubeadm"]
  provisioner "file" {
    source = "kubernetes.repo"
    destination = "/etc/yum.repos.d/kubernetes.repo"
  }
  provisioner "file" {
    source = "cloud-init-seed"
    destination = "/var/lib/cloud/seed"
  }
  provisioner "shell" {
    script = "provision.sh"
    environment_vars = [
      "CONTAINERD_VERSION=${var.containerd_version}",
      "KUBE_VERSION=${var.kube_version}",
      "FLANNEL_VERSION=${var.flannel_version}"
    ]
  }
  provisioner "shell" {
    script = "cleanup.sh"
    environment_vars = ["PACKER_SKIP_SHRINK_DISK=${var.skip_shrink}"]
  }
  post-processor "vagrant-cloud" {
    box_tag = "jumperfly/kubeadm"
    version = "${var.box_version_major_minor}.${var.build_number}"
  }
}
