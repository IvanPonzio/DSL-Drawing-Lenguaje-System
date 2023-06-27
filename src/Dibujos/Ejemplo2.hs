module Dibujos.Ejemplo2 (
    interpBas,
    ejemplo2Conf
) where

import Graphics.Gloss (white, line, polygon, pictures)

import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo (Dibujo, figura, rotar, apilar, juntar, encimar, ciclar, cuarteto, r180, r270, encimar4)
import FloatingPic (Output, half, zero)
import Interp (Conf(..), interp)

type Basica = ()

ejemplo :: Dibujo Basica
ejemplo = encimar4 (ciclar (cuarteto a b c d))
  where
    a = figura ()
    b = apilar 0.5 0.5 (figura ()) (figura ())
    c = juntar 0.5 0.5 (figura ()) (figura ())
    d = encimar (figura ()) (figura ())

interpBas :: Output Basica
interpBas () a b c = pictures [line $ triangulo a b c, cara a b c]
  where
    triangulo a b c = map (a V.+) [zero, c, b, zero]
    cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)

ejemplo2Conf :: Conf
ejemplo2Conf = Conf {
    name = "Ejemplo2",
    pic = interp interpBas ejemplo
}

