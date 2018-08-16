#!/bin/bash

sudo apt update
sudo apt install -y build-essential u-boot-tools lzop debootstrap gcc-aarch64-linux-gnu device-tree-compiler
sudo apt install -y ubuntu-snappy snapcraft snap
sudo apt install -y xzip
sudo apt install -y swig libpython-dev
sudo snap install --beta ubuntu-image

# update gcc to ver 6.4
sudo apt-get install build-essential software-properties-common -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install gcc-snapshot -y
sudo apt-get update
sudo apt-get install gcc-6 g++-6 -y
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6
sudo apt-get install gcc-4.8 g++-4.8 -y
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
sudo update-alternatives --config gcc

