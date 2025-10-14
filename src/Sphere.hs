module Sphere where

import Vector
import Ray

data Sphere = Sphere {
    center :: Vector,
    radius :: Float
} deriving Show

hits :: Sphere -> Ray -> Bool
hits (Sphere c r) ray =
    let oc = sub (origin ray) c
        a = dot (direction ray) (direction ray)
        b = 2.0 * dot oc (direction ray)
        c' = dot oc oc - r * r
        discriminant = b * b - 4 * a * c'
    in discriminant > 0
