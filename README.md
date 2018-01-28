# SnapcastOS
Small OS based on Buildroot for SNAPCAST Multiroom audio system
Actual based on Buildroot 2017.02.9 and snapcast 0.12.0

# Goal
Goal is to build a fast booting rock solid embedded linux system to run snapcast (http://github.com/badaix/snapcast) on it.
Configuration (Hostname, WLAN SSID and Passwort) should be edited user friendly.
Target Hardware is in as first step the Raspberry Pi Platform for snapclients.

# Description

Buildroot is configured to run out of the RAM. Therefore it can be switched off at any time.
Also there is no need for difficult partition. Just copy a bnch of files on the SD card adapt 
the config files and that's it.

# Build instruction

TODO

# Roadmap for Client

1. Run on RaspberryPi 1B with analogue output as proof of concept
2. Add WIFI support
3. Enable I2S Based Speaker Driver (HifiBerry MiniAmp)
