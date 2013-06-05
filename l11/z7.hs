-- 1) skończy się
-- 2) skończy się 
-- 3) skończy się
-- 4) rozbiega się
-- 5) rozbiega się
-- 6) zapętli się
-- 7) zapętli się
-- 8) rozbiega się 

-- let f [] = 0; f(_:xs) = 2 + f xs in f ones 

ones :: [Integer]
ones = 1 : ones
