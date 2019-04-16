zypper --non-interactive in \
        bash-completion \
        bridge-utils \
        debootstrap \
        dnsmasq \
        ebtables \
        git \
        libvirt \
        lxc \
        shunit2 \
        sudo \
        which \
        make \
        ncurses-utils \

echo 'PATH=$PATH:/usr/share/shunit2/src' >> /etc/profile.local

systemctl start libvirtd
systemctl enable libvirtd
