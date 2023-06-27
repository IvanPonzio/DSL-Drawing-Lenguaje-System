
module Dibujos.Escher (
    interpBas,
    escherConf,
    ) where

import Graphics.Gloss (Picture (Blank),  blue, color, line, pictures, red, white, polygon)


import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar, cuarteto, r270, r180, encimar4)
import FloatingPic (Output, half, zero, vacia)
import Interp (Conf(..), interp)
import Grilla (grilla)


data DibEscher = Triangulo | Nada
            deriving (Show, Eq)

type Escher = DibEscher

interpBas :: Output Escher
interpBas Triangulo a b c =  pictures [line $ triangulo a b c, cara a b c]
  where
      triangulo a b c = map (a V.+) [zero, c, b, zero]
      cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)
interpBas Nada _ _ _ = Blank

nada :: Dibujo Escher
nada = figura Nada

triang :: Dibujo Escher
triang = figura Triangulo

ertriang :: Dibujo Escher -> Dibujo Escher
ertriang = espejar . rot45


dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar triang $ encimar (ertriang triang) (r270 (ertriang triang))


dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar (encimar (ertriang triang) (rotar (ertriang triang)))
                    (encimar (rotar (rotar (ertriang triang))) (rotar (rotar (rotar (ertriang triang)))))



-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 0 _ = cuarteto nada nada nada (dibujoU triang)
esquina n p = cuarteto (esquina (n-1) triang ) (lado (n-1) triang ) (rotar (lado (n-1) triang )) (dibujoU triang)


lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = cuarteto nada nada (rotar (dibujoT triang)) (dibujoT triang)
lado n p = cuarteto (lado (n-1) triang) (lado (n-1) triang) (rotar (dibujoT triang)) (dibujoT triang)



noneto p q r s t u v w x = grilla [[p, q, r], 
                                  [s, t, u], 
                                  [v, w, x]]


-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n f = noneto p q r s t u v w x
    where
        p = esquina n (figura f)
        q = lado n (figura f)
        r = r270 ( esquina n (figura f))
        s = rotar (lado n (figura f))
        t = dibujoU (figura f)
        u = r270 (lado n (figura f))
        v = rotar (esquina n (figura f))
        w = r180 (lado n (figura f))
        x = r180 (esquina n (figura f))


escherConf :: Conf
escherConf = Conf {
    name = "Escher",
    pic = interp interpBas (escher 8 Triangulo)
}
