yes | pacman -Sy \
        bash-completion \
        bridge-utils \
        cgmanager \
        debootstrap \
        dnsmasq \
        ebtables \
        git \
        libvirt \
        lxc \
        sudo \
        perl \
        fakeroot \
        automake \
        autoconf \
        gcc \
        make


su - vagrant -c "
wget https://aur.archlinux.org/cgit/aur.git/snapshot/shunit2.tar.gz &&
tar zxvf shunit2.tar.gz &&
cd shunit2 &&
makepkg -s
"
yes | pacman -U /home/vagrant/shunit2/shunit2-*.pkg.tar.xz

su - vagrant -c "
wget https://aur.archlinux.org/cgit/aur.git/snapshot/lxc-templates.tar.gz &&
tar zxvf lxc-templates.tar.gz &&
cd lxc-templates &&
makepkg -s
"
yes | pacman -U /home/vagrant/lxc-templates/lxc-templates-*.pkg.tar.xz

systemctl start libvirtd.service libvirt-guests.service
systemctl enable libvirtd.service libvirt-guests.service
