# paquetes ----
library(raster)

# datos ----
countries_spdf

# ejercicio 1 ----
# ¿Qué es un objeto raster?
  
# Al igual que las clases sp, las clases raster tienen métodos que
# ayudan a la visualización y manipulación básica de los objetos, 
# como print() y summary(), y siempre puedes profundizar en su 
# estructura con str().

# Entremos y echemos un vistazo a un raster que hemos cargado para
# ti, pop. Fíjate en algunas cosas:
  
# * ¿Puedes ver dónde se guarda la información de coordenadas?
# * ¿Puedes saber por el summary() qué tamaño tiene el raster?
# * ¿Qué crees que puede estar almacenado en este raster?

# instruccion 
# * Imprime pop en la consola.
pop <- readRDS(file = "_data/03-population.rds")
print(pop)

# * Llamar a str() sobre pop con max.level = 2.
str(pop, max.level=2)

# * Llamar a summary() sobre pop.
summary(pop)

# ejercicio 2 ----
# Algunos métodos útiles
# pop es un objeto RasterLayer, que contiene la población alrededor
# de las áreas de Boston y NYC. Cada celda de la cuadrícula contiene
# simplemente un recuento del número de personas que viven dentro 
# de esa celda.

# En el ejercicio anterior has visto que print() da un resumen útil
# del objeto, incluyendo el sistema de referencia de coordenadas, 
# el tamaño de la cuadrícula (tanto en número de filas y columnas 
# como en coordenadas geográficas), y alguna información básica 
# sobre los valores almacenados en la cuadrícula. Pero era muy 
# escueto; ¿qué pasa si quieres ver algunos de los valores del
# objeto?
  
# La primera forma es simplemente trazar() el objeto. Hay un método
# plot() para los objetos raster que crea un mapa de calor de los 
# valores.

# Si desea extraer los valores de un objeto raster, puede utilizar
# la función values(), que extrae un vector de los valores. Hay 
# 316.800 valores en el ráster pop, así que no querrás imprimirlos
# todos, pero puedes usar str() y head() para echar un vistazo.

# instruccion 
# * Llama a plot() sobre pop. ¿Puedes ver dónde está NYC?
plot(pop)

# * Llama a str() sobre values(pop).
str(values(pop))

# * Llama a head() sobre values(pop).
head(values(pop))

# ejercicio 3 ----
# Un objeto más complicado

# El paquete raster proporciona el objeto RasterLayer, pero también
# un par de objetos más complicados: RasterStack y RasterBrick. 
# Estos dos objetos están diseñados para almacenar muchos rásteres,
# todos de la misma extensión y dimensión (también conocidos como 
# rásteres multibanda o multicapa).

# Puede pensar en RasterLayer como una matriz, pero los objetos 
# RasterStack y RasterBrick son más bien matrices tridimensionales.
# Una cosa adicional que necesita saber para manejarlos es cómo 
# especificar una capa particular.

# Puede utilizar $ o [[ subconjuntos en un RasterStack o 
# RasterBrick para tomar una capa y devolver un nuevo objeto 
# RasterLayer. Por ejemplo, si x es un RasterStack, x$nombre_capa 
# o x[["nombre_capa"]] devolverá un RasterLayer con sólo la capa 
# llamada nombre_capa.

# Veamos un objeto RasterStack llamado pop_by_age que cubre la 
# misma área que pop pero que ahora contiene capas para la 
# población dividida en algunos grupos de edad diferentes.

# instruccion
# * Imprimir pop_by_age. ¿Puede ver los nombres de todas las capas?
pop_by_age <- readRDS(file = "_data/03-population-by-age.rds")
print(pop_by_age)

# * Subconjunte la capa under_1 utilizando [[ sub-conjuntos.
pop_by_age[["under_1"]]

# * Traza la capa under_1 pasando tu código de la instrucción 
#   anterior a plot().
plot(pop_by_age[["under_1"]])

# ejercicio 4 ----
# Un paquete que utiliza objetos Raster

# Ya has visto que el paquete tmap facilita la visualización de 
# las clases espaciales en sp. La buena noticia es que también 
# funciona con las clases raster. Simplemente pasas tu objeto 
# Raster___ como el argumento shp a la función tm_shape(), y luego
# añades una capa tm_raster() así

tm_shape(raster_object) +
  tm_raster()

# Cuando trabaje con un objeto RasterStack o RasterBrick, como el
# objeto pop_by_age que creó en el último ejercicio, puede mostrar
# una de sus capas utilizando el argumento col (abreviatura de "color")
# en tm_raster(), rodeando el nombre de la capa entre comillas.

# Trabajarás con tmap a lo largo del curso, pero también queremos
# mostrarte otro paquete, rasterVis, también diseñado específicamente
# para visualizar objetos raster. Hay unas cuantas funciones diferentes
# que puedes usar en rasterVis para hacer gráficos, pero vamos a probar
# una de ellas por ahora: levelplot().

# instruccion
# * Utilice tmap para trazar el objeto pop, especificando pop como
#   argumento shp a tm_shape() y añadiendo una capa tm_raster().
tm_shape(pop) +
  tm_raster()

# * Utilice tmap para trazar la capa under_1 de pop_by_age, un 
#   objeto RasterStack.
tm_shape(pop_by_age$under_1) +
  tm_raster(col = "under_1")

# * Llame a la función rasterVis levelplot() sobre pop.
library(rasterVis)
levelplot(pop)