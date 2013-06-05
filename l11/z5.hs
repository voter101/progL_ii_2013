length1 :: [a] -> Int
length1 = foldr (\ _ x -> x + 1) 0 

length2 :: [a] -> Int
length2 = foldl (\ x _ -> x + 1) 0

app :: [a] -> [a] -> [a]
app = flip $ foldr (:)

concat :: [[a]] -> [a]
concat = foldr app []

reverse1 :: [a] -> [a]
reverse1 xs = foldl(flip (:)) [] xs

sum1 :: Num a => [a] -> a
sum1 = foldl (+) 0
