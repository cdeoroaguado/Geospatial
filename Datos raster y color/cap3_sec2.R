# paquetes de colores ----
library(RColorBrewer)
display.brewer.all()
brewer.pal(n=9, "Blues")

library(viridisLite)
viridis(n=9)

# ejercicio 1 ----

# Elija la paleta adecuada

# Considere la posibilidad de mostrar una trama que contenga la 
# proporción de la población que tiene entre 18 y 24 años. Es decir,
# un valor de 0 indica que ninguna de las personas de una celda de
# la cuadrícula tiene entre 18 y 24 años y un valor de 1 indica que
# todas las personas de una celda de la cuadrícula tienen entre 18
# y 24 años. Hemos cargado prop_by_age en su espacio de trabajo si
# quiere echarle un vistazo.

# ¿Qué paleta de colores sería la más adecuada?


# A qualitative palette like brewer.pal(9, "Set3")

# R/ A sequential palette like brewer.pal(9, "BuPu")

# A diverging palette like brewer.pal(9, "BrBG")

# ejercicio 2 ----
# Añadir una paleta de colores continua personalizada a los 
# gráficos de ggplot2

# La forma más versátil de añadir una escala continua personalizada
# a los gráficos de ggplot2 es con scale_color_gradientn() o 
# scale_fill_gradientn(). ¿Cómo saber cuál utilizar? Haga coincidir 
# la función con la estética que ha trazado. Por ejemplo, en el gráfico
# del precio de la vivienda previsto en el capítulo 1, has asignado
# el relleno al precio, por lo que tendrías que utilizar scale_fill_gradientn().

# Estas dos funciones toman un argumento, colors, donde se pasa un
# vector de colores que define la paleta. Aquí es donde entra la 
# versatilidad. Puedes generar tu paleta de cualquier manera que 
# elijas, automáticamente usando algo como RColorBrewer o 
# viridisLite, o manualmente especificando los colores por nombre o
# código hexadecimal.

# Las funciones scale___gradientn() manejan cómo estos colores son
# mapeados a los valores de su variable, aunque hay control disponible
# a través del argumento values.

# Juguemos con algunas escalas de color alternativas para el mapa 
# térmico del precio de la vivienda previsto en el capítulo 1 
# (hemos eliminado el fondo del mapa para reducir el tiempo de 
# cálculo, de modo que pueda ver sus gráficos rápidamente).

# instruccion 1
# * Crear una paleta llamada blups de 9 pasos en la paleta 
#   RColorBrewer "BuPu".
blups <- brewer.pal(n = 9, "BuPu")

# * Añadir scale_fill_gradientn() y pasar la paleta blups como 
#   argumento de colores.
preds <- readRDS("~/geostat/viz/cap3/01_corv_predicted_grid.rds")

ggplot(preds) +
  geom_tile(aes(lon, lat, fill = predicted_price), alpha = 0.8)+
  scale_fill_gradientn(colors = blups)

# instruccion 2
# * Crea una paleta llamada vir a partir de 9 pasos en la paleta 
#   viridis() de viridisLite.
vir <- viridis(n = 9)

# * Añade scale_fill_gradientn() y pasa la paleta vir como argumento
#   de colores.
ggplot(preds) +
  geom_tile(aes(lon, lat, fill = predicted_price), alpha = 0.8)+
  scale_fill_gradientn(colors = vir)

# instruccion 3
# * Crea una paleta llamada mag a partir de 9 pasos en la paleta 
#   magma() de viridisLite.
mag <- magma(n = 9)

# * Añade scale_fill_gradientn() y pasa la paleta mag como argumento
#   de colores.
ggplot(preds) +
  geom_tile(aes(lon, lat, fill = predicted_price), alpha = 0.8) + 
  scale_fill_gradientn(colors = mag)

# Si sabes que quieres una paleta RColorBrewer, hay un atajo. 
# Añade scale_xxx_distiller y sólo tendrás que especificar el 
# nombre de la paleta en el argumento palette. 
# Ver scale_fill_distiller.

# ejercicio 3 ----
# Paleta personalizada en tmap

# A diferencia de ggplot2, donde la configuración de una escala 
# de color personalizada se realiza en una llamada a scale_, los
# colores en las capas de tmap se especifican en la capa en la que
# se mapean. Por ejemplo, tome un gráfico de la variable age_18_24
# de prop_by_age:
 prop_by_age <- readRDS(file = "_data/03-proportion-by-age.rds") 
tm_shape(prop_by_age) +
  tm_raster(col = "age_18_24") 

# Como el color se mapea en la llamada tm_raster(), la especificación
# de la paleta también se produce en esta llamada. Simplemente se
# especifica un vector de colores en el argumento de la paleta. 
# Esta es otra razón por la que vale la pena aprender a generar 
# un vector de colores. Mientras que diferentes paquetes pueden
# tener diferentes atajos para especificar paletas de paquetes 
# de color, generalmente siempre tendrán una manera de pasar un 
# vector de colores.

# Usemos algunas paletas del último ejercicio con este gráfico.

# instruccion 
# * En el primer gráfico, utilice la paleta blups en lugar de la 
#   predeterminada.

# * En el segundo gráfico, utilice la paleta vir en lugar de la
#   predeterminada.

# * En el tercer gráfico, utilice la paleta rev(mag) en lugar de 
#   la predeterminada. rev() simplemente invierte el orden de un 
#   vector, así que esto utiliza los mismos colores pero en el 
#   orden opuesto.


# Generate palettes from last time
library(RColorBrewer)
blups <- brewer.pal(9, "BuPu")

library(viridisLite)
vir <- viridis(9)
mag <- magma(9)

# Use the blups palette
tm_shape(prop_by_age) +
  tm_raster("age_18_24",palette = blups) +
  tm_legend(position = c("right", "bottom"))

# Use the vir palette
tm_shape(prop_by_age) +
  tm_raster("age_18_24",palette = vir) +
  tm_legend(position = c("right", "bottom"))

# Use the mag palette but reverse the order
tm_shape(prop_by_age) +
  tm_raster("age_18_24",palette = rev(mag)) +
  tm_legend(position = c("right", "bottom"))