# paquetes ----
library(sp)

# datos ----
countries_sp <- readRDS("~/geostat/viz/cap2/02_countries_sp.rds")
countries_spdf <- readRDS("~/geostat/viz/cap2/02_countries_spdf.rds")

# ejemplo 
world <- rnaturalearth::countries110
europe <- world[world$region_un=="Europe"&world$name!='Russia',]
europe$

library(tmap)
tm_shape(europe)+
tm_borders()+
tm_fill("subregion")+
#tm_compass()+
tmap_style("natural")

# ejercicio 1 ----
# Construir un gráfico en capas

# Ahora que sabes un poco más sobre tmap(), vamos a construir tu 
# gráfico anterior de población en capas y hacer algunos ajustes 
# para mejorarlo. Empezamos con una capa tm_shape() que define los
# datos que queremos utilizar, y luego añadimos una capa tm_fill()
# para colorear los polígonos utilizando la variable población:
  
tm_shape(countries_spdf) +
  tm_fill(col = "population") 

# Probablemente el mayor problema del gráfico resultante es que la
# escala de colores no es muy informativa: ¡el primer color 
# (amarillo pálido) cubre todos los países con una población 
# inferior a 200 millones! Como la escala de colores está asociada
# a la capa tm_fill(), los ajustes de esta escala se realizan en 
# esta llamada. Aprenderá mucho más sobre el color en el Capítulo 3,
# pero por ahora, sepa que el argumento del estilo controla cómo 
# se eligen los cortes.

# Su gráfico también necesita algunos contornos de países. Puede 
# añadir una capa tm_borders() para esto, pero no hagamos que sean
# demasiado fuertes visualmente. Tal vez un marrón estaría bien.

# El beneficio de usar objetos espaciales se vuelve realmente claro
# cuando cambias el tipo de gráfico que haces. Probemos también un 
# gráfico de burbujas en el que el tamaño de las burbujas corresponda
# a la población. Si se utilizara ggplot2, esto implicaría una 
# gran cantidad de remodelación de los datos. Con tmap, sólo tienes
# que cambiar una capa.

# instrucción 

# * Añade style = "quantile" a tm_fill(). Esto elige los cortes en
#   la escala de colores basándose en un número igual de observaciones
#   en cada intervalo.
library(sp)
library(tmap)

# Add style argument to the tm_fill() call
tm_shape(countries_spdf) +
  tm_fill(col = "population",style = "quantile") 

# * Al mismo gráfico, añada una capa tm_borders() con 
#   col = "burlywood4".

tm_shape(countries_spdf) +
  tm_fill(col = "population",style = "quantile")+
  tm_borders(col = "burlywood4")

# * Cree un nuevo gráfico igual que el primero, pero en lugar de 
#   tm_fill() añada una capa tm_bubbles() con el tamaño asignado 
#   a la población.

tm_shape(countries_spdf) +
  tm_bubbles(style = "quantile",
             size = "population")+
  tm_borders(col = "burlywood4")

# ejercicio 2 ----
# ¿Por qué es tan grande Groenlandia?
# Fíjate bien en el gráfico. ¿Por qué Groenlandia parece más grande
# que los Estados Unidos contiguos cuando en realidad sólo tiene un
# tercio del tamaño?
  
# Cuando se trazan las posiciones de longitud y latitud en los ejes
# X e Y de un gráfico, se considera que 1 grado de longitud tiene 
# el mismo tamaño, independientemente de dónde se encuentre. Sin 
# embargo, como la Tierra es aproximadamente esférica, la distancia
# descrita por 1 grado de longitud depende de tu latitud, variando
# desde 111 km en el ecuador hasta 0 km en los polos.

# La forma en que has tomado las posiciones en una esfera y las 
# has dibujado en un plano bidimensional se describe mediante una 
# proyección. La que has utilizado por defecto (también conocida 
# como proyección Equirectangular) distorsiona la anchura de las 
# zonas cercanas a los polos. Toda proyección implica algún tipo 
# de distorsión (¡ya que una esfera no es un plano!), pero las 
# diferentes proyecciones tratan de preservar diferentes propiedades
# (por ejemplo, áreas, ángulos o distancias).

