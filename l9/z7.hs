newtype FSet a = FSet (a -> Bool)
empty :: FSet a
empty = FSet f where f _ = False

singleton :: Ord a => a -> FSet a
singleton a = FSet f where
    f x = (x == a)

fromList :: Ord a => [a] -> FSet a
fromList xs = FSet (f xs) where
    f [] _ = False
    f (x:xs) a = (a == x) || (f xs a)

member :: Ord a => a -> FSet a -> Bool
member a (FSet x) = x a

union :: Ord a => FSet a -> FSet a -> FSet a
union f1 f2 = FSet f where
    f a = (member a f1) || (member a f2)

intersection :: Ord a => FSet a -> FSet a -> FSet a
intersection f1 f2 = FSet f where
    f a = (member a f1) && (member a f2)
