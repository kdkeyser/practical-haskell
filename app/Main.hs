{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Codec.Picture
import Color
import Vector
import Ray
import Sphere

-- | pixelToCoordinate turns a screen pixel into a physical coordinate
pixelToCoordinate :: Int -> Int -> Int -> Int -> Vector
pixelToCoordinate x y width height =
  let x' :: Float = fromIntegral x
      y' :: Float = fromIntegral y
      width' :: Float = fromIntegral width
      height' :: Float = fromIntegral height
      a = width' / height' -- aspect ratio
      x'' = (x' + 0.5 - (width' / 2.0)) / (width' / 2.0) * a  
      y'' = (y' + 0.5 - (height' / 2.0)) / (height' / 2.0) 
   in Vector x'' y'' displayZ

-- | ray computes the ray from the eye to the pixel at (x, y)
ray :: Vector -> Int -> Int -> Ray
ray eye x y =
  Ray {origin = eye, direction = sub dir eye}
  where dir = pixelToCoordinate x y width height

eye :: Vector
eye = Vector {x = 0.0, y = 0.0, z = 2.0}

width :: Int
width = 800

height :: Int
height = 600

displayZ :: Float
displayZ = 0.0

-- | render determines the color of a pixel based on the x and y coordinates
render :: Sphere -> Int -> Int -> PixelRGBF
render sphere x y =
  let r = ray eye x y
      color = if hits sphere r then Color 1 0 0 else Color 0 0 0
      (r', g', b') = tosRGB color
  in PixelRGBF r' g' b'

main :: IO ()
main =
  let sphere = Sphere (Vector 0 0 (-1)) 1.0
  in let image = ImageRGBF $ generateImage (render sphere) width height
  in saveBmpImage "test.bmp" image
