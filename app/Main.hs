{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Codec.Picture
import Color
import GHC.Float (int2Float)

width :: Int
width = 800

height :: Int
height = 600

-- | render determines the color of a pixel based on the x and y coordinates
render:: Int -> Int -> PixelRGBF
render x y =
  let r :: Float = int2Float x / int2Float width in
  let g :: Float = int2Float y / int2Float height in
  let b = r*g in
  let color = Color r g b in
  let (r', g', b') = tosRGB color in
  PixelRGBF r' g' b'

main :: IO ()
main = 
    let image = ImageRGBF $ generateImage render width height in
    saveBmpImage "test.bmp" image