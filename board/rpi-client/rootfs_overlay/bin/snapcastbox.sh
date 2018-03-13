#!/bin/sh
#
# snapcastbox.sh
# 
# Copyright 2018 Daniel Jäcksch <jaecksch@elinux>
# 
# Script to configure snapcastbox from a single config file
#

# Include config variables

. /boot/snapcastbox.txt

# 1. Hostname

cat $HOSTNAME >/etc/hostname

# 2. Set WIFI Parameters

sed -i -- "s/%-SSID-%/${SSID}/g" /etc/wpa_supplicant.conf
sed -i -- "s/%-PSK-%/${PSK}/g" /etc/wpa_supplicant.conf
