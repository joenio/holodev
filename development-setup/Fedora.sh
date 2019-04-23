# avoid routing (DUP!) error when ping some HOST
route add default gw 10.0.2.2

dnf --best --allowerasing --assumeyes install \
            bash-completion \
            bridge-utils \
            debootstrap \
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
            perl \
            libpsl

FEDORA_RELEASE=$(cat /etc/fedora-release | sed 's/Fedora release \([0-9]\+\) .\+/\1/')
if [ "$FEDORA_RELEASE" = "27" ]; then
  dnf --best --allowerasing --assumeyes install dnsmasq-2.77
else
  dnf --best --allowerasing --assumeyes install dnsmasq
fi

echo 'PATH=$PATH:/usr/share/shunit2' > /etc/profile.d/shunit2.sh
echo 'export PATH'                  >> /etc/profile.d/shunit2.sh
source /etc/profile.d/shunit2.sh

systemctl start libvirtd
systemctl enable libvirtd
