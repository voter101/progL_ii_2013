fib:: Integer -> Integer
fib n = abs n (0,1) where
    abs n (a,b) 
        | (n == 0) = a
        | otherwise = abs (n-1) (b, a+b)
