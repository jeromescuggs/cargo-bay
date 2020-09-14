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

if [[ -d "$CUR_DIR/vivid" ]] && [[ ! -d "$HOME/.config/vivid" ]]; then
    echo "Vivid requires a filetypes config file, and themes."
    sleep 1s
    echo "Pulling config files from Vivid crate and installing in default user config folder..."
	mkdir -p $HOME/.config/vivid
	cp $CUR_DIR/vivid/config/filetypes.yml $HOME/.config/vivid
	cp -r $CUR_DIR/vivid/themes $HOME/.config/vivid
fi
sleep 1s
echo "config files for vivid installed. to use, add the following to your profile rc:"
echo "LS_COLORS=\$(vivid generate snazzy)"
echo "Complete!"
