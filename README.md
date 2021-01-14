# Practica-Final-Estructuras-II-2020
En esta practica hay que desarrollar un videojuego en EASy68K utilizando todas las funcionalidades de acceso a perifericos que consideremos necesarias.

La tematica, complejidad y estructrua del videojuego es libre siempre y cuando respeten las siguientes condiciones:
- El bucle principal tiene que mantener la secuencia *update*, espera al sincronismo *plot*
- El juego slo pede acceder al teclado mediante las variables KBDVAL y KBDEDGE. En ningún caso se puede usar en TRAP #15 para acceder al teclado
- Se debe seguir la estructura de ficheros vistos en clase, de tal manera que la maypria del código este "dispersado" en varios archivos y haciendo INCLUDE al principio del MAIN. SE pueden usar tantos archivos como se vean necesarios.

## Caracteristicas adicionales
Para esta practica, de momento, se implementaran la **visualización de imagenes** y el **uso del ratón**.

La **visualización de imagenes** se utilizará para renderizar tanto el juegador como todo su ambiente. 

Por otra parte el **uso del ratón** se usará para definir la dificultad del videojuego con un pequeño menú al principio. 


Link de la [Documentación](https://www.overleaf.com/read/bxrqcxxvrgty)
