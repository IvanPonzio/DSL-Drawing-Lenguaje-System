module Dibujos.GrillaA (
    grillaAConf,
    grilla
) where

import Dibujo (Dibujo, juntar, apilar, figura)
import Graphics.Gloss (Picture, blue, black, color, line, pictures, red, white, text, translate, scale)
import FloatingPic (FloatingPic, Output, grid, zero, half)
import Interp (Conf(..), interp)

-- Formacion de la tupla a tipo String
coordText :: Int -> Int -> String
coordText i j = "(" ++ show i ++ "," ++ show j ++ ")"

data Color = Negro
    deriving (Show, Eq)

type Basica = (Float, Float, String, Color)

colorear :: Color -> Picture -> Picture
colorear Negro = color black

interpBas :: Output Basica
interpBas (fila, colum, par, c) _ _ _ = colorear c $ translate fila colum $ scale 0.1 0.1 (text par)

row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d:ds) = juntar (fromIntegral $ length ds) 1 d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d:ds) = apilar (fromIntegral $ length ds) 1 d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

grillaCoord :: Dibujo Basica
grillaCoord = grilla [[figura ((400*((fromIntegral y/8))) + 15, (400*((fromIntegral x/8))) + 20, coordText (7-x) (y) , Negro) | x <- [0..7]] | y <- [7,6,5,4,3,2,1,0]]

grillaAConf :: Conf
grillaAConf = Conf {
    name = "Grilla",
    pic = interp interpBas grillaCoord
}
