# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Указываем базовый образ
  # config.vm.box = "ubuntu/focal64"
  # для ARM-процессоров
  config.vm.box = "net9/ubuntu-24.04-arm64"

  # Настраиваем ресурсы
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.network "forwarded_port", guest: 80, host: 80

  # Провизирование: обновление системы
  config.vm.provision "shell", inline: <<-SHELL
    # Обновляем систему
    sudo apt-get update -y
    sudo apt-get upgrade -y
  SHELL
end
