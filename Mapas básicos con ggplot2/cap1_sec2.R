# paquetes ----
library(tidyverse)
library(ggmap)

# datos ----
sales <- read.csv("~/geostat/viz/sales.csv")

# Ejemplo 1 ----

corvallis <- c( lon=-123.2620,lat=44.5646)
corvallis_map <- get_map(corvallis, zoom=13, scale=1)
# tipo de mapa, explicacion get_map
corvallis_map <- get_map(corvallis, zoom=13,
                         maptype = "toner-2010",
                         source="stamen")
# explicacion ggmap
ggplot(sales, aes(lon, lat)) +
  geom_point()

ggplot() + geom_point(aes(lon, lat), data = sales)

ggmap(corvallis_map) + geom_point(aes(lon, lat), data = sales)

ggmap(corvallis_map, base_layer = ggplot(sales, aes(lon, lat))) + geom_point() +
  facet_wrap(~ condition)

# Ejercicio 1 ----
# Diferentes mapas

# El mapa de Google por defecto descargado por get_map()
# es útil cuando se necesitan las carreteras principales,
# el terreno básico y los lugares de interés, pero 
# visualmente puede estar un poco cargado. Usted quiere que 
# su mapa se sume a sus datos, no que los distraiga, así que
# puede ser útil tener otras opciones más "tranquilas".

# A veces no te interesan realmente las carreteras y los 
# lugares, sino más bien lo que hay en el suelo (por ejemplo,
# hierba, árboles, desierto o nieve), en cuyo caso cambiar a
# una vista de satélite puede ser más útil. Puedes obtener 
# imágenes de satélite de Google cambiando el argumento 
# maptype a "satellite".

# Puedes obtener mapas Stamen utilizando 
# source = "stamen" en get_map(), junto con la 
# especificación de un argumento maptype. Puedes ver todos 
# los valores posibles para el argumento maptype mirando en 
# ?get_map, pero se corresponden estrechamente con los 
# "toner (sabores)" descritos en el sitio de Stamen Maps. 
# Me gustan las variaciones "toner", ya que son en escala 
# de grises y un poco más simples que el mapa de Google.

# Vamos a probar otros mapas para su plot de venta de casas.

# Instruccion 1
# Edite su llamada original a get_map() para obtener una 
# imagen "satellite" de Google añadiendo un argumento maptype.

# Muestra un gráfico de las ventas de casas coloreadas por 
# year_built utilizando el mapa de satélite.

corvallis <- c(lon = -123.2620, lat = 44.5646)

# Add a maptype argument to get a satellite map
corvallis_map_sat <- get_map(corvallis, zoom = 13 ,maptype="satellite")

# Edit to display satellite map
ggmap(corvallis_map_sat) +
  geom_point(aes(lon, lat, color = year_built), data = sales)

# instruccion 2

# Edite su llamada original a get_map() para obtener un mapa
# de tóner de Stamen añadiendo un argumento de origen (source) y un 
# argumento de tipo de mapa (maptype).

# Muestre un gráfico de las ventas de casas coloreadas por 
# year_built utilizando el mapa de tóner.

corvallis <- c(lon = -123.2620, lat = 44.5646)

# Add source and maptype to get toner map from Stamen Maps
corvallis_map_bw <- get_map(corvallis, zoom = 13, 
                            source = "stamen",
                            maptype= "toner")

# Edit to display toner map
ggmap(corvallis_map_bw) +
  geom_point(aes(lon, lat, color = year_built), data = sales)

# Ejercicio 2 ----

# Aprovechando los puntos fuertes de ggplot2

# Se ha visto que se pueden añadir capas a un gráfico de 
# ggmap() añadiendo capas de geom_***() y especificando los
# datos y mapeos explícitamente, pero este enfoque tiene dos
# grandes inconvenientes: las capas adicionales también 
# necesitan especificar los datos y mapeos, y el facetado 
# no funcionará en absoluto.

# Por suerte, ggmap() proporciona una forma de evitar estos
# inconvenientes: el argumento base_layer. Puede pasarle a 
# base_layer una llamada normal a ggplot() que especifique 
# los datos y mapeos por defecto para todas las capas.

# Por ejemplo, el gráfico inicial:

# ggmap(corvallis_map) +
#   geom_point(data = sales, aes(lon, lat))

# podría haber sido en cambio:
# ggmap(corvallis_map, base_layer = ggplot(sales,aes(lon, lat))) +
#  geom_point()

# Moviendo aes(x, y) y los datos de la función inicial 
# geom_point() a la llamada ggplot() dentro de la llamada 
# ggmap(), puedes añadir facetas, o capas extra, de la 
# manera habitual de ggplot2.

# Vamos a probarlo.

# Instruccion 1 
# Reescribe el primer gráfico para utilizar el argumento 
# base_layer de ggmap().

# * Añade un argumento base_layer a la llamada de ggmap().
# * Esto debería llamar a ggplot().
# * Mueva los datos y los mapeos x e y fuera de geom_point().
#   Deje el argumento de color dentro de la función aes() 
#   dentro de su llamada a geom_point().

# Use base_layer argument to ggmap() to specify data and x, y mappings
# ggmap(corvallis_map_bw, ___) +
#   geom_point(data = sales, aes(lon, lat, color = year_built))

ggmap(corvallis_map_bw, base_layer = ggplot(sales,aes(lon, lat)))+
  geom_point(aes(color = year_built))

# instruccion 2
# * Reescribe el gráfico para utilizar el argumento 
#   base_layer de ggmap(). Establecer el argumento de color
#   dentro de la función aes() a la class.
# * Añade una función facet_wrap() para facetar por class.
#   Esta función toma una fórmula.

# Use base_layer argument to ggmap() and add facet_wrap()
ggmap(corvallis_map_bw, base_layer = ggplot(sales,aes(lon, lat)))+
  geom_point(aes(color = class))+
  facet_wrap(~class)

# ejercicio 3 ----
# Una alternativa rápida

# ggmap también proporciona una alternativa rápida a 
# ggmap(). Al igual que qplot() en ggplot2, qmplot() es
# menos flexible que una especificación completa, pero a 
# menudo implica mucho menos escritura. qmplot() reemplaza 
# ambos pasos - descargar el mapa y mostrar el mapa - y su 
# sintaxis es una mezcla entre qplot(), get_map(), y ggmap().

# Echemos un vistazo a la versión qmplot() del gráfico 
# facetado del ejercicio anterior:

# qmplot(lon, lat, data = sales, 
#        geom = "point", color = class) +
#   facet_wrap(~ class)

# Observe que no especificamos un mapa, ya que qmplot() 
# tomará uno por sí mismo. Por lo demás, la llamada a 
# qmplot() se parece mucho a la correspondiente llamada a 
# qplot(): utiliza puntos para mostrar los datos de ventas,
# asignando lon al eje x, lat al eje y, y class al color. 
# qmplot() también establece el conjunto de datos y el mapeo
# por defecto (sin necesidad de base_layer) para que pueda 
# añadir facetas sin ningún trabajo adicional.

qmplot(lon, lat, data = sales, 
      geom = "point", color = class)+
facet_wrap(~ class)

# Instruccion
# Utilizando el ejemplo como guía, utilice qmplot() 
# para crear un gráfico de las ventas de casas en el que 
# el color se asigna a los dormitorios, facetado por mes.

# Plot house sales using qmplot()

qmplot(lon, lat, data = sales,
       geom = "point", color = bedrooms)+
  facet_wrap(~ month)
