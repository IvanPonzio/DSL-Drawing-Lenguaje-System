module Main (main) where

import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import System.Console.GetOpt (ArgDescr(..), ArgOrder(..), OptDescr(..), getOpt)
import System.Environment (getArgs)
import Text.Read (readMaybe)
import Dibujos.Feo (feoConf)
import Dibujos.Escher (escherConf)
import Interp (Conf(name), initial)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.GrillaA (grillaAConf)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, feoConf, escherConf, grillaAConf]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
    putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) n = 
    if n == name c then
        initial c 400
    else
        initial' cs n

printDibujos :: [Conf] -> IO ()
printDibujos configs =
    putStrLn $ "Dibujos disponibles: " ++ intercalate ", " (map name configs)

-- Función principal
main :: IO ()
main = do
    args <- getArgs
    if head args == "--lista"
        then printDibujos configs
        else initial' configs $ head args
