#! /bin/sh

set -e

export CARGO_HOME="`pwd`/.cargo"
export RUSTUP_HOME="`pwd`/.rustup"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
sh rustup.sh --default-host x86_64-unknown-linux-gnu --default-toolchain stable -y --no-modify-path

export PATH=`pwd`/.cargo/bin/:$PATH

cargo fmt --all -- --check
cargo build

mkdir ../inst
PREFIX=../inst make install
test -f ../inst/bin/snare

echo 9999.8888.7777 | make distrib
test -f snare-9999.8888.7777.tgz
rm snare-9999.8888.7777.tgz

which cargo-deny | cargo install cargo-deny
cargo-deny check license
