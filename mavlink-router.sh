#!/bin/bash

set -e
set -x

sudo apt install autoconf automake libtool -y
sudo apt install git meson ninja-build pkg-config gcc g++ systemd -y
sudo pip3 install meson

pushd ~/
## Git clone mavlink-router
rm -rf ~/mavlink-router
[ -d ~/mavlink-router ] || {
    git clone https://github.com/intel/mavlink-router.git
}

## and build them
pushd ~/mavlink-router
 git submodule update --init --recursive
 meson setup build
 ninja -C build
 sudo ninja -C build install
 sudo mkdir -p /etc/mavlink-router
 sudo cp ~/apsync-Kakute/mavlink-router.conf /etc/mavlink-router/main.conf
 sudo systemctl enable mavlink-router.service
 sudo systemctl start mavlink-router.service
popd
popd
