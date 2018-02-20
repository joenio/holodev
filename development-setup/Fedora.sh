# avoid routing (DUP!) error when ping some HOST
route add default gw 10.0.2.2

dnf --best --allowerasing --assumeyes install \
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
            lxc-templates \
            gnupg \
            libpsl

echo 'PATH=$PATH:/usr/share/shunit2' > /etc/profile.d/shunit2.sh
echo 'export PATH'                  >> /etc/profile.d/shunit2.sh
source /etc/profile.d/shunit2.sh

systemctl start libvirtd
systemctl enable libvirtd
