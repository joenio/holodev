VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network 'public_network', bridge: "wlan0"
  { jessie:  'deb/jessie-i386',
    stretch: 'ederrm/debian-stretch-docker',
    trusty:  'ubuntu/trusty32',
    vivid:   'ubuntu/vivid32',
    wily:    'ubuntu/wily32', }.each do |release, box|
    config.vm.define release do |machine|
      machine.vm.box = box
      machine.vm.provision 'shell', inline: 'cd /vagrant && ./development-setup.sh'

    end
  end
end
