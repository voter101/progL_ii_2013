-- Definicja scanl z książki. Zapewne taka była na wykładzie (nie notuję na
-- wykładach)
book_scanl f e [] = [e]
book_scanl f e (x:xs) = e : book_scanl f (f e x) xs

ex_scanr :: (a -> b -> b) -> b -> [a] -> [b]
ex_scanr f a = map (foldr f a) . tails

scanr2 :: (a -> b -> b) -> b -> [a] -> [b]
scanr2 f e [] = [e]
scanr2 f e xl@(x:xs) = foldr f e xl : scanr2 f e xs

tails :: [a] -> [[a]]
tails [] = [[]] 
tails xl@(x:xs) = xl : tails xs
