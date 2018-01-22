module Chess where
    import Data.Char
    --import ChessBoard

    type Board = [[Square]]
    
    initialBoardStr::String
    initialBoardStr = unlines ["rnbqkbnr"
                                ,"pppppppp"
                                ,"        "
                                ,"        "
                                ,"        "
                                ,"        "
                                ,"PPPPPPPP"
                                ,"RNBQKBNR"
                                ]
    
    readBoard :: String -> Board
    readBoard = map readRow . lines
            where readRow = map readSquare
    
    showBoard :: Board -> String
    showBoard = unlines . map showRow
            where showRow = map showSquare
    
    type Square = Maybe Piece
    
    data Piece = Piece PColor PType deriving(Show)
    data PColor = White | Black deriving(Show)
    data PType = Pawn | Knight | Bishop | Rook | Queen | King deriving(Show)
    
    showSquare :: Square->Char
    showSquare = maybe ' ' showPiece
    
    readSquare :: Char->Square
    readSquare = readPiece
    
    showPiece :: Piece -> Char
    showPiece (Piece White Pawn) = 'P'
    showPiece (Piece White Knight) = 'N'
    showPiece (Piece White Bishop) = 'B'
    showPiece (Piece White Rook) = 'R'
    showPiece (Piece White Queen) = 'Q'
    showPiece (Piece White King) = 'K'
    showPiece (Piece Black Pawn) = 'p'
    showPiece (Piece Black Knight) = 'n'
    showPiece (Piece Black Bishop) = 'b'
    showPiece (Piece Black Rook) = 'r'
    showPiece (Piece Black Queen) = 'q'
    showPiece (Piece Black King) = 'k'
    
    typeList :: [(Char, PType)]
    typeList = [('p',Pawn),
                ('k',Knight),
                ('b',Bishop),
                ('r',Rook),
                ('q',Queen),
                ('k',King)]
    
    readPiece :: Char -> Maybe Piece
    readPiece 'P' = Just (Piece White Pawn) 
    readPiece 'N' = Just (Piece White Knight)
    readPiece 'B' = Just (Piece White Bishop)
    readPiece 'R' = Just (Piece White Rook)
    readPiece 'Q' = Just (Piece White Queen)
    readPiece 'K' = Just (Piece White King) 
    readPiece 'p' = Just (Piece Black Pawn) 
    readPiece 'n' = Just (Piece Black Knight)
    readPiece 'b' = Just (Piece Black Bishop)
    readPiece 'r' = Just (Piece Black Rook)
    readPiece 'q' = Just (Piece Black Queen)
    readPiece 'k' = Just (Piece Black King) 
    readPiece _ = Nothing
        
    flattenBoard :: [[Square]] -> [Square]
    flattenBoard [] = []
    flattenBoard (x:xs) = x++(flattenBoard xs)

    group :: Int -> [a] -> [[a]]
    group _ [] = []
    group n l = (take n l) : (group n (drop n l))

    groupToBoard :: [Square]->[[Square]]
    groupToBoard = group 8

    calculateMove :: String -> String
    calculateMove = undefined
    
    addSquare :: Square -> Int -> [Square] -> [Square]
    addSquare sq 0 (xs) = sq:tail xs
    addSquare sq i (x:xs) = x:addSquare sq (i-1) xs  

    getSquare :: Int ->[Square]-> Square
    getSquare 0 (x:xs) = x
    getSquare i (x:xs) = getSquare (i-1) (xs) 

    makeMove :: Int -> Int ->[Square]-> [Square]
    makeMove x y b=do
        addSquare Nothing x $ addSquare (getSquare x b) y b

    calculateIndex :: Char->Char-> Int
    calculateIndex x y = (ord x - ord 'A') + abs(ord y - ord '8')*8

    main :: IO ()
    main = do 
        writeFile "Board.txt" initialBoardStr
        
    play :: Either Bool Board->Either Bool Board
    play (Left a) = (Left a) 
    

    x = readBoard initialBoardStr
    y = flattenBoard x
    z = (Piece White Queen)
    z1 = Just z
    d = addSquare z1 12 y 
    e = groupToBoard d

    data Player = AI | Human

    validateMove :: Player->Int->Int->[Square]->Bool
    validateMove x y b = undefined
    
    checkBoardMoveKing :: Int->Int->Bool
    --w pierwszym kroku sprawdzam zmianę w zakresie kolumn
    checkBoardMoveKing x y = if abs((mod x 8) - (mod y 8)) > 1 then
                                False
                                else 
                                    if abs((div x 8) - (div y 8)) > 1 then
                                        False
                                    else
                                        True
    checkBoardMoveKnight :: Int->Int->Bool
    checkBoardMoveKnight x y = if abs((div x 8) - (div y 8)) == 2
                                    && abs((mod x 8) - (mod y 8)) == 1 then True
                                else 
                                    if abs((div x 8) - (div y 8)) == 1
                                        && abs((mod x 8) - (mod y 8)) == 2 then True
                                    else False   

    --checkBoardMoveRook :: Int->Int->Bool
    --checkBoardMoveRook x y = $left x : $right x: $up x: $down x
    --                        where left x  = \x-> if getSquare x-1

    isKing::Square->Bool
    isKing (Just (Piece _ King))=True
    isKing _ = False

    getColor::Square->PColor
    getColor (Just (Piece White _)) = White
    getColor (Just (Piece Black _)) = Black

    rookLeft :: PColor->Int->[Square]->Int
    rookLeft c x b = if getSquare (x-1) b == Nothing then 
                            if x>0 then 
                                rookLeft c (x-1) b
                            else 
                                x
                    else
                        if (getSquare (x-1) b) == Just Piece( c _ ) then 
                            x
                        else
                            if isKing 
                                getSquare (x-1) b == just (Piece White King) then x
                                else rookLeft (x-1) b 

    valiadateKingCheck :: Player->[Square]->Bool
    valiadateKingCheck = undefined --
    validateMoveKing :: Player->Int->Int->[Square]->Bool
    validateMoveKing p x y sx = undefined


    validateMoveRook :: Player->Int->Int->[Square]->Bool
    validateMoveRook = undefined -- [i/8,i/8+1,...,i/8+7][i%8,i%8+1,..,i%8+7] Trochę inaczej

    validateMoveKnight :: Player->Int->Int->[Square]->Bool
    validateMoveKnight = undefined --(+) currIndex -17,-14,-10,-6,+6,+10,+14,+17
    validateMoveBishop :: Player->Int->Int->[Square]->Bool
    validateMoveBishop = undefined -- (+) currIndex [-63-54,...,+54+63] ,[...]
    validateMoveQueen :: Player->Int->Int->[Square]->Bool
    validateMoveQueen p x y b = validateMoveRook p x y b  && validateMoveBishop p x y b
    validateMovePawn :: Player->Int->Int->[Square]->Bool --(+) currindex [+1, i/8+8+-1] 
    validateMovePawn = undefined
    
    