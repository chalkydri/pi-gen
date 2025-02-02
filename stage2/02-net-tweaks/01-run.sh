#!/bin/bash -e

# Newer versions of raspberrypi-sys-mods set rfkill.default_state=0 to prevent
# radiating on 5GHz bands until the WLAN regulatory domain is set.
# Unfortunately, this also blocks bluetooth, so we whitelist the known
# on-board BT adapters here.

mkdir -p "${ROOTFS_DIR}/var/lib/systemd/rfkill/"
#           5                 miniuart 4      miniuart Zero   miniuart other  other
for addr in 107d50c000.serial 3f215040.serial 20215040.serial fe215040.serial soc; do
	echo 0 > "${ROOTFS_DIR}/var/lib/systemd/rfkill/platform-${addr}:bluetooth"
done

