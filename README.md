# SnappyUbuntuCore
Develop Rock64 Pi to Snappy 16 [Snappy Ubuntu Core](http://developer.ubuntu.com/snappy/) 

## Structure
builder: build Snappy via makefiles, and that includes Gadget snap and Kernel snap.  

## Requirements
Make sure your build environment is based on `Ubuntu 16.04` or later. Then, you need to install snappy tools, for creating image.

To build all parts, a couple of dependencies are required. On Ubuntu you can install all build dependencies with the following commands.

```bash
sudo apt-get update
sudo apt-get install swig libpython-dev python
sudo apt-get install -y build-essential u-boot-tools lzop debootstrap gcc-aarch64-linux-gnu device-tree-compiler
sudo apt-get install -y git ubuntu-snappy snapcraft pxz
sudo apt-get install -y snap
sudo snap install --classic --edge ubuntu-image
```

Generate ssh key-pair if you did not have one

```bash
ssh-keygen -t rsa
```

Create Model assertion

1. Signup for ubuntu SSO.
   https://login.ubuntu.com/+login
2. Import an SSH Key into your Ubuntu SSO account.
3. Model assertion of model
   https://docs.ubuntu.com/core/en/guides/build-device/image-building.html
   e.g rock64-model.json
4. Sign your model. it will generate signed model file.
   cat rock64-model.json | snap sign -k default &> rock64.model
   e.g rock64.model

First, make sure you have Ubuntu One SSO and ability to get 2nd factor from Authenticator, then execute the following command:
```bash
snapcraft login
```

## Quick Build

Build an image by fetching essential snaps from Ubuntu store
```bash
./build-snappy.sh
```

## Build from scratc
A `Makefile` is provided to build Snappy, Gadget snap, U-Boot, Kernel snap from source. The sources will be cloned into local folders if not there already.

To build it all, just run `make snappy`. This will produce a Snappy image, a gadget snap `rock64_x.y_all.snap` and a kernel snap `rock64-kernel_x.y.z.snap` for device part, which can be used to build your own Snappy image.

### Custom Image
If you want to build the speical version with including the snap you'd like to install from ubuntu store, you can modify the snappy.mk to reach it. For example:  

```bash
sudo /snap/bin/ubuntu-image \
	--channel $CHANNEL \
	--image-size 4G \
	--extra-snaps snapweb \
	--extra-snaps bluez \
	--extra-snaps modem-manager \
	--extra-snaps network-manager \
	--extra-snaps rock64_x.y_all.snap \
	--extra-snaps rock64-kernel_x.y.z.snap \
	-o uc16-rock64-pi.img \
	rock64.model
```

### Build U-boot

```bash
make u-boot
```

### Build Gadget snap

```bash
make gadget
```

### Build Kernel snap

```bash
make kernelsnap
```

### Rebuild a snappy
To rebuild the snappy or other parts, just type `make clean` or `make clean-{prefix}`. The prefix will be u-boot, gadget, kernelsnap, etc. 

## Flash to SD card
Before dd, we suggest the SD card storage should be umounted to safely clean up.

```bash
xzcat ${image} | pv | sudo dd of=/dev/${device} bs=32M ; sync
```
## TroubleShooting
Before snapcraft begins to compile the snap, it may pop up an error as below:
```
No valid credentials found. Have you run "snapcraft login"?
```

First, make sure you have Ubuntu One SSO and ability to get 2nd factor from Authenticator, then execute the following command:
```bash
snapcraft login
```
