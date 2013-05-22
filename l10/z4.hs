msortn :: Ord a => [a] -> Int -> [a]
msortn _ 0 = []
msortn (x:_) 1 = [x]
msortn xs n = merge ((msortn xs half), msortn (drop half xs) (n - half))
    where half = n `div` 2

msort xs = msortn xs (length xs)

merge (x,[]) = x
merge ([],x) = x
merge ((x:xs),(y:ys)) = case x < y of
	True ->	x : merge (xs,(y:ys))
	otherwise ->	y:merge ((x:xs),ys)
