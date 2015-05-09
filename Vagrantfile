# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "2048"]
	 vb.name = "vagrant-box"
  end

  config.vm.network "private_network", type: "dhcp"
  config.vm.provision :shell, :path => "bootstrap.sh"

  require 'rbconfig'
  is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

  if is_windows
   config.vm.network "forwarded_port", guest: 80, host: 80
   config.vm.network "forwarded_port", guest: 443, host: 443
   config.vm.synced_folder "./", "/vagrant"
  end
  if !is_windows
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 443, host: 8443
    config.vm.synced_folder "../", "/var/www/html", type: "nfs"
    config.vm.synced_folder "./", "/vagrant", type: "nfs"
  end

  config.vm.network "forwarded_port", guest: 3306, host: 8306
end
