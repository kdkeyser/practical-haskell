module Light where

import Color
import VectorGADT

data UniformLight = UniformLight {
    direction :: UnitVector,
    color :: Color
} deriving Show

