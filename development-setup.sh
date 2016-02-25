#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
echo "lxc lxc/directory string /var/lib/lxc" | debconf-set-selections
apt-get update
which mk-build-deps || apt-get install -y devscripts equivs
dpkg-checkbuilddeps || yes | mk-build-deps --install --remove
./holodev setup
