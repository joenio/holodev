dnf install bash-completion \
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
            lxc-templates \
            gnupg

echo 'PATH=$PATH:/usr/share/shunit2' > /etc/profile.d/shunit2.sh
echo 'export PATH'                  >> /etc/profile.d/shunit2.sh
