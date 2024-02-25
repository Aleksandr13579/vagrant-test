# -*- mode: ruby -*-
# vi: set ft=ruby :

servers = [
	{ :hostname => 'wifi', :ip => '192.168.0.66', :core => 1 , :ram => 1024, :diskSize => '20GB', :sshPort => 22200 },
	{ :hostname => 'parser.server', :ip => '192.168.1.130', :core => 1 , :ram => 1024, :diskSize => '20GB', :sshPort => 22210 },
	{ :hostname => 'db.server', :ip => '192.168.2.66', :core => 2 , :ram => 2048, :diskSize => '20GB', :sshPort => 22220 }
]

Vagrant.configure("2") do |config|
  servers.each do |server|
    config.vm.define server[:hostname] do |serverConfig|
      serverConfig.vm.box = "centos/7"
      serverConfig.vm.disk :disk, size: server[:diskSize], primary: true
      serverConfig.vm.box_check_update = false
      serverConfig.vm.hostname = server[:hostname]
      serverConfig.vm.network "private_network",  ip: server[:ip], :netmask => "255.255.255.192"
      serverConfig.vm.network "public_network", ip: server[:ip], :netmask => "255.255.255.192"
      serverConfig.ssh.insert_key = false
      serverConfig.ssh.private_key_path = [ './id_rsa', '~/.vagrant.d/insecure_private_key' ]
      #config.vm.provision "shell" do |s|
      #  ssh_pub_key = File.readlines("./id_rsa.pub").first.strip
      #  s.inline = <<-SHELL
      #    echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys  &&
      #    sudo yum update -y
      #  SHELL
      #end
      serverConfig.disksize.size = server[:diskSize] ? server[:diskSize] : '20GB'
      serverConfig.vm.provider "virtualbox" do |vb|
        vb.name = server[:hostname]
        vb.memory = server[:ram] ? server[:ram] : 1024
        vb.cpus = 1
      end

      serverConfig.vm.provision "ansible" do |ansible|
        ansible.playbook = "instalation-config.yaml"
      end

      if server[:hostname] == "db.server"
        serverConfig.vm.provision "ansible" do |ansible|
          ansible.playbook = "configure-db-server.yaml"
        end
      end
      #when "parser.server" 
      #  config.vm.provision "ansible" do |ansible|
      #    ansible.playbook = "deploy-parser.yaml"
      #  end

    end
  end
end
