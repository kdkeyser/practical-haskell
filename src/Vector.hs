module Vector where

data Vector = Vector {
    x :: Float,
    y :: Float,
    z :: Float
} deriving Show

-- | Here we access the fields of the Vector with the functions x, y, and z
dot :: Vector -> Vector -> Float
dot a b = x a * x b + y a * y b + z a * z b

len2 :: Vector -> Float
len2 v = dot v v

-- | We can also pattern match on the Vector to access its fields
add :: Vector -> Vector -> Vector
add (Vector ax ay az) (Vector bx by bz) = Vector (ax+bx) (ay+by) (az+bz)

sub :: Vector -> Vector -> Vector
sub (Vector ax ay az) (Vector bx by bz) = Vector (ax-bx) (ay-by) (az-bz)
