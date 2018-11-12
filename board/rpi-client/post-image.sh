#!/bin/sh

# Part of snapcastbox
#
# Creates zip file wit  all files for 

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

mkdir "${GENIMAGE_TMP}"


cp -rp "${BINARIES_DIR}/rpi-firmware"/* "${GENIMAGE_TMP}"
cp "${BINARIES_DIR}"/bcm*.dtb "${GENIMAGE_TMP}"
cp "${BR2_EXTERNAL_SNAPCASTBOX_PATH}/board/rpi-client/rpi-firmware/cmdline.txt" "${GENIMAGE_TMP}"
cp "${BR2_EXTERNAL_SNAPCASTBOX_PATH}/board/rpi-client/rpi-firmware/config.txt" "${GENIMAGE_TMP}"

# Patching config.txt according to config variables

if grep -q SNAPCASTBOX_ANALOGUE=y "${BR2_CONFIG}"; then

echo "Forcing Analogue output to config.txt."
cat << __EOF__ >> "${GENIMAGE_TMP}/config.txt"

# Enable audio (loads snd_bcm2835)

dtparam=audio=on
hdmi_ignore_edid_audio=1
__EOF__
fi

if grep -q SNAPCASTBOX_HB_MINIAMP=y "${BR2_CONFIG}"; then
	
echo "Adding Hifiberry MiniAmp Overlay to config.txt."
cat << __EOF__ >> "${GENIMAGE_TMP}/config.txt"

# Hifiberry MiniAmp

dtoverlay=hifiberry-dac
__EOF__
fi

if grep -q SNAPCASTBOX_LIRC=y "${BR2_CONFIG}"; then
	
echo "Adding LIRC to config.txt."
cat << __EOF__ >> "${GENIMAGE_TMP}/config.txt"

# LIRC

dtoverlay=lirc-rpi,gpio_in_pin=18,gpio_in_pull=off
__EOF__
fi

cp "${BR2_EXTERNAL_SNAPCASTBOX_PATH}/board/rpi-client/rpi-firmware/snapcastbox.txt" "${GENIMAGE_TMP}"
cp "${BINARIES_DIR}/zImage" "${GENIMAGE_TMP}"
cd "${GENIMAGE_TMP}"
test ! -f "${BINARIES_DIR}/snapcastbox-rpiclient.zip" || rm "${BINARIES_DIR}/snapcastbox-rpiclient.zip"
zip -vr "${BINARIES_DIR}/snapcastbox-rpiclient" .
cd "${BINARIES_DIR}"
rm -rf "${GENIMAGE_TMP}" 


exit $?
