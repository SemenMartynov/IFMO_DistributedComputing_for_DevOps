VMS = [
    {
        name: "directus",
        box: "ubuntu/jammy64",
        public_ip: "192.168.56.10",
        private_ip: "192.168.56.10",
        ssh_port: 2201,
        memory: 1024,
        cpus: 1,
        forwarded_ports: [
            {guest: 8055, host: 8055},
            {guest: 22, host: 2201}
        ]
    },
    {
        name: "node1-postgresql",
        box: "ubuntu/jammy64",
        public_ip: "192.168.56.20",
        private_ip: "192.168.56.20",
        ssh_port: 2202,
        memory: 1024,
        cpus: 1,
        forwarded_ports: [
            {guest: 22, host: 2202}
        ]
    },
    {
        name: "node2-postgresql",
        box: "ubuntu/jammy64",
        public_ip: "192.168.56.30",
        private_ip: "192.168.56.30",
        ssh_port: 2203,
        memory: 1024,
        cpus: 1,
        forwarded_ports: [
            {guest: 22, host: 2203}
        ]
    },
    {
        name: "node3-monitoring",
        box: "ubuntu/jammy64",
        public_ip: "192.168.56.40",
        private_ip: "192.168.56.40",
        ssh_port: 2205,
        memory: 2048,
        cpus: 2,
        forwarded_ports: [
            {guest: 22, host: 2205},
            {guest: 3000, host: 3000},  # Grafana
            {guest: 9090, host: 9090}   # Prometheus
        ]
    }
]

Vagrant.configure("2") do |config|
    VMS.each do |vm|
        config.vm.define vm[:name] do |v|
            v.vm.box = vm[:box]

            # Сетевые настройки
            v.vm.network "private_network", ip: vm[:private_ip]
            v.vm.network "public_network", bridge: "enp4s0", ip: vm[:public_ip]

            # Проброс портов
            vm[:forwarded_ports].each do |fp|
                v.vm.network "forwarded_port",
                    guest: fp[:guest],
                    host: fp[:host],
                    auto_correct: true
            end

            # Настройки VirtualBox
            v.vm.provider "virtualbox" do |vb|
                vb.name = vm[:name]
                vb.memory = vm[:memory]
                vb.cpus = vm[:cpus]
                vb.customize ["modifyvm", :id, "--ioapic", "on"]
                vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
                vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            end

            # Provisioning: создание пользователя devopsuser и настройка SSH
            v.vm.provision "shell", inline: <<-SHELL
                # Создаем нового пользователя devopsuser
                useradd -m -s /bin/bash devopsuser

                # Добавляем пользователя в группу sudo
                usermod -aG sudo devopsuser

                # Настроим sudo без пароля
                echo 'devopsuser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99_devopsuser

                # Создаем .ssh директорию для devopsuser
                mkdir -p /home/devopsuser/.ssh

                # Добавляем публичный ключ в authorized_keys для devopsuser
                echo "#{File.read('devopsuser_rsa.pub')}" >> /home/devopsuser/.ssh/authorized_keys

                # Устанавливаем правильные права доступа
                chown -R devopsuser:devopsuser /home/devopsuser/.ssh
                chmod 700 /home/devopsuser/.ssh
                chmod 600 /home/devopsuser/.ssh/authorized_keys
            SHELL
        end
    end
end
