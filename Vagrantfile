
Vagrant.configure("2") do |config|
    ssh_public_key = File.read(File.expand_path("~/.ssh/demokey.pub"))

    config.vm.define "vm1" do |vm1|
      vm1.vm.box = "net9/ubuntu-24.04-arm64"
      vm1.vm.network "private_network", ip: "192.168.56.10"

      vm1.vm.provider "virtualbox" do |vb|
        vb.name = "ubuntu-vm1"
        vb.memory = 2048
        vb.cpus = 2
      end

      vm1.vm.provision "shell", inline: <<-SHELL
        sudo useradd -m -s "/bin/bash" user
        sudo usermod -aG sudo user
        sudo echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

        sudo mkdir -p /home/user/.ssh
        sudo echo "#{ssh_public_key}" > /home/user/.ssh/authorized_keys

        sudo systemctl restart ssh
      SHELL
    end

    config.vm.define "vm2" do |vm2|
        vm2.vm.box = "net9/ubuntu-24.04-arm64"
        vm2.vm.network "private_network", ip: "192.168.56.11"
  
        vm2.vm.provider "virtualbox" do |vb|
          vb.name = "ubuntu-vm2"
          vb.memory = 2048
          vb.cpus = 2
        end
  
        vm2.vm.provision "shell", inline: <<-SHELL
          sudo useradd -m -s "/bin/bash" user
          sudo usermod -aG sudo user
          sudo echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  
          sudo mkdir -p /home/user/.ssh
          sudo echo "#{ssh_public_key}" > /home/user/.ssh/authorized_keys
  
          sudo systemctl restart ssh
        SHELL
      end
  
  end
  