# En tmap, tm_shape() toma un argumento proyección que le permite
# intercambiar las proyecciones para el gráfico.

# (Nota: el cambio de la proyección de un gráfico ggplot2 se realiza
# mediante la función coord_map(). Véase coord_map() para más detalles).

# https://en.wikipedia.org/wiki/List_of_map_projections

# instrucción
# Para ayudarle a ver las diferencias entre las proyecciones, 
# hemos añadido una capa tm_grid() que añade líneas de longitud y
# latitud equiespaciadas al gráfico.

# Dentro de su llamada a tm_shape():
  
# * Pruebe una proyección Hobo-Dyer (proyección = "hd"), diseñada 
#   para preservar el área.

# Switch to a Hobo–Dyer projection

tm_shape(countries_spdf) +
  tm_grid(n.x = 11, n.y = 11) +
  tm_fill(col = "population", style = "quantile")  +
  tm_borders(col = "burlywood4")+
  tm_layout(legend.outside = FALSE, frame = TRUE)+
  tm_legend(text.size = 0.5,
            legend.width = 0.2, 
            legend.height = 0.4) 

hd <- "+proj=cea +lon_0=0 +lat_ts=37.5 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs"
tm_shape(countries_spdf, projection = hd) +
  tm_grid(n.x = 11, n.y = 11) +
  tm_fill(col = "population", style = "quantile")  +
  tm_borders(col = "burlywood4")+
  tm_legend(text.size = 0.5,
            legend.width = 0.2, 
            legend.height = 0.4) 

# * En un segundo gráfico, pruebe una proyección Robinson 
#   (proyección = "robin"), diseñada como un compromiso entre la
#   preservación de los ángulos locales y el área.

robin <- "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
tm_shape(countries_spdf, projection = robin) +
  tm_grid(n.x = 11, n.y = 11) +
  tm_fill(col = "population", style = "quantile")  +
  tm_borders(col = "burlywood4")+
  tm_legend(text.size = 0.5,
            legend.width = 0.2, 
            legend.height = 0.4) 

# * Sólo por diversión, repita el gráfico anterior, pero añada 
#   tm_style("classic") para ver cómo tmap puede controlar todos
#   los aspectos de la visualización de los mapas.

tm_shape(countries_spdf, projection = robin) +
  tm_grid(n.x = 11, n.y = 11) +
  tm_fill(col = "population", style = "quantile")  +
  tm_borders(col = "burlywood4")+
  tm_style("classic")+
  tm_legend(text.size = 0.5,
            legend.width = 0.3, 
            legend.height = 0.4)

# ejercicio 3 ----
# Guardar un gráfico tmap

# Guardar un gráfico tmap es fácil con la función tmap_save(). 
# El primer argumento, tm, es el gráfico a guardar, y el segundo,
# filename, es el archivo en el que se guardará. Si se deja tm 
# sin especificar, se guardará el último gráfico tmap impreso.

# La extensión del nombre del archivo especifica el tipo de archivo,
# por ejemplo .png o .pdf para gráficos estáticos. Una cosa muy 
# buena de tmap es que puedes guardar una versión interactiva que
# aprovecha el paquete leaflet. Para obtener una versión interactiva,
# utilice tmap_save() pero use la extensión de nombre de archivo 
# .html.

# instruccion
# Guarda tu gráfico del ejercicio anterior de las siguientes maneras.
# Ninguno de los dos gráficos se mostrará en tu espacio de trabajo,
# pero podrás echarle un vistazo una vez que hayas completado el ejercicio.

# * Guárdalo como un gráfico estático especificando el nombre de 
#   archivo population.png.
longlat <- "+proj=longlat +datum=WGS84"
tm_shape(countries_spdf) +
  tm_grid(n.x = 11, n.y = 11, projection = longlat) +
  tm_fill(col = "population", style = "quantile")  +
  tm_borders(col = "burlywood4") -> map1

tmap_save(tm = map1, filename = "/home/carlos/geostat/viz/cap2/population.png")

# * Guárdalo como un gráfico interactivo especificando el nombre 
#   de archivo population.html.

tmap_save(tm = map1, filename = "/home/carlos/geostat/viz/cap2/population.html")


