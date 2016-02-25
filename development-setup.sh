#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
echo "lxc lxc/directory string /var/lib/lxc" | sudo debconf-set-selections
sudo apt-get update
which mk-build-deps || sudo apt-get install -y devscripts equivs
dpkg-checkbuilddeps || yes | sudo mk-build-deps --install --remove
