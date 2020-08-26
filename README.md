# cargo-bay

a project to package common, useful applications written in Rust for quick deployment on a fresh install. the original repository has been de-hyphenated and is at [jeromescuggs/cargobay]

## use-case

this started out as a way to quickly grab the Rust applications i like to use in my development environment. when possible i prefer building my binaries, primarily because over time i've more or less memorized the repo URL's but not the links to the binaries themselves, it becomes routine to just grab the repositories and start the builds. 

however, as i spent more time developing natively on ARM-based boards, this became a hassle as build times were far slower than building for more powerful desktop pc's. so I created the original cargo-bay repository as a way to quickly grab fresh binaries for my favorite utilities. 

## re-vamp

from there it became trivial to then expand this to collections of binaries for both x86_64 and Arm7/64 architectures. however, i relied on the nifty `git submodule` to maintain my repository structures - and over time it's become somewhat arduous to manually keep everything fresh and updated. 

this repository will, hopefully, be the home of a more streamlined take on the same concept, which will take advantage of the fact that i'm approaching it with what i know now, compared to what i knew then. the goal will be for this repository to serve as an automated build repo, which will allow me to quickly pull the most recent commits for my favorite tools, compile them, and propagate the fresh builds to [cb-x86_64] and [cb-aarch64]. 

[jeromescuggs/cargobay]: https://github.com/jeromescuggs/cargobay  
[cb-x86_64]: https://github.com/jeromescuggs/cb-x86_64
[cb-aarch64]: https://github.com/jeromescuggs/cb-aarch64
