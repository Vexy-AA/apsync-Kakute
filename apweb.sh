#!/bin/bash

set -e
set -x
pushd ~/
rm -rf APWeb

sudo apt install python3-pip python2 libtalloc-dev -y
pip install future --user

[ -d ~/APWeb ] || {
    git clone https://github.com/ArduPilot/APWeb.git
}
pushd ~/APWeb
	pushd ./modules
	git clone https://github.com/ArduPilot/mavlink.git
		pushd ./mavlink
		 git submodule update --init --recursive
		popd
	popd
 make CFLAGS=-Wno-error
popd

sudo cp ~/apsync-Kakute/APWeb.service /etc/systemd/system/APWeb.service
sudo systemctl enable APWeb.service
sudo systemctl start APWeb.service
popd
