-- Definicja scanl z książki. Zapewne taka była na wykładzie (nie notuję na
-- wykładach)
book_scanl f e [] = [e]
book_scanl f e (x:xs) = e : book_scanl f (f e x) xs

ex_scanr :: (a -> b -> b) -> b -> [a] -> [b]
ex_scanr f a = map (foldr f a) . tails

-- To się raczej nie skompiluje ale ładnie się czyta trololo
scanr f e x:xs = map(foldr f e)(tails x:xs)
          = map(foldr f e) ((x:xs) tails xs)
          = foldr f e (x:xs) : map(foldr f e)(tails xs)
          = f x (foldr f e xs) : (scanr f e xs)
          = f x (head z) z where
            z = scanr f e xs

scanr2 :: (a -> b -> b) -> b -> [a] -> [b]
scanr2 f e [] = [e]
scanr2 f e xl@(x:xs) = foldr f e xl : scanr2 f e xs

scanr3 :: (a -> b -> b) -> b -> [a] -> [b]
scanr3 f e x:xs = f x (head(scanr3 f e xs) : scanr2 f e xs

tails :: [a] -> [[a]]
tails [] = [[]] 
tails xl@(x:xs) = xl : tails xs
