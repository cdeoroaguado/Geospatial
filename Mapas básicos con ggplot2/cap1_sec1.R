# paquetes ----
library(tidyverse)
library(ggmap)

# datos ----
sales <- readRDS("~/geostat/viz/01_corv_sales.rds")

# Ejemplo 1 ----
head(sales)

# grafica de puntos en ggplot
ggplot(sales, aes(lon,lat))+
  geom_point()

# mapa de nueva york
# coordenadas para la localización de interes
nyc <- c(lon=-74.0059,lat=40.7128)

# 1. Descargar el mapa
# primero hacemos el proceso de anadir la api
# https://www.youtube.com/watch?v=fR6r8MRit7I
mapa_nyc <- get_map(location =nyc, zoom=10)

# 2. mostrar mapa
ggmap(mapa_nyc)


# Ejercicio 1 ----
# Cómo coger un mapa de fondo

# Hay dos pasos para añadir un mapa a un gráfico
# ggplot2 con ggmap:
# 1.  Descargar un mapa usando get_map()
# 2. Mostrar el mapa con ggmap()

# Como ejemplo, vamos a coger un mapa de la ciudad
# de Nueva York:

#  library(ggmap)

# nyc <- c(lon = -74.0059, lat = 40.7128)
# nyc_map <- get_map(location = nyc, zoom = 10)
# get_map() tiene una serie de argumentos que 
# controlan el tipo de mapa que se va a obtener,
# pero por ahora nos quedaremos con los valores
# por defecto. El argumento más importante es el 
# primero, la ubicación, donde puedes proporcionar
# un par de coordenadas de longitud y latitud donde
# quieres que se centre el mapa. (El siguiente argumento,
# zoom, toma un número entero entre 3 y 21 y controla 
# hasta qué punto se amplía el mapa. 
# En este ejercicio, establecerás un tercer argumento,
# scale, igual a 1. Esto controla la resolución de los mapas
# descargados y lo establecerás más bajo (el valor por
# defecto es 2) para reducir el tiempo que tardan 
# las descargas.
                                                                                                                                                                                                                                                                                                                           
# respuesta                                                
library(ggmap)
corvallis <- c(lon = -123.2620, lat = 44.5646)

# Obtener el mapa con zoom 5: map_5
map_5 <- get_map(corvallis, zoom = 5, scale = 1)

# grafica el mapa con zoom 5
ggmap(map_5)

# Obtener el mapa con zoom 13: corvallis_map
corvallis_map <- get_map(corvallis, zoom = 13, scale = 1)

# Grafica el mapa con zoom 13
ggmap(corvallis_map)

# Ejercicio 2 ----

# Ponerlo todo junto

# Ahora tienes un bonito mapa de Corvallis, pero ¿cómo 
# pones encima las localizaciones de las ventas de casas?
  
# Al igual que con ggplot(), puedes añadir capas de datos
# a una llamada a ggmap() (por ejemplo, + geom_point()). 
# Sin embargo, es importante tener en cuenta que ggmap() 
# establece el mapa como el conjunto de datos por defecto 
# y también establece los mapeos estéticos por defecto.

# Esto significa que si quieres añadir una capa de algo 
# distinto al mapa (por ejemplo, ventas), tienes que 
# especificar explícitamente tanto el mapeo como los 
# argumentos de datos al geom.

# ¿Qué aspecto tiene esto? Ha visto cómo podría hacer un
# gráfico básico de las ventas:

# ggplot(sales, aes(lon, lat)) + 
#   geom_point()

# Una forma equivalente de especificar la misma trama es:

# ggplot() + 
#   geom_point(aes(lon, lat), data = sales)

# Aquí, hemos especificado los datos y la cartografía 
# en la llamada a geom_point() en lugar de ggplot(). 
# La ventaja de especificar el gráfico de esta manera es 
# que se puede cambiar ggplot() por una llamada a ggmap()
# y obtener un mapa en el fondo del gráfico.

# Instrucciones
# El paquete ggmap ha sido cargado para usted y 
# corvallis_map del ejercicio anterior está disponible 
# en su espacio de trabajo.

# * En primer lugar, eche un vistazo al head() de los datos
#   de ventas. ¿Puede ver las columnas que especifican la ubicación de la casa?
# * Cambie la llamada a ggplot() por una llamada a ggmap() con corvallis_map.

# Mostrar con head() a sales
head(sales)

# Cambiar la llamada a ggplot() por la llamada a ggmap()
ggplot() +
  geom_point(aes(lon, lat), data = sales)

# Ejercicio 3 ----
# Visión a través de la estética

# La adición de un mapa al gráfico de ventas explica parte
# de la estructura de los datos: no hay ventas de casas al este 
# del río Willamette ni en el campus de la Universidad 
# Estatal de Oregón. Esta estructura es en realidad una 
# consecuencia de la ubicación de las casas en Corvallis;
# ¡no se puede vender una casa donde no hay casas!
  
# El valor de la visualización de datos espacialmente viene
# realmente cuando se añaden otras variables a la 
# visualización a través de las propiedades de sus objetos 
# geométricos, como el color o el tamaño. 
# Ya sabes cómo hacer esto con los gráficos de ggplot2: 
# añadir mapeos adicionales a la estética del geom.

# Veamos qué más puedes aprender sobre estas casas en 
# Corvallis.

# NOTA: Muchos ejercicios de este curso requerirán que 
# crees más de un plot. Puedes alternar entre plots con
# las flechas de la parte inferior de la ventana "Plots" 
# y ampliar un plot haciendo clic en las flechas de la 
# pestaña de la parte superior de la ventana "Plots".

# Instrucciones
# Asigna el color de los puntos al year_build (año_de_construcción).
# ¿Cómo se ha desarrollado Corvallis como ciudad?

# Asignar el color al year_build (año_de_construcción)
ggmap(corvallis_map) +
  geom_point(aes(lon, lat,color=year_built), data = sales)

ggplot() +
  geom_point(aes(lon, lat,color=year_built), data = sales)

# Asigne el tamaño de los puntos a los dormitorios (bedrooms). 
# ¿Hay zonas de casas con menos o más dormitorios?

# Mapa del tamaño para bedrooms
ggplot() +
  geom_point(aes(lon, lat,size=bedrooms), data = sales)

ggmap(corvallis_map) +
  geom_point(aes(lon, lat,size=bedrooms), data = sales)

# Asigne el color de los puntos al precio por pie cuadrado 
# (es decir, precio / pie cuadrado acabado 
# (price / finished_squarefeet)). 
# ¿Hay zonas con mejor "valor" que otras? 
# ¿Qué hace que este plot no tenga éxito?

# Map color to price / finished_squarefeet
ggplot() +
  geom_point(aes(lon, lat,color=price/finished_squarefeet),
             data = sales)

ggmap(corvallis_map) +
  geom_point(aes(lon, lat,color=price/finished_squarefeet),
             data = sales)

# Gran trabajo. El último plot no tuvo tanto éxito porque 
# una de las ventas tuvo un precio muy alto por metro 
# cuadrado. Esto empujó a todas las demás ventas a la misma
# gama de colores y dificultó la visualización de patrones.
# Puede resolverlo filtrando la venta en cuestión, o 
# cambiando la forma en que se asignan los valores a los
# colores, algo de lo que hablaremos en el capítulo 3. 
# También puede preguntarse por qué algunos de los puntos 
# son grises aunque el gris no esté en nuestra escala de 
# colores. Los puntos grises son ubicaciones con valores 
# perdidos para la variable que hemos asignado al color, 
# es decir, ventas con NA para el precio o los pies 
# cuadrados terminados.





  