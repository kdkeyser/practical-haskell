module VectorGADT
  ( VectorGADT,
    UnitVector,
    NonZeroVector,
    AnyVector,
    zeroVector,
    makeVector,
    getRawVector,
    nonZero,
    dot,
    len2,
    add,
    sub,
    mul,
    normalize,
  )
where

data Zero

data NonZero a

data UnitLength

data Unknown

data Vector = Vector
  { x :: Float,
    y :: Float,
    z :: Float
  }
  deriving (Show)

data VectorGADT a where
  Zero :: VectorGADT Zero
  Unit :: Vector -> VectorGADT (NonZero UnitLength)
  NonZeroUnknownLength :: Vector -> VectorGADT (NonZero Unknown)
  Unknown :: Vector -> VectorGADT Unknown

deriving instance Show (VectorGADT a)

type UnitVector = VectorGADT (NonZero UnitLength)

type NonZeroVector a = VectorGADT (NonZero a)

type AnyVector = VectorGADT Unknown

zeroVector :: VectorGADT Zero
zeroVector = Zero 

makeVector :: Float -> Float -> Float -> AnyVector
makeVector x y z = Unknown (Vector x y z)

getRawVector :: VectorGADT a -> Vector
getRawVector Zero = Vector 0.0 0.0 0.0
getRawVector (Unit v) = v
getRawVector (Unknown v) = v
getRawVector (NonZeroUnknownLength v) = v

nonZero :: VectorGADT a -> Maybe (VectorGADT (NonZero Unknown))
nonZero Zero = Nothing
nonZero v =
  let v' = getRawVector v
   in if x v' == 0.0 && y v' == 0.0 && z v' == 0.0
        then Nothing
        else Just (NonZeroUnknownLength v')

dot :: VectorGADT a -> VectorGADT b -> Float
dot a b =
  let a' = getRawVector a
      b' = getRawVector b
   in x a' * x b' + y a' * y b' + z a' * z b'

len2 :: VectorGADT a -> Float
len2 v = dot v v

add :: VectorGADT a -> VectorGADT b -> VectorGADT Unknown
add a b =
  let (Vector ax ay az) = getRawVector a
      (Vector bx by bz) = getRawVector b
   in Unknown (Vector (ax + bx) (ay + by) (az + bz))

sub :: VectorGADT a -> VectorGADT b -> VectorGADT Unknown
sub a b =
  let (Vector ax ay az) = getRawVector a
      (Vector bx by bz) = getRawVector b
   in Unknown (Vector (ax - bx) (ay - by) (az - bz))

mul :: Float -> VectorGADT a -> VectorGADT Unknown
mul s v =
  let (Vector x y z) = getRawVector v
   in Unknown (Vector (s * x) (s * y) (s * z))

normalize :: VectorGADT (NonZero a) -> VectorGADT (NonZero UnitLength)
normalize v = Unit $ getRawVector (mul (1 / sqrt (len2 v)) v)