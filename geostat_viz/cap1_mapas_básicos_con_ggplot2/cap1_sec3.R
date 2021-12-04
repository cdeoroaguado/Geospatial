# paquetes ----
library(tidyverse)
library(ggmap)

# datos ----
ward_sales <- readRDS("~/geostat/viz/cap1/01_corv_wards.rds")
preds <- readRDS("~/geostat/viz/cap1/01_corv_predicted_grid.rds")

# ejercicio 1  ----
# Dibujar polígonos

# Un mapa de coropletas describe un mapa en el que los 
# polígonos están coloreados según alguna variable. En el 
# marco de datos ward_sales, tiene información sobre las 
# ventas de viviendas resumida a nivel de barrio. Su objetivo
# es crear un mapa en el que cada barrio esté coloreado por 
# uno de sus resúmenes: el número de ventas o el precio medio
# de venta.

# En el marco de datos, cada fila describe un punto en el 
# límite de un distrito. Las variables lon y lat describen su
# ubicación y ward describe a qué barrio pertenece, pero 
# ¿qué son el grupo y el orden?
  
# ¿Recuerda las dos cosas complicadas de los polígonos? 
# Un área puede ser descrita por más de un polígono y el 
# orden es importante. group es un identificador para un 
# solo polígono, pero un distrito puede estar compuesto por 
# más de un polígono, por lo que verá más de un valor de 
# group para dicho distrito. order describe el orden en que 
# los puntos deben ser dibujados para crear las formas 
# correctas.

# En ggplot2, los polígonos se dibujan con geom_polygon().
# Cada fila de sus datos es un punto en la frontera y los 
# puntos se unen en el orden en que aparecen en el marco de
# datos. Se especifica qué variables describen la posición 
# utilizando la estética x e y y qué puntos pertenecen a un
# único polígono utilizando la estética de grupo.

# Esto es un poco complicado, así que antes de hacer el 
# gráfico deseado, vamos a explorar esto un poco más.

# intruccion 1
# El marco de datos ward_sales está cargado en su 
# espacio de trabajo. Puede echar un vistazo con 
# head(ward_sales).

# * Añada una capa geom_point() con la estética del color 
#   asignada al barrio. ¿Cuántos distritos hay en Corvallis?

# Add a point layer with color mapped to ward
# ggplot(ward_sales, aes(lon, lat)) 

head(ward_sales)
ggplot(ward_sales, aes(lon, lat))+
  geom_point(aes(color=ward)) 

# * Añade una capa geom_point() con la estética del color 
#   asignada al grupo. Puedes ver algunos barrios que
#   están descritos por más de un polígono?

ggplot(ward_sales, aes(lon, lat))+
  geom_point(aes(color=group)) 

# * Añade una capa geom_path() con la estética del 
#   grupo asignada al grupo. Vea cómo se unen los puntos 
#   del mismo grupo.

ggplot(ward_sales, aes(lon, lat)) +
  geom_path(aes(group = group))

# * Por último, añada una capa geom_polygon() con la 
#   estética de fill asignada a ward y la estética de 
#   grupo asignada a group.

ggplot(ward_sales, aes(lon, lat)) +
  geom_polygon(aes(fill=ward,group = group))

# Ejercicio 2 ----
# Mapa coropléjico

# Ahora que entiendes cómo dibujar polígonos, 
# vamos a poner tus polígonos en un mapa. Recuerde, 
# usted reemplaza su llamada a ggplot() con una llamada a 
# ggmap() y la llamada original a ggplot() se mueve al 
# argumento base_layer(), entonces usted agrega su capa de 
# polígonos como de costumbre:

# ggmap(corvallis_map_bw,
#       base_layer = ggplot(ward_sales,
#                           aes(lon, lat))) +
#  geom_polygon(aes(group = group, fill = ward))

# ¡Pruébalo en la consola ahora!
  
# Uh oh, las cosas no se ven bien. Los barrios 1, 3 y 8 
# se ven mal y con jaggardias. ¿Qué ha pasado? Parte de los 
# límites del barrio están más allá del límite del mapa. 
# Debido a la configuración por defecto de ggmap(), 
# cualquier dato fuera del mapa se elimina antes de 
# trazarlo, por lo que algunos límites de los polígonos se
# eliminan y cuando los puntos restantes se unen se 
# obtienen las formas incorrectas.

