nat2 :: [(Integer, Integer)]
nat2 = (0, 0) : [(case (x, y) of 
    (x, 0) -> (0, x+1)
    otherwise -> (x+1,y-1)) | (x, y) <- nat2]
