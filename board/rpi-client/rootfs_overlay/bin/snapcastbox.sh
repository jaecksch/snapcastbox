#!/bin/sh
#
# snapcastbox.sh
# 
# Copyright 2018 Daniel Jäcksch <jaecksch@gmx.de>
# 
# Script to configure snapcastbox from a single config file
#

# Include config variables

. /boot/snapcastbox.txt

# 1. Hostname

cat $HOSTNAME >/etc/hostname
hostname $HOSTNAME

# 2. Set WIFI Parameters

sed -i -- "s/%-SSID-%/${SSID}/g" /etc/wpa_supplicant.conf
sed -i -- "s/%-PSK-%/${PSK}/g" /etc/wpa_supplicant.conf
