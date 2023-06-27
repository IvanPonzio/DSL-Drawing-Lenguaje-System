import Test.HUnit
import Pred
import Dibujo

data Forma = Triangulo Float Float Float | Circulo Float | Rectangulo Float Float deriving (Eq, Show)

figura1 :: Forma
figura1 = Triangulo 3 4 5

figura2 :: Forma
figura2 = Circulo 2

figura3 :: Forma
figura3 = Rectangulo 2 4


testPred :: Test
testPred = test
  [ -- Tests para cambiar
    "cambiar figura 1 a figura 2" ~:
      cambiar (==1) (const (figura 2)) (figura 1) ~?= figura 2,
    "cambiar figura 3 que no tiene figura 1 a figura 2" ~:
      cambiar (==1) (const (figura 2)) (figura 3) ~?= figura 3,
    "cambiar figura 1 a figura 2 y no modificar las demas" ~:
      cambiar (==1) (\x -> if x == 1 then figura 2 else figura 3) (apilar 1 1 (figura 1) (figura 1)) ~?= apilar 1 1 (figura 2) (figura 2),
    "cambiar figura 1 a figura 2 y no modificar las demas" ~:
      cambiar (==1) (\x -> if x == 1 then figura 2 else figura 3) (apilar 1 1 (figura 2) (figura 1)) ~?= apilar 1 1 (figura 2) (figura 2),

    -- Tests para anyDib
    "anyDib en figura 2 devuelve False" ~:
      anyDib (==1) (figura 2) ~?= False,
    "anyDib en figura 1 devuelve True" ~:
      anyDib (==1) (figura 1) ~?= True,
    "anyDib en juntar de figuras que no tienen 1 devuelve False" ~:
      anyDib (==1) (juntar 1 1 (figura 2) (figura 3)) ~?= False,
    "anyDib en juntar de figuras que tienen 1 devuelve True" ~:
      anyDib (==1) (juntar 1 1 (figura 1) (figura 3)) ~?= True,

    -- Tests para allDib
    "allDib en figura 2 devuelve False" ~:
      allDib (==1) (figura 2) ~?= False,
    "allDib en figura 1 devuelve True" ~:
      allDib (==1) (figura 1) ~?= True,
    "allDib en juntar de figuras que no tienen 1 devuelve False" ~:
      allDib (==1) (juntar 1 1 (figura 2) (figura 3)) ~?= False,
    "allDib en juntar de figuras que tienen 1 devuelve True" ~:
      allDib (==1) (juntar 1 1 (figura 1) (figura 1)) ~?= True,

    -- Tests para andP
    "andP de dos predicados distintos en 1 devuelve False" ~:
      andP (==1) (==2) 1 ~?= False,
    "andP de dos predicados iguales en 1 devuelve True" ~:
      andP (==1) (==1) 1 ~?= True,
    "andP de dos predicados distintos en 2 devuelve False" ~:
      andP (==1) (==2) 2   ~?= False,
    "andP de dos predicados iguales en 2 devuelve False" ~:
      andP (==2) (==2) 2 ~?= True,

    -- Tests para orP
    "orP de dos predicados distintos en 1 devuelve True" ~:
      orP (==1) (==2) 1 ~?= True,
    "orP de dos predicados iguales en 1 devuelve True" ~:
      orP (==1) (==1) 1 ~?= True,
   "orP de dos predicados distintos en 2 devuelve True" ~:
      orP (==1) (==2) 2 ~?= True,
    "orP de dos predicados iguales en 2 devuelve True" ~:
      orP (==2) (==2) 2 ~?= True

    ]

-- Ejecutar los tests
main :: IO Counts
main = runTestTT testPred