yaourt -Syy
yaourt -S --force --noconfirm \
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

su - vagrant -c "yaourt -S --force --noconfirm shunit2"
