#!/bin/bash

# store the current dir
CUR_DIR=$(dirname $(readlink -f $0))

cd $CUR_DIR && mkdir -p ./../bin/armhf

# Let the person running the script know what's going on.
echo "collecting compiled binaries from Cargo crate folders..."
sleep 1



# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
	cd "$i" 
	echo "collecting ${PWD##*/}" 
	cp target/arm-unknown-linux-gnueabihf/release/${PWD##*/} ../../bin/armhf
    cd ..;
done

echo "manually moving exceptions..."
sleep 1
if [[ -d ./bottom ]]; then
    echo "moving bottom to bin/armhf/btm"
    cp $CUR_DIR/bottom/target/arm-unknown-linux-gnueabihf/release/btm ../bin/armhf
fi 

echo "Complete!"
sleep 1s
echo "The binaries have been copied to the 'bin' directory in the root folder."
