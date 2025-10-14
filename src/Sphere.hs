module Sphere where

import VectorGADT
import Ray

data Sphere = Sphere {
    center :: AnyVector,
    radius :: Float
} deriving Show

-- | hits determines if a ray hits the sphere, returning the normal at the hit point if it does
hits :: Sphere -> Ray -> Maybe UnitVector
hits (Sphere center radius) ray =
    let oc = sub (origin ray) center
        a = dot (direction ray) (direction ray)
        b = 2.0 * dot oc (direction ray)
        c = dot oc oc - radius * radius
        discriminant = b * b - 4 * a * c
    in if discriminant < 0
        then Nothing
        else
            let t = (-b - sqrt discriminant) / (2.0 * a)
                hitPoint = add (origin ray) (mul t (direction ray))
                normal = sub hitPoint center
            in normalize <$> nonZero normal
