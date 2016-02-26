VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network 'public_network', bridge: "wlan0"

  ['wheezy', 'jessie'].each do |release|
    config.vm.define release do |machine|
      machine.vm.box = "deb/#{release}-i386"
      machine.vm.provision 'shell', path: "vagrant-scripts/debian.sh", :args => release
    end
  end

  config.vm.define 'stretch' do |machine|
    machine.vm.box = 'ederrm/debian-stretch-docker'
    machine.vm.provision 'shell', path: "vagrant-scripts/debian.sh", :args => 'stretch'
  end

  ['trusty', 'vivid', 'wily'].each do |release|
    config.vm.define release do |machine|
      machine.vm.box = "ubuntu/#{release}32"
      machine.vm.provision 'shell', path: "vagrant-scripts/ubuntu.sh", :args => release
    end
  end

end
