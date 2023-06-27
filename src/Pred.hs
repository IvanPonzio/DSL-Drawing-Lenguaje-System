module Pred
  ( Pred,
    cambiar,
    anyDib,
    allDib,
    orP,
    andP,
  )
where

import Dibujo


type Pred a = a -> Bool

-- cambia todas las figuras de un dibujo aplicandoles la función que se pasa como argumento siempre
-- y cuando se cumpla el predicado
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar predicado1 f = mapDib f'
  where
    f' fig | predicado1 fig = f fig
           | otherwise = figura fig


anyDib :: Pred a -> Dibujo a -> Bool
anyDib p = foldDib p fRotar fEspejar fRot45 fApilar fJuntar fEncimar
  where
    fRotar b = b
    fEspejar b = b
    fRot45 b = b
    fApilar _ _ b1 b2 = b1 || b2
    fJuntar _ _ b1 b2 = b1 || b2
    fEncimar b1 b2 = b1 || b2

allDib :: Pred a -> Dibujo a -> Bool
allDib p = foldDib p fRotar fEspejar fRot45 fApilar fJuntar fEncimar
  where
    fRotar b = b
    fEspejar b = b
    fRot45 b = b
    fApilar _ _ b1 b2 = b1 && b2
    fJuntar _ _ b1 b2 = b1 && b2
    fEncimar b1 b2 = b1 && b2


-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP predicado1 predicado2 fig =  predicado1 fig && predicado2 fig


-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP predicado1 predicado2 x = predicado1 x || predicado2 x
