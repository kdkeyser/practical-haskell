# Example code for Meetup Practical Haskell
October 20, 2025

## Tooling

### Install GHCUP

https://www.haskell.org/ghcup/

Note: on Linux, install ligmp-dev package, otherwise you get a warning about libgmp.so missing.

### Install the compiler (GHC), build tool & package manager (cabal) and the language server to use with VS Code (HLS)

Haskell's tooling is a bit fragile, in particular the language server tends to break with updates to cabal and/or GHC. We will use the following versions of the compiler and tools, to make sure they all work together:

ghcup install ghc 9.12.2
ghcup install cabal 3.14.2.0
ghcup install hls 2.11.0.0
ghcup set ghc 9.12.2
ghcup set cabal 3.14.2
cabal update

## Example code

Check out a branch, run `cabal build` to build the code. If it succeeds, run `cabal run` to run the program and look at `test.bmp` for the output.

### branch `step1`

This is a simple bitmap filled with a color that just depends on the location of the pixel (x,y). 

### branch `step2`

Here we introduce the first raytracing concept. We introduce a simple red sphere, and a lighting model that the pixel on our image is red if the ray hits the sphere. Otherwise it is black.

### branch `step3`

We add a uniform light source, and specular lighting to the ray. 

