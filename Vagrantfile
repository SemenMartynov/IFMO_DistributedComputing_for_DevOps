
Vagrant.configure("2") do |config|
    ssh_public_key = File.read(File.expand_path("~/.ssh/demokey.pub"))

    config.vm.define "vm1" do |vm1|
      vm1.vm.box = "bento/ubuntu-24.04"
      vm1.vm.box_version = "202502.21.0"
      vm1.vm.network "private_network", ip: "192.168.56.10"
      vm1.vm.provider "virtualbox" do |vb|
        vb.name = "ubuntu-vm1"
        vb.memory = 8192
        vb.cpus = 2
      end

      #vm1.vm.provision "shell", inline: <<-SHELL
      #  sudo mkdir -p /home/vagrant/.ssh
      #  sudo echo "#{ssh_public_key}" > /home/vagrant/.ssh/authorized_keys
      #
      #  sudo systemctl restart ssh
      #SHELL
    end

    #config.vm.define "vm2" do |vm2|
    #  vm2.vm.box = "bento/ubuntu-24.04"
    #  vm2.vm.box_version = "202502.21.0"
    #  vm2.vm.network "private_network", ip: "192.168.56.11"
    #  vm2.vm.provider "virtualbox" do |vb|
    #    vb.name = "ubuntu-vm2"
    #    vb.memory = 2048
    #    vb.cpus = 2
    #  end
    #
    #  vm2.vm.provision "shell", inline: <<-SHELL
    #   sudo mkdir -p /home/vagrant/.ssh
    #   sudo echo "#{ssh_public_key}" > /home/vagrant/.ssh/authorized_keys
    #
    #   sudo systemctl restart ssh
    #SHELL
    #end
  
  end
  