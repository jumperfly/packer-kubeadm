source "vagrant" "kubeadm-master" {
  provider = "virtualbox"
  source_path = "./output-kubeadm/package.box"
  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "vagrant"
}

build {
  name = "kubeadm-master"
  sources = ["sources.vagrant.kubeadm-master"]
  provisioner "shell" {
    inline = ["kubeadm config images pull"]
  }
  provisioner "shell" {
    script = "cleanup.sh"
    environment_vars = ["PACKER_SKIP_SHRINK_DISK=${var.skip_shrink}"]
  }
  post-processor "vagrant-cloud" {
    box_tag = "jumperfly/kubeadm-master"
    version = "${var.box_version_major_minor}.${var.build_number}"
  }
}
