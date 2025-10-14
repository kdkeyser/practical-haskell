{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Codec.Picture
import Color
import Ray
import Sphere
import VectorGADT
import Light qualified

-- | pixelToCoordinate turns a screen pixel into a physical coordinate
pixelToCoordinate :: Int -> Int -> Int -> Int -> AnyVector
pixelToCoordinate x y width height =
  let x' :: Float = fromIntegral x
      y' :: Float = fromIntegral y
      width' :: Float = fromIntegral width
      height' :: Float = fromIntegral height
      a = width' / height' -- aspect ratio
      x'' = (x' + 0.5 - (width' / 2.0)) / (width' / 2.0) * a
      y'' = (y' + 0.5 - (height' / 2.0)) / (height' / 2.0)
   in makeVector x'' y'' displayZ

-- | ray computes the ray from the eye to the pixel at (x, y)
ray :: AnyVector -> Int -> Int -> Maybe Ray
ray eye x y =
  let direction = sub (pixelToCoordinate x y width height) eye
   in (\dir -> Ray {origin = eye, direction = normalize dir}) <$> nonZero direction

eye :: AnyVector
eye = makeVector 0.0 0.0 2.0

width :: Int
width = 800

height :: Int
height = 600

displayZ :: Float
displayZ = -1.0

-- | render determines the color of a pixel based on the x and y coordinates
render :: Light.UniformLight -> Sphere -> Int -> Int -> PixelRGBF
render light sphere x y =
  let Just r = ray eye x y -- safe because center.z < eye.z, but we should probably handle this better
      color = case (hits sphere r) of
         Nothing -> Color 0.0 0.0 0.0
         Just hit ->
             let lightDir = Light.direction light
                 lightIntensity = max 0 (- dot hit lightDir) ** 3.0
                 lightColor = Light.color light
                 in scale lightIntensity lightColor
      (r', g', b') = tosRGB color
   in PixelRGBF r' g' b'

main :: IO ()
main =
  let sphere = Sphere (makeVector 0.0 0.0 (-1.0)) 0.5
      (Just lightDirection) = nonZero (makeVector 0.0 0.0 (-1.0))
      uniformLight = Light.UniformLight (normalize lightDirection) (Color 1.0 0.0 0.0)
      lookupPixel i j = render uniformLight sphere i j
      image = ImageRGBF $ generateImage lookupPixel width height
   in 
      saveBmpImage "test.bmp" image
