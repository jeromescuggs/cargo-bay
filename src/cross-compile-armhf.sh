#!/bin/bash

# store the current dir
CUR_DIR=$(dirname $(readlink -f $0))

echo "pulling latest codebases to crates..."
sleep 1s
git submodule update --init
git submodule foreach git pull origin master
sleep 1s
echo "checking for required crate: Cross 0.1.16"
sleep 1s

if [[ -x "$(command -v cross)" ]]; then
        CROSS_VER=$(cross --version | sed -n '1 p')
else
    echo "Cross v 0.1.16 required, installing now..."
        sleep 1
        cargo install --version 0.1.16 cross
fi

if [[ -x "$(command -v cross)" ]] && [[ $CROSS_VER == "cross 0.1.16" ]];then
        echo "found cross 0.1.16, continuing..."
        sleep 1s
else
        echo "it appears an incorrect version of Cross is installed."
        sleep 1
        echo "Installing required version..."
        cargo install --force --version 0.1.16 cross
fi

echo "checking for Docker..."
sleep 1s
if [[ -x "$(command -v docker)" ]]; then 
	echo "Docker is installed! Proceeding..."
	sleep 1s
else 
	echo "Cross-compiling will require Docker for the build environment." 
	sleep 1s
	echo "To install, run:"
	echo "sudo apt install docker-compose docker.io" 
	echo "sudo usermod -aG docker \$(who am i| cut -d' ' -f1)"
	sleep 1s
	echo "after running the usermod command, log out and back in to refresh permissions, and re-run this script."
	exit 1
fi

RPI0_IMG=$(docker images | grep jerome | sed 's/\s.*$//')

if [[ $RPI0_IMG != "jerome/cross" ]]; then 
sleep 1s
echo "to compile for raspberry pi zero, a custom Docker image needs to be built."
sleep 1s
echo "Building new image from Dockerfile..."
docker build -t jerome/cross:rpi-0 .
fi

for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i"
	cargo clean 
cat > Cross.toml <<- "EOF"
[target.arm-unknown-linux-gnueabihf]
image = "jerome/cross:rpi-0"
EOF
    cd ..;
done

# Find all git repositories and update it to the master latest revision
for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i"
	sleep 1
	echo "building ${PWD##*/}"
	sleep 1
	cross build --release --target arm-unknown-linux-gnueabihf
    cd ..;
done

echo "Complete!"
sleep 1s
echo "run collect-armhf.sh to sweep all completed binaries into the 'bin' folder in the cargo-bay root directory."
