#!/bin/bash

# store the current dir
CUR_DIR=$(pwd)

# Let the person running the script know what's going on.
echo "Pulling in latest changes for all repositories..."

# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    sleep 1
	echo "navigating to $1..."
	sleep 1
	echo "executing build..."
#    echo "\033[33m"+$i+"\033[0m";

    # We have to go to the .git parent directory to call the pull command
    cd "$i" && cargo clean && cargo build --release;
    cd ..;

    # finally pull
# 	git stash;
#	git stash clear;
#    git gc --auto --prune=all;
#    git pull;

    # lets get back to the CUR_DIR
    cd $CUR_DIR
done

echo "Complete!"
