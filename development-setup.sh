#!/bin/sh

sudo apt-get update
which mk-build-deps || sudo apt-get install -y devscripts
dpkg-checkbuilddeps || yes | sudo mk-build-deps --install --remove
