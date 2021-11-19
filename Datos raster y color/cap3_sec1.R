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
