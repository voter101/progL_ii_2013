ssm :: Ord a => [a] -> [a]
ssm xs = foldr f [] xs where
    f a [] = [a]
    f a x = a : filter( (<) a ) x
