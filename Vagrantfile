VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network 'public_network', bridge: "wlan0"

  ['squeeze', 'wheezy', 'jessie'].each do |release|
    config.vm.define release do |machine|
      machine.vm.box = "deb/#{release}-i386"
      machine.vm.provision 'shell', path: "vagrant-scripts/debian.sh", :args => release
    end
  end

  ['precise', 'trusty', 'vivid'].each do |release|
    config.vm.define release do |machine|
      machine.vm.box = "ubuntu/#{release}32"
      machine.vm.provision :shell do |shell|
        shell.inline = "echo 'deb http://br.archive.ubuntu.com/ubuntu/ #{release} multiverse restricted' > /etc/apt/sources.list.d/non-free.list"
      end
    end
  end

end
