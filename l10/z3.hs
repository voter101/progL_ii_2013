merge_unique :: Ord a => [a] -> [a] -> [a]
merge_unique x [] = x
merge_unique [] x = x
merge_unique (x:xs) (y:ys)
    | (x == y)  = x : (merge_unique xs ys)
    | (x < y)   = x : (merge_unique xs (y:ys))
    | otherwise = y : (merge_unique (x:xs) ys)

d235 :: [Integer]
d235 = 1 : foldl merge_unique [] [ map (n *) d235 | n <- [2,3,5] ]
