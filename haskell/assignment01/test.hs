avg :: Int -> Int -> Int -> Float
avg x y z = (fromIntegral x + fromIntegral y + fromIntegral z) / 3

cti :: Int -> Float
cti x = fromIntegral x

mondrianSplit :: Float -> Int -> Bool
mondrianSplit r w
  | r*(1.5*fromIntegral(w)-120)+120 < fromIntegral w = True
  | otherwise                                        = False

myRound :: Int -> Float -> Int
myRound x y = dostuff
  where
    dostuff = round(fromIntegral x * y)

test :: Int -> Float -> Int
test x y = round(fromIntegral x*y)

percentage :: Float -> Int -> Int
percentage f i = round(f*fromIntegral i)

testing :: Int -> [Int]
testing 1 = [a | a <- [1..10], a<5]
testing 2 = [d `div` 2 | d <- [1..10], (d+1) `div` 2 == d `div` 2]
testing 3 = [e | e <- [1..10], e>1, e<5]
