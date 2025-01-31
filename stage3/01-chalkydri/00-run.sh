#!/bin/bash -e

apt update
apt install rustup
rustup-init -y --default-toolchain nightly --profile minimal

git clone https://github.com/chalkydri/chalkydri.git

pushd chalkydri
cargo b -r
mv target/release/chalkydri "${ROOTFS_DIR}/usr/local/bin"
popd #chalkydri

cp files/chalkydri.service "${ROOTFS_DIR}/etc/systemd/system"

on_chroot << EOF
systemctl enable chalkydri
EOF
