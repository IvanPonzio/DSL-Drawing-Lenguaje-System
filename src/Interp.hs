module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid, zero, half)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss.Data.Vector (Vector(..))



-- Interpretación de un dibujo
-- formulas sacadas del enunciado

interpretaciondeRotar :: FloatingPic -> FloatingPic
interpretaciondeRotar pic x w h = pic (x V.+ w) h (zero V.-w)

interpretaciondeRot45 :: FloatingPic -> FloatingPic
interpretaciondeRot45 pic x w h = pic (x V.+ half (w V.+ h)) (half (w V.+ h)) (half (h V.- w))

interpretaciondeEspejar :: FloatingPic -> FloatingPic
interpretaciondeEspejar pic x w  = pic (x V.+ w) (zero V.- w) 

interpretaciondeEncimar :: FloatingPic -> FloatingPic -> FloatingPic
interpretaciondeEncimar pic1 pic2 x w h = pic1 x w h <> pic2 x w h

interpretaciondeJuntar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpretaciondeJuntar f1 f2 pic1 pic2 x w h = pic1  x  w' h <> pic2 (x V.+ w')  (r' V.* w)  h
                                                where
                                                    r' = f1/(f1+f2)
                                                    r  = f2/(f2+f1)
                                                    w' = r V.* w 

                                        
interpretaciondeApilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
interpretaciondeApilar f1 f2 pic1 pic2 x w h = pic1 (x V.+ h') w  (r V.* h) <> pic2 x  w  (r' V.* h)
                                        where
                                            r' = f1 / (f2 + f1)
                                            r = f2 / (f2 + f1)
                                            h' = r' V.* h




interp :: Output a -> Output (Dibujo a)
interp interpFig = foldDib interpFig interpretaciondeRotar interpretaciondeEspejar interpretaciondeRot45 interpretaciondeApilar interpretaciondeJuntar interpretaciondeEncimar
  

-- Configuración de la interpretación
data Conf = Conf {
        name :: String,
        pic :: FloatingPic
    }

interpConf :: Conf -> Float -> Float -> Picture 
interpConf (Conf _ p) x y = p (0, 0) (x,0) (0,y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (interpConf cfg size size) size size
  where withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
        grey = makeColorI 120 120 120 120