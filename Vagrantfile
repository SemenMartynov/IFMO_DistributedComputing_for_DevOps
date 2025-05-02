DEFAULT_BOX = "net9/ubuntu-24.04-arm64"
DEFAULT_MEMORY = 1024
DEFAULT_CPUS = 1
VMS = [
    {
        name: "alpha",
        box: DEFAULT_BOX,
        public_ip: "192.168.0.15",
        private_ip: "192.168.56.15",
        ssh_port: 2215,
        memory: DEFAULT_MEMORY,
        cpus: DEFAULT_CPUS,
        synced_folder: ["html", "/var/www/html"]
    },
    {
        name: "beta",
        box: DEFAULT_BOX,
        public_ip: "192.168.0.19",
        private_ip: "192.168.56.19",
        ssh_port: 2219,
        memory: DEFAULT_MEMORY,
        cpus: DEFAULT_CPUS,
    },
    {
        name: "gamma",
        box: DEFAULT_BOX,
        public_ip: "192.168.0.23",
        private_ip: "192.168.56.23",
        ssh_port: 2223,
        memory: DEFAULT_MEMORY,
        cpus: DEFAULT_CPUS,
    },
    {
        name: "delta",
        box: DEFAULT_BOX,
        public_ip: "192.168.0.27",
        private_ip: "192.168.56.27",
        ssh_port: 2227,
        memory: DEFAULT_MEMORY,
        cpus: 2 * DEFAULT_CPUS,
    },
]

Vagrant.configure("2") do |config|
    VMS.each do |vm|
        config.vm.define vm[:name] do |v|
            v.vm.box = vm[:box]

            if vm[:synced_folder]
                Dir.mkdir(vm[:synced_folder][0]) unless Dir.exist?(vm[:synced_folder][0])
                v.vm.synced_folder vm[:synced_folder][0], vm[:synced_folder][1]
            end

            v.vm.network "public_network", ip: vm[:public_ip]
            v.vm.network "private_network", ip: vm[:private_ip]
            v.vm.network "forwarded_port", guest: 22, host: vm[:ssh_port], id: "ssh"

            v.vm.provider "virtualbox" do |vb|
                vb.name = vm[:name]
                vb.memory = vm[:memory]
                vb.cpus = vm[:cpus]
            end
        end
    end
end