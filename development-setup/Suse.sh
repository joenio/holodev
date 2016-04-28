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

echo 'PATH=$PATH:/usr/share/shunit2/src' >> /etc/profile.local

which aa-status > /dev/null; if [ $? -ne 0 ]; then
  echo
  echo "aa-status not found!" 1>&2
  echo "Disabling LXC Apparmor profile" 1>&2
  mkdir /etc/apparmor.d/disabled/
  ln -s /etc/apparmor.d/usr.bin.lxc-start /etc/apparmor.d/disabled/
fi

systemctl start libvirtd
systemctl enable libvirtd
