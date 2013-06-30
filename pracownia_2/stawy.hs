-- Programowanie (L) 2013 - Pracownia nr. 2
--
-- Wersja 4. - "Stawy i groble"
--
-- Wiktor Mociun, indeks: 258354
--
-- Uwaga: Komentarze i nazwy funkcji są w języku angielskim
-- Uwaga: Wyniki wyświeltane są w ASCII arcie

import Data.Set
import Data.List
import Data.Char
import Data.String
import Control.Monad
import System.Environment
import System.IO

-- Main program

main :: IO ()
main = do
    args  <- getArgs
    content <- readFile (head args)
    let xs@(a : b : c : []) = splitInput (Data.List.filter (\x -> isSpace x == False) content)
    let solutions = nub $ solve (read b::Integer) (read a::Integer) (read c::[(Integer,Integer,Integer)])
    printSolutions solutions

solve :: Integer -> Integer -> [(Integer, Integer, Integer)] -> [[[Char]]]
solve sizeX sizeY ponds = do
    solution <- genPonds sizeX sizeY pondsSorted base -- Solution candidates
    guard $ noDikeSquare sizeX (sizeX, sizeY) solution == True 
    guard $ dikeConsistent sizeX sizeY solution == True
    let result  = buildTable sizeX sizeY 1 solution pondsSorted -- Result to build
    return result
    where base = genBase ponds -- Optimization: Let's put all pond-start fields as base "fieldsTaken" set
          pondsSorted = sortBy pondsSort ponds -- Optimization: Let's start from the smallest pond

pondsSort (_,_,size1) (_,_,size2) = compare size1 size2 -- Aux function for sorting

genBase :: [(Integer, Integer, Integer)] -> Set (Integer, Integer)
genBase [] = Data.Set.empty
genBase ((y,x,_):xs) = Data.Set.insert (x,y) (genBase xs)

-- Ponds generation

genPonds :: Integer -> Integer -> [(Integer, Integer, Integer)] -> Set (Integer, Integer) -> [Set (Integer, Integer)]
genPonds _ _ [] fieldsTaken = [fieldsTaken]
genPonds sizeX sizeY ((y,x,size):xs) fieldsTaken = do
    ponds <- genPond sizeX sizeY size fieldsTaken (x,y)
    let fieldsTaken2 = Data.Set.union (Data.Set.fromList ponds) fieldsTaken
    solution <- genPonds sizeX sizeY xs fieldsTaken2
    return solution
    
genPond :: Integer -> Integer -> Integer -> Set (Integer, Integer) -> (Integer, Integer) -> [[(Integer, Integer)]]
genPond sizeX sizeY size fieldsTaken (x,y) = genPondAux sizeX sizeY size newFieldsTaken Data.Set.empty [] (x,y)
    where newFieldsTaken = Data.Set.delete (x,y) fieldsTaken

genPondAux :: Integer -> Integer -> Integer -> Set (Integer, Integer) -> Set (Integer, Integer) -> [(Integer,Integer)] -> (Integer, Integer) -> [[(Integer, Integer)]]
genPondAux sizeX sizeY 1 fieldsTaken path stack (x,y) = if fieldOk sizeX sizeY (x,y) fieldsTaken path then [[(x,y)]]
    else if Data.List.null stack then []
    else genPondAux sizeX sizeY 1 fieldsTaken path (tail stack) (head stack)
genPondAux sizeX sizeY fieldsLeft fieldsTaken path stack (x,y) = if fieldOk sizeX sizeY (x,y) fieldsTaken path == False then [] else
    do (x1,y1) <- newStack
       subPond <- genPondAux sizeX sizeY (fieldsLeft - 1) fieldsTaken newPath (tail newStack) (x1,y1)
       return ((x,y):subPond)
    where
       newPath = Data.Set.insert (x,y) path
       newStack = [(x,y-1),(x,y+1),(x-1,y),(x+1,y)] ++ stack

-- Ponds generation: Checking while generating single ponds

fieldOk :: Integer -> Integer -> (Integer, Integer) -> Set (Integer, Integer) -> Set (Integer, Integer) -> Bool
fieldOk sizeX sizeY (x,y) fieldsTaken path 
    | x > sizeX || y > sizeY                    = False
    | x < 1 || y < 1                            = False
    | fieldEmpty (x,y) path == False            = False
    | neighbourExists (x,y) fieldsTaken == True = False
    | otherwise                                 = True

