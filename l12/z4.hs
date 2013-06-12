prodMonad :: Integral a => [a] -> Maybe a
prodMonad [] = Nothing
prodMonad xs = foldM (\w x -> if(x == 0) then Nothing else Just(w * x)) 1 xs

foldM :: (a -> b -> Maybe a) -> a -> [b] -> Maybe a
foldM _ a [] = return a
foldM f a (x:xs) = f a x >>= ( \y -> foldM f y xs )

prod xs = if n == Nothing then 0 else fromJust n where
    n = prodMonad xs

fromJust :: Maybe a -> a
fromJust Nothing = error "yuck!"
fromJust (Just x) = x
