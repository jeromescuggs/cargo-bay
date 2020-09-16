#!/bin/bash

rustup target add arm-unknown-linux-gnueabi
git clone https://github.com/raspberrypi/tools $HOME/rpi_tools
export RUSTFLAGS="-C linker=$HOME/rpi_tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc" 

cargo build --target arm-unknown-linux-gnueabihf --tests
