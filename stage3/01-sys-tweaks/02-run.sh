#!/bin/bash -e

cp files/chalkydri.service "${ROOTFS_DIR}/etc/systemd/system"
cp files/chalkydri.toml "${ROOTFS_DIR}/chalkydri.toml"
