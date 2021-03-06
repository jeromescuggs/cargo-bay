#!/bin/bash

# store the current dir
CUR_DIR=$(dirname $(readlink -f $0))

# Let the person running the script know what's going on.
echo "Pulling in latest changes for all repositories..."
sleep 1s

git submodule update --init

# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i" 
	echo "cleaning ${1##*/}"
	sleep 1
	cargo clean 
	#cargo build --release;
	echo "updating...";
	git pull origin master;
    cd ..;

done

echo "Complete!"
