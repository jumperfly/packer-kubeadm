variable "build_number" {
  type = number
}

variable "skip_shrink" {
  type = string
  default = ""
}

variable "containerd_version" {
  type = string
  default = "1.4.3"
}

variable "kube_version" {
  type = string
  default = "1.20.2"
}

variable "box_version_major_minor" {
  type = string
  default = "0.1"
}

source "vagrant" "kubeadm" {
  provider = "virtualbox"
  source_path = "jumperfly/centos-7"
  box_version = "7.9.16"
  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "vagrant"
}

build {
  sources = ["sources.vagrant.kubeadm"]
  provisioner "file" {
    source = "kubernetes.repo"
    destination = "/etc/yum.repos.d/kubernetes.repo"
  }
  provisioner "shell" {
    script = "provision.sh"
    environment_vars = [
      "PACKER_SKIP_SHRINK_DISK=${var.skip_shrink}",
      "CONTAINERD_VERSION=${var.containerd_version}",
      "KUBE_VERSION=${var.kube_version}"
    ]
  }
  post-processor "vagrant-cloud" {
    box_tag = "jumperfly/kubeadm"
    version = "${var.box_version_major_minor}.${var.build_number}"
  }
}
