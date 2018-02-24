# SnapcastBox
Small OS based on Buildroot for SNAPCAST Multiroom audio system
Actual based on Buildroot 2017.11.2 and snapcast 0.12.0
Currently only Raspberry Pi 1 and Raspberry Pi Zero W are supported.

# Goal
Goal is to build a fast booting rock solid embedded linux system to run [snapcast](http://github.com/badaix/snapcast) on it.
Configuration (Hostname, WLAN SSID and Passwort) should be edited user friendly.
Target Hardware is in as first step the Raspberry Pi Platform for snapclients.

# Description
Buildroot is configured to run out of the RAM. Therefore it can be switched off at any time.
Also there is no need for difficult partition. Just copy a bunch of files on the SD card adapt 
the config files and that's it.

# Installation
Download the latest build from the release page or build it by yourself

1. Extract the zip file to a standard SD-Card (root directory)
2. Edit the file "hostname" and give the client his name in the network
3. Put the SD-Card to the RaspberryPi and boot into the system. Network is configured via DHCP. snapclient will start automtically

# Build instruction
## Download the files
1. Create a working directory (e.g. work) and enter it
2. Download and extract [Buildroot-2017.11.2](https://buildroot.org/downloads/buildroot-2017.11.2.tar.gz) to 'buildroot-2017.11.2'
3. Download snapcastbox
```
work $ git clone http://github.com/jaecksch/snapcastbox
```
4. Download snapcast
```
work $ git clone http://github.com/badaix/snapcast
```
5. Download the external for snapcast
```
work $ cd snapcast/externals
externals $ git submodule update --init --recursive
work $ cd ../..
```
## Build the system

1. Prepare building
```
work $ cd buildroot-2017.11.2
buildroot-2017.11.2 $ make BR2_EXTERNAL=../snapcastbox:../snapcast/buildroot rpi-client_defconfig
```
2. Build the system
```
buildroot-2017.11.2 $ make
```
Now it takes some time to download all stuff and compile snapcastbox.
The result is stored at
```
buildroot-2017.11.2/output/images/snapcastbox-rpiclient.zip
```

# Roadmap for Client
1. [X] Run on RaspberryPi 1B with analogue output as proof of concept
2. [X] Add WIFI support (Raspberry Pi Zero W)
3. [ ] Enable I2S Based Speaker Driver (HifiBerry MiniAmp)
4. [ ] Build minimal custom kernel

