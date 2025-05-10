Vagrant.configure("2") do |config|
    config.vm.define "alpha" do |alpha|
        alpha.vm.box = "net9/ubuntu-24.04-arm64"
        
        alpha.vm.synced_folder "html", "/var/www/html"
        
        alpha.vm.network "public_network", ip: "192.168.0.15"
        alpha.vm.network "private_network", ip: "192.168.56.15"
        alpha.vm.network "forwarded_port", guest: 22, host: 2215, id: "ssh"

        alpha.vm.provider "virtualbox" do |vb|
            vb.name = "alpha"
            vb.memory = "1024"
            vb.cpus = 2
        end
    end
    
    config.vm.define "delta" do |delta|
        delta.vm.box = "net9/ubuntu-24.04-arm64"

        delta.vm.network "public_network", ip: "192.168.0.19"
        delta.vm.network "private_network", ip: "192.168.56.19"
        delta.vm.network "forwarded_port", guest: 22, host: 2219, id: "ssh"

        delta.vm.provider "virtualbox" do |vb|
            vb.name = "delta"
            vb.memory = "1024"
            vb.cpus = 2
        end
    end

    config.vm.define "lambda" do |lambda|
        lambda.vm.box = "net9/ubuntu-24.04-arm64"
        
        lambda.vm.network "public_network", ip: "192.168.0.23"
        lambda.vm.network "private_network", ip: "192.168.56.23"
        lambda.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh"

        lambda.vm.provider "virtualbox" do |vb|
            vb.name = "lambda"
            vb.memory = "1024"
            vb.cpus = 2
        end
    end
end