Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "/path/to/your/projects", "/var/www/projects"
  
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    vb.memory = "768"
  end
  
  config.vm.provision "shell", path: "vgrntServer.sh"
end
