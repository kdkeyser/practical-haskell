Example code for Meetup Practical Haskell
October 20, 2025

Check out a branch, run `cabal build` to build the code. If it succeeds, run `cabal run` to run the program and look at `test.bmp` for the output.

- branch `step1`

This is a simple bitmap filled with a color that just depends on the location of the pixel (x,y). 

- branch `step2`

Here we introduce the first raytracing concept. We introduce a simple red sphere, and a lighting model that the pixel on our image is red if the ray hits the sphere. Otherwise it is black.

- branch `step3`

We add a uniform light source, and specular lighting to the ray. 

