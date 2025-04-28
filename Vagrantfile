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
            {guest: 22, host: 2202}
        ]
    }
]

Vagrant.configure("2") do |config|
    VMS.each do |vm|
        config.vm.define vm[:name] do |v|
            v.vm.box = vm[:box]

            # Private network для внутренней коммуникации
            v.vm.network "private_network", ip: vm[:private_ip]

            # Public network для доступа с хоста
            v.vm.network "public_network", 
                bridge: "enp4s0",
                ip: vm[:public_ip]

            # Проброс портов
            vm[:forwarded_ports].each do |fp|
                v.vm.network "forwarded_port",
                    guest: fp[:guest],
                    host: fp[:host],
                    auto_correct: true
            end

            # Конфигурация VirtualBox
            v.vm.provider "virtualbox" do |vb|
                vb.name = vm[:name]
                vb.memory = vm[:memory]
                vb.cpus = vm[:cpus]
                
                # Оптимизация для Ubuntu
                vb.customize ["modifyvm", :id, "--ioapic", "on"]
                vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
                vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            end
        end
    end
end