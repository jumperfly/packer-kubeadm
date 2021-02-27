# -*- mode: ruby -*-
# vi: set ft=ruby :

$node_memory = 2048
$ip_prefix = "192.168.99"
$kubeadm_token = "h12d0m.gxam1ml6jyrq41ca"

Vagrant.configure("2") do |config|
  config.vm.box = "./output-kubeadm/package.box"
  config.vm.box_check_update = false
  config.ssh.insert_key = false
  config.vm.provider "virtualbox" do |v|
    v.memory = $node_memory
    v.cpus = 2
  end

  (1..2).each do |i|
    config.vm.define vm_name = "node#{i}" do |config|
      config.vm.hostname = vm_name
      ip = "#{$ip_prefix}.10#{i}"
      config.vm.network "private_network", ip: ip

      cloud_init_meta_data = {
        "ds" => "nocloud",
        "kubeadm_node_name" => vm_name,
        "kubeadm_token" => $kubeadm_token
      }
      if i == 1
        config.vm.box = "./output-kubeadm-master/package.box"
        cloud_init_meta_data["kubeadm_apiserver_advertise_address"] = "#{ip}"
        cloud_init_meta_data["flannel_iface"] = "eth1"
      else
        cloud_init_meta_data["kubeadm_master"] = "#{$ip_prefix}.101:6443"
      end
      cloud_init_meta_data_str = cloud_init_meta_data.map{|k,v| "#{k}=#{v}"}.join(";")
      config.vm.provider "virtualbox" do |v|
        v.customize ["setextradata", :id, "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial", cloud_init_meta_data_str]
      end

      config.vm.provision "shell", inline: <<-SHELL
        echo 'KUBELET_EXTRA_ARGS=--node-ip #{ip}' > /etc/sysconfig/kubelet
        systemctl restart kubelet
      SHELL
    end
  end

end
