roots :: (Double, Double, Double) -> [Double]
roots (a, b, c) =
    if a == 0 then [(-b) / c] else
        case compare delta 0 of
        EQ -> [-b/(2*a)]
        GT -> [(-b - sqrt(delta))/(2*a), (-b + sqrt(delta))/(2*a)]
        LT -> []
        where delta = (b*b) - (4 * a * c)

data Roots = No | One Double | Two (Double, Double) deriving Show 
roots2 :: (Double, Double, Double) -> Roots
roots2 (a, b, c)
    if a == 0 then One((-b) / c) else
        case compare delta 0 of
        EQ -> One (-b/(2*a))
        GT -> Two ((-b - sqrt(delta))/(2*a), (-b + sqrt(delta))/(2*a))
        LT -> No
        where delta = (b*b) - (4 * a * c)
