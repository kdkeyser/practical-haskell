{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Codec.Picture
import Color

width :: Int
width = 800

height :: Int
height = 600

-- | render determines the color of a pixel based on the x and y coordinates
render:: Int -> Int -> PixelRGBF
render x y =
  let r :: Float = fromIntegral x / fromIntegral width in
  let g :: Float = fromIntegral y / fromIntegral height in
  let b = r*g in
  let color = Color r g b in
  let (r', g', b') = tosRGB color in
  PixelRGBF r' g' b'

main :: IO ()
main = 
    let image = ImageRGBF $ generateImage render width height in
    saveBmpImage "test.bmp" image