#!/bin/bash -e

apt update
apt install git

curl -o rustup-init https://sh.rustup.rs
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
