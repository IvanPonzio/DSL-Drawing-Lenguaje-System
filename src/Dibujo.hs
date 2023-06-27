{-# LANGUAGE LambdaCase #-}
module Dibujo (
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
) where


{-
Gramática de las figuras:
<Fig> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig> 
    | Juntar <Float> <Float> <Fig> <Fig> 
    | Encimar <Fig> <Fig>
-}


data Dibujo a = Figura a
              | Rotar (Dibujo a)
              | Espejar (Dibujo a)
              | Rot45 (Dibujo a)
              | Apilar Float Float (Dibujo a) (Dibujo a)
              | Juntar Float Float (Dibujo a) (Dibujo a)
              | Encimar (Dibujo a) (Dibujo a)
              deriving (Eq, Show)


-- Agreguen los tipos y definan estas funciones
    
-- Construcción de dibujo. Abstraen los constructores.

figura :: a -> Dibujo a
figura = Figura

rotar :: Dibujo a -> Dibujo a
rotar = Rotar

espejar :: Dibujo a -> Dibujo a
espejar = Espejar

rot45 :: Dibujo a -> Dibujo a
rot45 = Rot45

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar = Apilar

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar = Juntar

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar = Encimar

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 d = rotar (rotar d)

r270 :: Dibujo a -> Dibujo a
r270 d = r180 ( rotar d)

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = apilar 0.0 0.0 a b

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) a b = juntar 0.0 0.0 a b

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) a b =  encimar a b

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = encimar ((///) a b) ((///) c d) 

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a 
encimar4 a = encimar (encimar (r270 a) (a)) (encimar (r180 a)(rotar a))
-- encimar4 a = encimar ((r270 a) (encimar (r180 (a encimar(a (rotar a))))))    

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = cuarteto a (rotar a) (rotar (rotar a)) (rotar (rotar (rotar a)))


-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dibujo =
    case dibujo of
        Figura a -> fFig a
        Rotar dib -> fRotar (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib)
        Espejar dib -> fEspejar (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib)
        Rot45 dib -> fRot45 (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib)
        Apilar f1 f2 dib1 dib2 -> fApilar f1 f2 (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib1) (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib2)
        Juntar f1 f2 dib1 dib2 -> fJuntar f1 f2 (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib1) (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib2)
        Encimar dib1 dib2 -> fEncimar (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib1) (foldDib fFig fRotar fEspejar fRot45 fApilar fJuntar fEncimar dib2)


-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib f dibujo =
    case dibujo of
        Figura a -> f a -- preguntar al profe
        Rotar dib -> Rotar (mapDib f dib)
        Espejar dib -> Espejar (mapDib f dib)
        Rot45 dib -> Rot45 (mapDib f dib)
        Apilar f1 f2 dib1 dib2 -> Apilar f1 f2 (mapDib f dib1) (mapDib f dib2)
        Juntar f1 f2 dib1 dib2 -> Juntar f1 f2 (mapDib f dib1) (mapDib f dib2)
        Encimar dib1 dib2 -> Encimar (mapDib f dib1) (mapDib f dib2)


-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [a]
figuras d = case d of
              Figura a -> [a]
              Rotar d' -> figuras d'
              Espejar d' -> figuras d'
              Rot45 d' -> figuras d'
              Apilar _ _ d1 d2 -> figuras d1 ++ figuras d2
              Juntar _ _ d1 d2 -> figuras d1 ++ figuras d2
              Encimar d1 d2 -> figuras d1 ++ figuras d2
