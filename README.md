# SnapcastBox
Small OS based on Buildroot for SNAPCAST Multiroom audio system
Actual based on Buildroot 2017.02.9 and snapcast 0.12.0

# Goal
Goal is to build a fast booting rock solid embedded linux system to run [snapcast](http://github.com/badaix/snapcast) on it.
Configuration (Hostname, WLAN SSID and Passwort) should be edited user friendly.
Target Hardware is in as first step the Raspberry Pi Platform for snapclients.

# Description

Buildroot is configured to run out of the RAM. Therefore it can be switched off at any time.
Also there is no need for difficult partition. Just copy a bnch of files on the SD card adapt 
the config files and that's it.

# Build instruction

## Download the files

1. Create a working directory (e.g. work) and enter it
2. Download and extract [Buildroot-2017.02.9](https://buildroot.org/downloads/buildroot-2017.02.9.tar.gz) to 'buildroot-2017.02.9'
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
work $ cd buildroot-2017.02.9
buildroot-2017.02.9 $ make BR2_EXTERNAL=../snapcastbox:../snapcast/buildroot rpi-client_defconfig
```
2. Build the system
```
buildroot-2017.02.9 $ make
```
Now it takes some time to download all stuff and compile snapcastbox.
The result is stored at
```
buildroot-2017.02.9/output/images/snapcastbox-rpiclient.zip
```
3. Extract the output zip file to a standard SD-Card (root directory)
4. Edit the file "hostname" and give the client his name in the network
5. Put the SD-Card to the RaspberryPi and boot into the system. Network is configured via DHCP. snapclient will start automtically

# Roadmap for Client

1. Run on RaspberryPi 1B with analogue output as proof of concept
2. Add WIFI support
3. Enable I2S Based Speaker Driver (HifiBerry MiniAmp)
