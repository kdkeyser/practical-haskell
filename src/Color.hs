module Color(
    Color (..),
    scale,
    blend,
    tosRGB
) where

data Color = Color Float Float Float

scale :: Float -> Color -> Color
scale d (Color r g b) = Color (d*r) (d*g) (d*b)

blend :: Color -> Color -> Color 
blend (Color r1 g1 b1) (Color r2 g2 b2) =
  Color (r1+r2) (g1+g2) (b1+b2)

srgb :: Float -> Float
srgb x =
  if x <= 0.0031308 then 12.92 * x else 1.055*(x ** (1.0 / 2.4)) - 0.05

tosRGB :: Color -> (Float, Float, Float)
tosRGB (Color r g b) =
    (srgb r, srgb g, srgb b)