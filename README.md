# cargo-bay

a project to package common, useful applications written in Rust for quick deployment on a fresh install. the original repository has been de-hyphenated and is at [jeromescuggs/cargobay]

## current packages:

- [bat], like `cat` but with syntax highlighting
- [broot], a highly tweakable file explorer with vim-like extensibility
- [exa], `ls` with more options, colors, and even icons!
- [fd], a no-nonsense way to search for files. 
- [pastel], useful utility for developers who play with colors. display, mix, compare colors in the terminal. 
- [starship], a futuristic, customizable, and fast shell prompt. 
- [vivid], a tool to enhance `LS_COLORS`, `.dircolors` etc. Themeable. 
- [ytop], the Rust re-write of [gotop](https://github.com/cjbassi/gotop), a prettier `htop`-inspired process viewer. 
- [bottom], the successor to `ytop`.

[bat]: https://github.com/sharkdp/bat
[broot]: https://github.com/Canop/broot
[exa]: https://github.com/sharkdp/exa
[fd]: https://github.com/sharkdp/fd
[pastel]: https://github.com/sharkdp/pastel
[starship]: https://github.com/starship/starship
[vivid]: https://github.com/sharkdp/vivid
[ytop]: https://github.com/cjbassi/ytop
[bottom]: https://github.com/ClementTsang/bottom

however, the build script simply enters every subfolder in the `src` directory, so if you want to add or remove from this list, it's as simple as navigating to `cargo-bay/src` and either fetching other crates with git or removing any project folder you don't need. 

## usage

from the `cargo-bay` directory root: 

- to pull fresh images and compile them for native environment: `cd src && ./build-all.sh`
- to install the finished programs from above into `$HOME/.cargo/bin`: `cd src && ./install-bins.sh`

for cross-compiling, cargo-bay uses the `cross` crate, which uses Docker to build rust crates for other architectures. 

make sure Docker is installed, and the user is given permissions: 

```
sudo apt update
sudo apt install docker-compose docker.io
sudo usermod -aG docker $(who am i| cut -d' ' -f1)
```

since you are going to be changing user permissions you will want to logout and log back in to refresh them. you will then be able to run docker without relying on root. 

### advantages of cargo-bay

#### avoids breaking when compiling crates that require openssl headers

unfortunately, `cross` will fail when trying to compile any crate that requires then OpenSSL libraries. my solution is that the scripts to cross-compile will use the version 0.1.16 binary, which does include the necessary libraries. this should have zero effect on anything, but it's worth mentioning if you do wind up troubleshooting for some reason. 

- to cross-compile for arm64 devices: `cd src && ./cross-compile-aarch64.sh`

the script above is set up to run `cross build --release --target aarch64-unknown-linux-gnu`. for other architectures, edit this command in the above script, changing the `--target` to your desired toolchain.

#### compiling for the raspberry pi 0/W

the raspberry pi zero unfortunately uses an arm6l cpu, and newer versions of the standard gcc libraries are not compiled to include support for this architecture. this means trying to compile binaries for the pi zero is incredibly annoying... unless you use cargo-bay!!

~~~ sh 
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
~~~

### use-case

this started out as a way to quickly grab the Rust applications i like to use in my development environment. when possible i prefer building my binaries, primarily because over time i've more or less memorized the repo URL's but not the links to the binaries themselves, it becomes routine to just grab the repositories and start the builds. 

however, as i spent more time developing natively on ARM-based boards, this became a hassle as build times were far slower than building for more powerful desktop pc's. so I created the original cargo-bay repository as a way to quickly grab fresh binaries for my favorite utilities. 

### re-vamp

from there it became trivial to then expand this to collections of binaries for both x86_64 and Arm7/64 architectures. however, i relied on the nifty `git submodule` to maintain my repository structures - and over time it's become somewhat arduous to manually keep everything fresh and updated. 

this repository will, hopefully, be the home of a more streamlined take on the same concept, which will take advantage of the fact that i'm approaching it with what i know now, compared to what i knew then. the goal will be for this repository to serve as an automated build repo, which will allow me to quickly pull the most recent commits for my favorite tools, compile them, and propagate the fresh builds to [cb-x86_64] and [cb-aarch64]. 



[jeromescuggs/cargobay]: https://github.com/jeromescuggs/cargobay  
[cb-x86_64]: https://github.com/jeromescuggs/cb-x86_64
[cb-aarch64]: https://github.com/jeromescuggs/cb-aarch64
