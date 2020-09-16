#!/bin/bash

for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i"
cat > Cross.toml <<- "EOF"
[target.aarch64-unknown-linux-gnu]
image = "my/image:tag"
EOF
    cd ..;
done
