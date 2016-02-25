#!/bin/sh

echo "deb http://ftp.br.debian.org/debian $1 contrib non-free" > /etc/apt/sources.list.d/non-free.list

cd /vagrant
if [ -x vagrant-scripts/$1.sh ]; then
  ./vagrant-scripts/$1.sh
fi

./development-setup.sh 
