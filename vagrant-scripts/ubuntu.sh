#!/bin/sh

echo "deb http://br.archive.ubuntu.com/ubuntu $1 multiverse restricted" > /etc/apt/sources.list.d/non-free.list

cd /vagrant
if [ -x vagrant-scripts/$1.sh ]; then
  ./vagrant-scripts/$1.sh
fi

./development-setup.sh 
