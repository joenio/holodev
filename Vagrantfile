VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network 'public_network'
  { jessie:    'deb/jessie-i386',
    trusty:    'ubuntu/trusty32',
    wily:      'ubuntu/wily32',
    xenial:    'ubuntu/xenial32',
    archlinux: 'terrywang/archlinux',
    opensuse:  'opensuse/openSUSE-42.1-x86_64',
    fedora:    'fedora/25-cloud-base',
  }.each do |release, box|
    config.vm.define release do |machine|
      machine.vm.box = box
      machine.vm.provision 'shell', inline: 'cd /vagrant && ./development-setup.sh'
    end
  end
end
