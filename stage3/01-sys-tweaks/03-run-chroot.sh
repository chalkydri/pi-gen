#!/bin/bash -e

apt update
apt install git libclang-dev unzip cmake

# Install rustup
curl -o rustup-init https://sh.rustup.rs
chmod +x rustup-init
./rustup-init -y --default-toolchain nightly --profile minimal
. "$HOME/.cargo/env"

# Install bun
curl -fsSL https://bun.sh/install | bash
source /root/.bashrc

git clone https://github.com/chalkydri/chalkydri.git

pushd chalkydri

make rust RUSTFLAGS="-C target-feature=-crt-static -C target-cpu=cortex-a76 -C target-feature=+fp-armv8,+neon,+crc,+crypto" RUST_MIN_STACK=5368709184
mv target/release/chalkydri /usr/local/bin

popd #chalkydri

# Clean up
rm -r ~/.rustup ~/.cargo ~/.bun chalkydri
apt remove git build-essential pkg-config \
	curl ca-certificates libclang-dev unzip \
	cmake

systemctl enable chalkydri
