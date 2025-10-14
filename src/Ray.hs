module Ray where

import VectorGADT

data Ray = Ray {
    origin :: AnyVector,
    direction :: UnitVector
} deriving Show

