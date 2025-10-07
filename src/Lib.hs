module Lib where


type Alphabet = [Char]

lowerAlphabet :: Alphabet
lowerAlphabet = ['a'..'z']

upperAlphabet :: Alphabet
upperAlphabet = ['A'..'Z']

digits :: Alphabet
digits = ['0'..'9']

isUpper :: Char -> Bool
isUpper c = c `elem` upperAlphabet

isLower :: Char -> Bool
isLower c = c `elem` lowerAlphabet

isDigit :: Char -> Bool
isDigit c = c `elem` digits

isMisc :: Char -> Bool
-- isMisc c = not (isUpper c || isLower c || isDigit c)
isMisc c = c `notElem` (lowerAlphabet ++ upperAlphabet ++ digits)


listLength :: [Char] -> Int
listLength [] = 0
listLength (x:xs) = 1 + listLength (xs)

elementIndex :: Char -> [Char] -> Maybe Int
elementIndex c xs = lookup c $ zip xs [0..]

indexOf :: Char -> Alphabet -> Int
lengthOf _ [] = undefined
indexOf c (x:xs) 
    | c==x = 0
    | otherwise = 1 + indexOf c xs

alphabetRot:: Alphabet -> Int -> Char -> Char
alphabetRot alphabet n ch = alphabet !! ((indexOf ch alphabet + n) `mod` listLength alphabet)

rotChar :: Int -> Char -> Char
-- rotChar n ch =
--     if isLower ch 
--         then alphabetRot lowerAlphabet n ch 
--     else if isUpper ch
--         then alphabetRot upperAlphabet n ch
--     else if isDigit ch 
--         then alphabetRot digits n ch
--     else ch
rotChar n ch 
    | isLower ch = alphabetRot lowerAlphabet n ch
    | isUpper ch = alphabetRot upperAlphabet n ch
    | isDigit ch = alphabetRot digits n ch
    | otherwise = ch

caesar :: Int -> String -> String
-- caesar _ [] = []
-- caesar n (x:xs) = rotChar n x : caesar n xs
caesar n message = map (\ch -> rotChar n ch) message


rot13 :: String -> String
rot13 message = caesar 13 message

rot135 :: String -> String
rot135  [] = []
rot135 (x:xs) 
    | isDigit x = rotChar 5 x : rot135 xs
    | otherwise = rotChar 13 x : rot135 xs


count :: Char -> String -> Int
count _ [] = 0
count c (x:xs) 
    | c == x = 1 + count c xs
    | otherwise = count c xs

frequency :: String -> [(Char, Int)]
-- frequency text = [(ch, count ch text) | ch <- filter (`elem` alph) (unique text)]
--     where
--         alph = lowerAlphabet ++ upperAlphabet ++ digits
--         unique [] = []
--         unique (y:ys)
--             | y `elem` ys = unique ys
--             | otherwise = y : unique ys
frequency text =
    let alph = lowerAlphabet ++ upperAlphabet ++ digits
    in [(ch, count ch text) | ch <- alph]

nonZeroFrequencies :: String -> [(Char, Int)]
nonZeroFrequencies text = filter (\(_, n) -> n > 0) (frequency text)

bestGuessDecrypt :: String -> String
bestGuessDecrypt cipherText =
    let freqs = frequency cipherText
        alph = lowerAlphabet ++ upperAlphabet ++ digits
        -- mostCommon = fst $ maximumBy (\(_,a) (_,b) -> compare a b) freqs
        mostCommon = fst $ maximumBy freqs
        shift = (indexOf mostCommon alph - indexOf 'e' alph) `mod` listLength alph
    in caesar (-shift) cipherText

-- maximumBy :: (a -> a -> Ordering) -> [a] -> a
-- maximumBy _ [] = error "maximumBy: empty list"
-- maximumBy cmp (x:xs) = foldl choose x xs
--   where
--     choose a b = if cmp b a == GT then b else a

maximumBy :: [(Char, Int)] -> (Char, Int)
maximumBy [] = error "maximumBy: empty list"
maximumBy (x:xs) = foldl choose x xs
    where choose a b = if snd b > snd a then b else a 