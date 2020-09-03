#!/bin/bash

# store the current dir
CUR_DIR=$(dirname $(readlink -f $0))

# Let the person running the script know what's going on.
echo "Pulling in latest changes for all repositories..."
sleep 1
git submodule update --init

# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i"
	echo "updating ${PWD##*/}"
	sleep 1
    git pull origin master
	sleep 1
	echo "building ${PWD##*/}"
	sleep 1
	cargo clean 
	sleep 1
	cross build --release --target aarch64-unknown-linux-gnu;
    cd ..;

    # finally pull
# 	git stash;
#	git stash clear;
#    git gc --auto --prune=all;
#    git pull;
done

echo "Complete!"
