module EnumPairs where

import Prelude hiding (Real)

type Pair = (Integer, Integer)
type Real = Double
type Rat  = (Integer, Integer)

nextPairS :: Pair -> Pair
nextPairS (m,0) = (0, m+1)
nextPairS (m,n) = (m+1, n-1)

nextPairM :: Pair -> Pair
nextPairM (0,n) = (n+1, 0)
nextPairM (m,n) = if m > n then (m,n+1) else (m-1, n)

enumPairsM :: [Pair]
enumPairsM = iterate nextPairM (0,0)

enumPairsS :: [Pair]
enumPairsS = iterate nextPairS (0,0)

enumRatsReps :: [Pair] -> [Rat]
enumRatsReps = filter isRat
    where isRat (p,q) = q /= 0

enumRats :: [Rat] -> [Rat]
enumRats = filter coprime
    where coprime (p,q) = gcd p q == 1

enumRatsRepsM = enumRatsReps enumPairsM
enumRatsRepsS = enumRatsReps enumPairsS
enumRatsM     = enumRats     enumPairsM
enumRatsS     = enumRats     enumPairsS

ratApprox :: [Rat] -> Real -> Real -> (Integer, Rat)
ratApprox qs x e = head [ (i,(p,q)) | (i,(p,q)) <- idxRats, distance (p,q) x < e ]
    where
        idxRats          = zipWith (,) [0..] qs
        distance (p,q) x = abs $ (p `over` q) - x
        p `over` q       = fromInteger p / fromInteger q
