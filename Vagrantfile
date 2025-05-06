# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "alvistack/ubuntu-24.04"
    config.vm.hostname = "ubuntu2404-dev"
    config.vm.network "private_network", type: "dhcp"

    config.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 4

end
config.vm.provision "shell", inline: <<-SHELL
    adduser --disabled-password --gecos "" user
    usermod -aG sudo user
  SHELL

  config.vm.provision "file",
    source: "~/.ssh/r-devops-magistracy-114284314.pub",
    destination: "/tmp/id.pub"

  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /home/user/.ssh
    cat /tmp/id.pub >> /home/user/.ssh/authorized_keys
    chown -R user:user /home/user/.ssh
    chmod 600 /home/user/.ssh/authorized_keys
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99_user_nopasswd
    chmod 440 /etc/sudoers.d/99_user_nopasswd
  SHELL
end