module Main where

import Lib
import System.Environment (getArgs)
import Text.Read (readMaybe)

main :: IO ()
main = do
    args <- getArgs
    case args of
        ["decrypt", text] -> putStrLn $ bestGuessDecrypt text
        [nStr, text] -> case readMaybe nStr of
            Just n -> putStrLn $ caesar n text
            Nothing -> putStrLn "First argument must be an integer."
        [text]    -> putStrLn $ rot135 text
        _         -> putStrLn "Usage: caesar <shift> <text>"
