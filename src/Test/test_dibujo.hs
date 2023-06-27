import Test.HUnit
import Dibujo

-- Ejemplo de figuras
circulo = figura "o"
cuadrado = figura "■"
triangulo = figura "▲"
linea = figura "―"
l = figura "L"
dibujo = ciclar (encimar circulo (encimar cuadrado (encimar triangulo linea)))
dibujo2 = encimar (apilar 1 1 circulo cuadrado) (apilar 1 1 triangulo linea)

-- Tests para las funciones

testFigura = TestCase (assertEqual "figura" (figura 5) (figura 5))
testRotar = TestCase (assertEqual "rotar" (rotar (figura 5)) (rotar (figura 5)))
testEspejar = TestCase (assertEqual "espejar" (espejar (figura 5)) (espejar (figura 5)))
testRot45 = TestCase (assertEqual "rot45" (rot45 (figura 5)) (rot45 (figura 5)))
testApilar = TestCase (assertEqual "apilar" (apilar 0.5 0.5 (figura 5) (figura 10)) (apilar 0.5 0.5 (figura 5) (figura 10)))
testJuntar = TestCase (assertEqual "juntar" (juntar 0.5 0.5 (figura 5) (figura 10)) (juntar 0.5 0.5 (figura 5) (figura 10)))
testEncimar = TestCase (assertEqual "encimar" (encimar (figura 5) (figura 10)) (encimar (figura 5) (figura 10)))
testR180 = TestCase (assertEqual "r180" (rotar (rotar (figura 5))) (r180 (figura 5)))
testR270 = TestCase (assertEqual "r270" (rotar (rotar (rotar (figura 5)))) (r270 (figura 5)))
testStack = TestCase (assertEqual "stack" (apilar 1.0 1.0 (figura 5) (figura 10)) ((.-.) (figura 5) (figura 10)))
testHStack = TestCase (assertEqual "hstack" (juntar 1.0 1.0 (figura 5) (figura 10)) ((///) (figura 5) (figura 10)))
testEncimar4 = TestCase (assertEqual "encimar4" (encimar (encimar (rotar (rotar (rotar (figura 5)))) (figura 5)) (encimar (rotar (rotar (figura 5))) (rotar (figura 5)))) (encimar4 (figura 5)))
testCiclar = TestCase (assertEqual "ciclar" (cuarteto (figura "o") (figura "■") (figura "▲") (figura "―")) (ciclar dibujo))
--testMapDib = TestCase (assertEqual "mapDib" (encimar (apilar 0.5 0.5 (figura 111) (figura 555) ) ))

-- Define your test cases here

main :: IO ()
main = do
  _ <- runTestTT (TestList [testRotar, testApilar, testEspejar, testJuntar, testEncimar, testCiclar])
  return ()