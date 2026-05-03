import Control.Monad

grid :: Int -> Int -> Int -> [[Int]]
grid width height value = [[value | _ <- [0..width - 1]] | _ <- [0..height - 1]]

draw :: Int -> Char
draw 0 = '.'
draw 1 = '#'

textRepresentation :: [Int] -> String
textRepresentation row = foldl (\acc y -> acc ++ [draw y]) "" row

printGrid :: [[Int]] -> IO [()]
printGrid grid = sequence $ map (putStrLn . textRepresentation) $ grid

query :: [[Int]] -> Int -> Int -> Int
query grid x y =
    grid !! x !! y

-- main :: IO [()]
main = do
    let theGrid = grid 20 10 0 in
        printGrid theGrid
        -- putStrLn $ show $ query theGrid 0 0

-- :l conway.hs