# No se preocupe, hay una solución: ggmap() proporciona 
# algunos argumentos para controlar este comportamiento. 
# Los argumentos extent = "normal" junto con 
# maprange = FALSE obligan al trazado a utilizar el rango 
# de datos en lugar del rango del mapa para definir los 
# límites del trazado.

# instruccion 1 
# Actualiza la llamada a ggmap() para arreglar el recorte 
# de polígonos.
# * Establezca la extent como "normal" y maprange 
#   como FALSE.

# Fix the polygon cropping
# ggmap(corvallis_map_bw, 
#       base_layer = ggplot(ward_sales, aes(lon, lat))) +
#   geom_polygon(aes(group = group, fill = ward))

ggmap(corvallis_map_bw, 
      base_layer = ggplot(ward_sales, aes(lon, lat)),extent="normal",maprange=FALSE) +
  geom_polygon(aes(group = group, fill = ward))

# * Actualiza el gráfico, cambiando el color de relleno
#   del polígono de ward a num_sales.

# instruccion 2
# Repeat, but map fill to num_sales
ggmap(corvallis_map_bw, 
      base_layer = ggplot(ward_sales, aes(lon, lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = num_sales))

# instruccion 3
# Actualice el gráfico de nuevo, asignando el relleno a 
# avg_price. Además, establezca alfa a 0,8 en su llamada a 
# geom_polygon() para permitir que el mapa se muestre.

# Repeat again, but map fill to avg_price
ggmap(corvallis_map_bw, 
      base_layer = ggplot(ward_sales, aes(lon, lat)),
      extent = "normal", maprange = FALSE) +
  geom_polygon(aes(group = group, fill = avg_price),alpha =0.8)

# Buen trabajo. Una alternativa para resolver el problema del recorte es utilizar
qmplot(lon, lat, data = ward_sales,
       geom = "polygon",
       group = group, 
       fill = avg_price)
# que descargará suficiente mapa para cubrir toda la gama 
# de datos.

# Ejercicio 2 ----
# Datos ráster como mapa de calor

# Los precios de la vivienda predichos en preds se 
# denominan datos rasterizados: tienes una variable medida 
# (o en este caso predicha) en cada ubicación de una 
# cuadrícula regular.

# Si se observa head(preds) en la consola, se puede ver que
# los valores de lat aumentan en intervalos de aproximadamente
# 0,002, ya que lon es constante. Después de 40 filas, lon
# se incrementa en aproximadamente 0,003, ya que lat recorre
# los mismos valores. Para cada ubicación lat/lon, también 
# tiene un predicted_price. Más adelante, en el capítulo 3, 
# verá que una forma más útil de pensar (y almacenar) este 
# tipo de datos es en una matriz.

# Cuando los datos forman una cuadrícula regular, un enfoque
# para mostrarlos es como un mapa de calor. geom_tile() en 
# ggplot2 dibuja un rectángulo centrado en cada ubicación 
# que llena el espacio entre ella y la siguiente ubicación, 
# en efecto, embaldosando todo el espacio. Al asignar una 
# variable a la estética de relleno, se obtiene un mapa de 
# calor.

# instruccion 1
# * Cree un simple gráfico de puntos de las ubicaciones en
#   preds añadiendo una capa geom_point() a la primera 
#   llamada a ggplot(). Comprueba que las localizaciones 
#   forman una cuadrícula regular.

# Add a geom_point() layer
ggplot(preds, aes(lon, lat))+
  geom_point() 

# instruccion 2
# * En el segundo ggplot(), cambie geom_point() por 
#   geom_tile(), donde predicted_price se asigna a fill.
#   Recuerde que fill es un argumento de aes(), que es el 
#   primer y único argumento de su llamada a geom_tile().

# Add a tile layer with fill mapped to predicted_price
ggplot(preds, aes(lon, lat))+
  geom_tile(aes(fill=predicted_price))

# instruccion 3
# Crear un ggmap() utilizando el mapa corvallis_map_bw.
# * Añada una capa geom_tile() con lon, lat, y la estética
#   predicted_price del segundo gráfico.
# * Utilice preds como datos de la capa.
# * Establezca la transparencia alfa de la capa en 0,8.

ggmap(corvallis_map_bw) +
  geom_tile(aes(lon, lat, fill = predicted_price), 
            data = preds, alpha = 0.8)