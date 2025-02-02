#!/bin/bash -e

on_chroot <<- EOF
	apt-mark auto python3-pyqt5 python3-opengl
EOF

cp files/chalkydri.service "${ROOTFS_DIR}/etc/systemd/system"

on_chroot <<- EOF
apt update
apt install git

wget -O rustup-init https://sh.rustup.rs
chmod +x rustup-init
./rustup-init -y --default-toolchain nightly --profile minimal
. "$HOME/.cargo/env"

git clone https://github.com/chalkydri/chalkydri.git

pushd chalkydri
cargo b -r
mv target/release/chalkydri /usr/local/bin
popd #chalkydri

rm -r .rustup .cargo chalkydri

systemctl enable chalkydri
EOF
