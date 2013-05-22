nat2 :: [(Integer, Integer)]
nat2 = (0, 0) : [(case (x, y) of 
    (x, 0) -> (0, x+1)
    otherwise -> (x+1,y-1)) | (x, y) <- nat2]

-- Wersja z wykładu, ładna bo w jednej linijce. :D

natTWi :: [(Integer, Integer)]
natTWi = [(y, x-y) | x <- [0..], y <- [0..x]]
