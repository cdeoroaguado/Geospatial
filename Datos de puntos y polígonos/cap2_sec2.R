# paquetes ----
library(sp)

# datos ----
countries_sp <- readRDS("~/geostat/viz/cap2/02_countries_sp.rds")
countries_spdf <- readRDS("~/geostat/viz/cap2/02_countries_spdf.rds")

# ejemplo
summary(countries_sp)
summary(countries_spdf)

# acceder a las ranuras (slot)
proj4string(countries_sp)
countries_sp@proj4string
slot(countries_sp, "proj4string")

# ejercicio 1 ----
# Practiquemos el acceso a las ranuras explorando la forma 
# en que se almacenan los polígonos dentro de los objetos 
# SpatialDataFrame. Recuerda que hay dos maneras de acceder a
# las ranuras en un objeto S4:

# x@slot_name # or...
# slot(x, "slot_name")

# Así que, para echar un vistazo a la ranura de polígonos 
# de countries_spdf, simplemente haz countries_spdf@polygons.
# Puedes intentarlo, pero obtendrás una salida larga y poco 
# informativa. En su lugar, veamos la estructura de alto nivel.

# Prueba a ejecutar el siguiente código en la consola:

# str(countries_spdf@polygons, max.level = 2)
str(countries_spdf@polygons, max.level = 2)

# Sigue siendo una salida bastante larga, pero desplázate 
# hasta la parte superior y echa un vistazo. ¿Qué clase de 
# objeto es éste? Es sólo una lista, pero dentro de sus 
# elementos hay otro tipo de clase sp: Polígonos. Hay 177 
# elementos de lista. ¿Adivinas qué pueden representar?

# Vamos a investigar uno de estos elementos.

# instruccion 1
# * Cree una nueva variable llamada one que contenga el 
#   elemento 169 de la lista en la ranura de polígonos de 
#   countries_spdf. Utilice el subconjunto de corchetes dobles
#   (es decir, [[...]]) para extraer este elemento.

one <- countries_spdf@polygons[[169]]

# * Imprime one
print(one)

# * Llama a summary() sobre one. ¿Qué ranuras tiene este 
#   objeto?

summary(one)

# * Llama a str() en one con nivel máximo = 2.

str(one, max.level = 2)

# ejercicio 2 ----

# Más allá de la madriguera del conejo

# En el último ejercicio, el SpatialPolygonsDataFrame tenía 
# una lista de polígonos en su ranura polygons, y cada uno de
# esos objetos Polygons también tenía una ranura Polygons. 
# Por lo tanto, muchos polígonos... ¡pero aún no está en la 
# parte inferior de la jerarquía!
  
# Echemos otro vistazo al elemento 169 de la ranura Polígonos
# de countries_spdf. Ejecuta este código del ejercicio anterior:

# one <- countries_spdf@polygons[[169]]
# str(uno, nivel máximo = 2)

# La ranura Polygons tiene una lista dentro con 10 elementos.
# ¿Cuáles son estos objetos? Sigamos cavando....

# instruccion

one <- countries_spdf@polygons[[169]]

# * Llame a str() con max.level = 2 en la ranura Polygons 
#   de one.
str(countries_spdf, max.level = 2)
str(one,max.level = 2)
str(one@Polygons, max.level = 2)
# * Llame a str() con max.level = 2 en el 6º elemento de la 
#   ranura Polygons de one. ¿Ves algo que parece ser datos 
#   espaciales?

str(one@Polygons[[6]],max.level = 2)  

# * Llame a plot() en la ranura coords del 6º elemento de la
#   ranura Polygons de one. ¿Reconoce los datos que contiene
#   este objeto?

plot(one@Polygons[[6]]@coords)

# Dado que one@Polygons[[6]]@coords es sólo una matriz, 
# esta llamada a plot() utiliza el método plot por defecto,
# no el especial para objetos espaciales.
