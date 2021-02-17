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

variable "kubeadm_box" {
  type = string
  default = "./output-kubeadm/package.box"
}
