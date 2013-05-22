msortn :: Ord a => [a] -> Int -> [a]
msortn _ 0 = []
msortn [x] 1 = [x]
msortn (x:_) 1 = [x]
msortn x n = merge ((msortn x half), msortn (drop half x) (n - half))
    where half = n `div` 2

msort xs = msortn xs (length xs)

merge (x,[]) = x
merge ([],x) = x
merge ((x:xs),(y:ys)) = case x < y of
	True ->	x : merge (xs,(y:ys))
	otherwise ->	y:merge ((x:xs),ys)
