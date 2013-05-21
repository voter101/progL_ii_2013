fib:: Integer -> Integer
fib n = aux n (0,1) where
    aux n (a,b) 
        | (n == 0) = a
        | otherwise = abs (n-1) (b, a+b)
