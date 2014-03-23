halve :: [a] -> ([a], [a])
halve xs = (take half xs, drop half xs)
    where half = (length xs) `div` 2

merge :: Ord a -> ([a], [a]) -> [a]
merge (x, []) = x
merge ([], x) = x
merge ((x:xs), (y:ys)) = case x < y of
    True -> x : merge (xs, (y:ys))
    otherwise -> y : merge ((x:xs), ys)

cross :: (a -> c, b -> d) -> (a, b) -> (c, d)
cross (f, g) = pair (f . fst, g . snd)
pair :: (a -> b, a -> c) -> a -> (b, c)
pair (f, g) x = (f x, g x)

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge . cross (msort, msort) . halve $ xs
