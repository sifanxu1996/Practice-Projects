createTreeHelper :: [[Int]] -> Int -> [[Int]]
createTreeHelper [] _ = []
createTreeHelper (x:xs) n
  | n == 0    = (take ((length x) `div` 2) x) : (createTreeHelper xs n)
  | otherwise = (drop ((length x) `div` 2) x) : (createTreeHelper xs n)

powerOf2 :: Int -> Bool
powerOf2 1 = True
powerOf2 x
  | x `rem` 2 == 0 = powerOf2 (x `div` 2)
  | otherwise      = False


optimizeTree :: QuadTree -> QuadTree
optimizeTree (Leaf a) = (Leaf a)
optimizeTree (Node (Leaf a) (Leaf b) (Leaf c) (Leaf d))
  | a == b && a == c && a == d = (Leaf a)
  | otherwise = (Node (Leaf a) (Leaf b) (Leaf c) (Leaf d))
optimizeTree (Node a b c d) = (Node (optimizeTree a) (optimizeTree b) (optimizeTree c) (optimizeTree d))
