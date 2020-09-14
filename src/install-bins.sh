#!/bin/bash

# store the current dir
CUR_DIR=$(dirname $(readlink -f $0))

# Let the person running the script know what's going on.
echo "installing compiled binaries..."
sleep 1

# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i"
	echo "installing ${PWD##*/}"
	sleep 1
    cp ./target/release/${PWD##*/} $HOME/.cargo/bin
#	sleep 1
#	echo "building ${PWD##*/}"
#	sleep 1
#	cargo clean 
#	sleep 1
#	cargo build --release;
    cd ..;

    # finally pull
# 	git stash;
#	git stash clear;
#    git gc --auto --prune=all;
#    git pull;
done

echo "Complete!"
