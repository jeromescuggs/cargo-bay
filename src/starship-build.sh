#!/bin/bash

# store the current dir
CUR_DIR=$(dirname $(readlink -f $0))

cargo install --version 0.1.16 cross

# Find all git repositories and update it to the master latest revision
# for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd ./starship
	sleep 1
	echo "building ${PWD##*/}"
	sleep 1
	cargo clean 
	sleep 1
	cross build --release --target aarch64-unknown-linux-gnu;
    cd ..;
echo "Complete!"
