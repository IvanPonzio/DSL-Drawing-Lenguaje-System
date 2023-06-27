  <h3 align="center">Laboratorio : Implementacion de un DSL </h3>

  <p align="center">
    Redes y Sistemas Distribuidos 2023


Éste informe trata sobre el trabajo realizado para la  entrega del laboratorio, **Laboratorio 1 - Implementacion de un DSL**, en la cual desarrollamos un lenguaje de dominio especifico para crear, modificar y mostrar dibujos. Grupo n° 10, integrado por:

- Fernando Alvarado, fernando.alvarado@mi.unc.edu.ar
- Ivan Ponzio, ivan.ponzio@mi.unc.edu.ar
- Armando Carral, armando.carral@mi.unc.edu.ar

## Tabla de contenidos

  - [Nuestra_experiencia](#nuestra_experiencia)
  - [Preguntas](#Preguntas)


## Nuestra_experiencia

Nos parecio un proyecto muy interesante, el cual requirio que volvamos a usar programacion funcional y haskell, algo que en un principio nos dificulto la tarea, ya que veniamos acostumbrados a programacion imperativa. Pudimos realizar en conjunto el modulo Dibujo y todos sus constructores/funciones, y luego nos dividimos las distintas tareas en modulos pred e interpretacion. Al intentar realizar la figura de Escher nos encontramos con problemas en los primeros modulos para los cuales tuvimos que realizar ciertas modificaciones. Fue interesante aprender sobre la libreria gloss y su funcionalidad para este tipo de tareas. Luego a la hora de hacer los tests, recurrimos a chatGPT y nos encontramos con mas problemas de tipo, sobre todo en el modulo pred. Elegimos utilizar la libreria HUnit para probar ambos modulos, y tambien realizamos una variacion de la figura ejemplo que nos habian dado. La implementacion de la grilla fue una de las tareas mas costosas.

## Preguntas
### ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo
El modulo Dibujo, se encarga de definir un tipo de datos para representar dibujos, así como funciones para construir y manipularlos. Las funciones se crean con el fin de exportarlas y usar ellas para acceder al tipo de datos Dibujo, en vez de exportar los constructores en si, y mantener el encapsulamiento. Abstraimos los constructores en funciones con el mismo nombre pero en minusculas. Luego se encuentran funciones para la manipulacion de los dibujos utilizando las funciones previamente definidas. Para la manipulacion, la funcion foldDib que toma un dibujo y lo descompone en sus partes, procesando cada parte de acuerdo a las funciones que se le pasan, y luego reconstruye el dibujo original; la funcion mapDib aplica f a cada elemento a dentro del dibujo dibujo, produciendo un nuevo dibujo donde cada elemento a ha sido reemplazado por su correspondiente b. 

El modulo Pred utiliza el modulo Dibujo para definir varias funciones para trabajar con predicados (funciones que toman un valor y devuelven un valor booleano). La funcion cambiar que toma un predicado, una función, y un dibujo. Retorna un nuevo dibujo que es igual al dibujo original, pero con todas las figuras para las que el predicado es verdadero reemplazadas por el dibujo devuelto por la función. La funcion anyDib devuelve un valor booleano que indica si el predicado que se pasa se cumple para alguna figura del dibujo que se pasa, y allDib es lo mismo pero si el predicado se cumple para todas las figuras del dibujo. La funcion andP toma dos predicados p1 y p2, y devuelve un nuevo predicado que se cumple para un valor x si y solo si tanto p1 como p2 se cumplen para el elemento, y orP es lo mismo pero si p1 o p2 se cumplen para el elemento. 

El modulo interp se encarga de hacer la interpretacion geometrica, es decir, realizar los calculos correspondientes para que cada funcion constructora efectue los cambios que le correspondan. Ademas, modularizamos cada interpretacion para cada funcion y luego llamarla con foldDib. Aqui se hace una gran parte del trabajo necesario para mostrar pon pantalla un Dibujo. 

Cada funcionalidad esta separada para una mejor legibilidad y entendimiento del codigo, para que al usuario no tenga que lidiar con la parte estructural de cada Dibujo y solo indique que es lo que quiere hacer con el mismo.

### ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?
Esto es para hacer que el tipo de datos Dibujo sea polimorfico, y no solo se limite a un circulo, rectangulo, cuadrado, etc., ya que no sabemos de antemano, cuales son las figuras basicas del Dibujo a crear.  

### ¿Qué ventaja tiene utilizar una función de fold sobre hacer pattern-matching directo?
La ventaja es que mantiene oculta la implementacion, a fin de que el usuario no interceda en la definicion de los constructores, provocando errores. Tambien simplifica el codigo, ya que si se tienen varias variantes de un tipo, hacer pattern-matching para cada una de ellas puede generar mucho código repetitivo. Tambien se puede abstraer la lógica de procesamiento de datos de la estructura del tipo, pudiendo reutilizar la misma lógica para diferentes tipos que tengan una estructura similar. El uso de fold seguirá funcionando sin necesidad de hacer cambios en el código.
