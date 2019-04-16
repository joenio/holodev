VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network 'public_network'
  {
    jessie:     'debian/jessie64',
    stretch:    'debian/stretch64',
    trusty:     'ubuntu/trusty32',
    vivid:      'larryli/vivid64',
    wily:       'ubuntu/wily32',
    xenial:     'ubuntu/xenial32',
    artful:     'ubuntu/artful32',
    archlinux:  'archlinux/archlinux',
    suse42_1:   'opensuse/openSUSE-42.1-x86_64',
    suse42_2:   'opensuse/openSUSE-42.2-x86_64',
    suse42_3:   'opensuse/openSUSE-42.3-x86_64',
    tumbleweed: 'opensuse/openSUSE-Tumbleweed-x86_64',
    fedora27:   'fedora/27-cloud-base',
    fedora26:   'fedora/26-cloud-base',
    fedora25:   'fedora/25-cloud-base',
    fedora24:   'fedora/24-cloud-base',
  }.each do |release, box|
    config.vm.define release do |machine|
      machine.vm.box = box
      machine.vm.provision 'shell', inline: 'cd /vagrant && ./development-setup.sh'
    end
  end
end
# vim: filetype=ruby
