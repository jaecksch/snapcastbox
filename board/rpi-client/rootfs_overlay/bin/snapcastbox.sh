#!/bin/sh
#
# snapcastbox.sh
# 
# Copyright 2018/19 Daniel Jäcksch <jaecksch@gmx.de>
# 
# Script to configure snapcastbox from a single config file
#

# Check and wait for /boot mount to appear

sleep 5

#

if [ -e /boot/snapcastbox.txt ]
then
    echo "/boot ok"
else
    echo "/boot nok"
fi

# Include config variables

. /boot/snapcastbox.txt

# 1. Hostname

echo $HOSTNAME >/etc/hostname
hostname $HOSTNAME

# 2. Set WIFI Parameters

sed -i -- "s/%-SSID-%/${SSID}/g" /etc/wpa_supplicant.conf
sed -i -- "s/%-PSK-%/${PSK}/g" /etc/wpa_supplicant.conf
