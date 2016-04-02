#!/bin/sh

if [ -f /etc/lsb-release ]; then
  . /etc/lsb-release
  OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
  OS=Debian
elif [ -f /etc/arch-release ]; then
  OS=Arch
else
  OS=$(uname -s)
fi

if [ -x ./development-setup/$OS.sh ]; then
  ./development-setup/$OS.sh
fi

./holodev setup
