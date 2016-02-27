#!/bin/sh

cd /vagrant
if [ -x vagrant-scripts/$1.sh ]; then
  ./vagrant-scripts/$1.sh
fi

./development-setup.sh