neighbourExists :: (Integer,Integer) -> Set (Integer, Integer) -> Bool
neighbourExists (x,y) set =
   if fieldEmpty ((x - 1),y) set == False ||
      fieldEmpty ((x + 1),y) set == False ||
      fieldEmpty (x,(y - 1)) set == False ||
      fieldEmpty (x,(y + 1)) set == False then True else False

fieldEmpty :: (Integer,Integer) -> Set (Integer,Integer) -> Bool
fieldEmpty (x,y) set 
    | x == 0 || y == 0                  = True
    | Data.Set.member (x,y) set == True = False
    | otherwise      			= True

-- Ponds generation: solution candidate checking

noDikeSquare :: Integer -> (Integer, Integer) -> Set (Integer, Integer) -> Bool
noDikeSquare 1 (_,_) _ = True
noDikeSquare _ (1,2) set = True
noDikeSquare sizeX (1,y) set = noDikeSquare sizeX (sizeX,(y-1)) set
noDikeSquare sizeX (x,y) set = if
    fieldEmpty (x,y) set         == True &&
    fieldEmpty ((x-1),y) set     == True &&
    fieldEmpty (x,(y-1)) set     == True &&
    fieldEmpty ((x-1),(y-1)) set == True then False else noDikeSquare sizeX ((x-1), y) set

-- Dike consistency check

dikeConsistent :: Integer -> Integer -> Set (Integer, Integer) -> Bool
dikeConsistent sizeX sizeY solution = let x = buildDikePath sizeX (sizeX, sizeY) solution
                                      in Data.Set.null (goDikeGo sizeX sizeY (Data.Set.findMin x) x)

buildDikePath :: Integer -> (Integer, Integer) -> Set (Integer, Integer) -> Set (Integer, Integer)
buildDikePath _ (0,1) _ = Data.Set.empty
buildDikePath sizeX (0,y) set = buildDikePath sizeX (sizeX,y-1) set
buildDikePath sizeX (x,y) set 
    | Data.Set.member (x,y) set == False = Data.Set.insert (x,y) $ buildDikePath sizeX (x-1,y) set
    | otherwise = buildDikePath sizeX (x-1,y) set

goDikeGo :: Integer -> Integer -> (Integer, Integer) -> Set (Integer, Integer) -> Set (Integer, Integer)
goDikeGo sizeX sizeY (x,y) set = 
    if x < 1 || y < 1 || x > sizeX || y > sizeY || Data.Set.member (x,y) set == False then set else
    if Data.Set.size set < 2 then Data.Set.empty else
    if r1 == Data.Set.empty then r1 else
    if r2 == Data.Set.empty then r2 else
    if r3 == Data.Set.empty then r3 else r4
    where newSet = Data.Set.delete (x,y) set
          r1 = goDikeGo sizeX sizeY (x-1, y) newSet
          r2 = goDikeGo sizeX sizeY (x+1, y) r1
          r3 = goDikeGo sizeX sizeY (x, y-1) r2
          r4 = goDikeGo sizeX sizeY (x, y+1) r3                 

-- Result building

buildTable :: Integer -> Integer -> Integer -> Set (Integer, Integer) -> [(Integer, Integer, Integer)] -> [[Char]]
buildTable sizeX sizeY y set ponds = if y > sizeY then [] else
    reverse (buildRow sizeX y set ponds) : buildTable sizeX sizeY (y+1) set ponds

buildRow :: Integer -> Integer -> Set (Integer, Integer) -> [(Integer, Integer, Integer)] -> [Char]
buildRow 0 _ _ _ = []
buildRow x y set ponds = a ++ (buildRow (x-1) y set ponds)
    where a = buildField x y set ponds

buildField :: Integer -> Integer -> Set (Integer,Integer) -> [(Integer,Integer,Integer)] -> [Char]
buildField x y set ponds
    | num /= 0                          = show num
    | Data.Set.member (x,y) set == True = ['_']
    | otherwise                         = ['*']
    where num = numberedField ponds (x,y)

numberedField :: [(Integer, Integer, Integer)] -> (Integer,Integer) -> Integer
numberedField [] (_,_) = 0
numberedField ((ys,xs,s):zs) (x,y) = if (x,y) == (xs,ys) then s else numberedField zs (x,y)

-- Result Printing

printSolutions :: [[String]] -> IO ()
printSolutions [] = do { putStr("") }
printSolutions (x:xs) = do { putStrLn(unlines x); printSolutions xs }

-- Input cleaning

splitInput :: [Char] -> [[Char]]
splitInput [] = []
splitInput xs = x : splitInput (tail (xs Data.List.\\ x))
    where x = takeWhile (\x -> ord x /= 46) xs
