# paquetes ----
library(sp)

# datos ----
countries_sp <- readRDS("~/geostat/viz/cap2/02_countries_sp.rds")
countries_spdf <- readRDS("~/geostat/viz/cap2/02_countries_spdf.rds")

# subset by index
str(countries_spdf[1,], max.level = 2)

# ejercicio 1 ----

# Subconjunto por índice

# El subconjunto de objetos Spatial___DataFrame está construido
# para funcionar como el subconjunto de un marco de datos. Se
# piensa en el subconjunto del marco de datos, pero en la 
# práctica lo que se devuelve es un nuevo Spatial___DataFrame 
# con sólo las filas de datos que se desean y los objetos 
# espaciales correspondientes.

# El tipo de subconjunto más sencillo es por índice. Por 
# ejemplo, si x es un marco de datos se sabe que x[1, ] 
# devuelve la primera fila. Si x es un Spatial___DataFrame, 
# se obtiene un nuevo Spatial___DataFrame que contiene la 
# primera fila de datos y los datos espaciales que 
# corresponden a esa fila.

# La ventaja de devolver un Spatial___DataFrame es que se 
# pueden utilizar los mismos métodos que en el objeto antes 
# de la subdivisión.

# Vamos a probarlo con el país 169.

# instruccion

# * Cree una nueva variable usa subconjuntando el elemento 169
#   de countries_spdf.

usa <- countries_spdf[169,]

# * Llame a summary() en usa. Compruebe que usa sigue siendo 
#   un SpatialPolygonsDataFrame.

summary(usa)

# * Llame a str() con max.level = 2 en usa. Compruebe que sólo
#   hay un elemento de la ranura de polígonos y sólo una fila 
#   en la ranura de datos.

str(usa , max.level = 2)

# * Llame a plot() sobre usa.

plot(usa)

# ejercicio 2 ----

# Acceso a los datos en los objetos sp

# Es bastante inusual saber exactamente los índices de los 
# elementos que quieres conservar, y es mucho más probable que
# quieras hacer un subconjunto basado en los atributos de los 
# datos. Has visto que los datos asociados a un Spatial___DataFrame
# viven en la ranura de datos, pero normalmente no se accede a
# esta ranura directamente.

# En su lugar,$ y [[ subconjuntos en un Spatial___DataFrame 
# sacan las columnas directamente del marco de datos. Es decir,
# si x es un objeto Spatial___DataFrame, entonces x$col_name o 
# x[["col_name"]] saca la columna col_name del marco de datos.
# Piensa en esto como un atajo; en lugar de tener que sacar la
# columna correcta del objeto en el marco de datos (es decir, 
# x@data$col_name), puedes usar simplemente x$col_name.
                   
# Comencemos confirmando que el objeto en la ranura de datos es
# un marco de datos normal, y luego practiquemos la extracción
# de columnas.

# instrucciones

# * Llame a head() y str() (una a la vez) en la ranura de 
#   dats de countries_spdf. Compruebe que este objeto es un 
#   marco de datos normal.

head(countries_spdf@data)
str(countries_spdf@data)

# * Extraiga la columna de name de countries_spdf utilizando
#   $.
countries_spdf$name

# * Extraiga la columna subregion de countries_spdf utilizando
#   [[.
countries_spdf[["subregion"]]

# ejercicio 3 ----
# Subconjunto basado en atributos de datos

# El subconjunto basado en los atributos de los datos es una
# combinación de la creación de una lógica a partir de las 
# columnas de su marco de datos y el subconjunto del objeto 
# Spatial___DataFrame. Esto es similar a la forma en que se 
# subconjunta un marco de datos ordinario.

# Cree una lógica a partir de una columna, digamos países en
# Asia:
  
in_asia <- countries_spdf$region == "Asia"
in_asia

# A continuación, utilice la lógica para seleccionar las 
# filas del objeto Spatial___DataFrame:

countries_spdf[in_asia, ]

#¿Puedes eliminar el subconjunto de Nueva Zelanda y trazarlo?

# instruccion 

# * Cree un vector lógico llamado is_nz que compruebe si la 
# * columna nombre es igual a "Nueva Zelanda".
is_nz <- countries_spdf$name == "New Zealand"

# * Cree un nuevo objeto espacial llamado nz utilizando is_nz
#   para subconjuntar countries_spdf.
nz <- countries_spdf[is_nz,]

# * Traza nz.
plot(nz)

# ejercicio 3 ----
# tmap, un paquete que trabaja con objetos sp

# Has tenido que aprender bastantes cosas nuevas sólo para 
# poder entender y hacer una manipulación básica de estos 
# objetos espaciales definidos por sp, ¡pero ahora puedes 
# experimentar alguna recompensa! Hay una serie de paquetes 
# que esperan los datos espaciales en objetos sp y que facilitan
# el trabajo con datos espaciales.

# Echemos un vistazo al paquete tmap para crear mapas. Aprenderás
# más sobre su filosofía y estructura en el siguiente vídeo, 
# pero primero queremos que veas lo fácil que es de usar.

# tmap tiene la función qtm() para crear mapas temáticos rápidos.
# Sigue las ideas de qplot() de ggplot2 pero con un par de diferencias
# importantes. En lugar de esperar datos en un marco de datos
# como ggplot2(), espera datos en un objeto espacial y utiliza 
# el argumento shp para especificarlo. Otra diferencia importante
# es que tmap no utiliza la evaluación no estándar (ver el curso 
# Writing Functions in R para más información), por lo que las
# variables deben estar rodeadas de comillas cuando se especifican
# los mapeos.

# Pruebe este ejemplo en la consola:
  
library(tmap)
qtm(shp = countries_spdf, fill = "population")

# ¿Qué tan fácil fue eso? ¿Puedes hacer un coropleto de otra 
# variable contenida en countries_spdf: gdp?

# instruccion
# Utilizando el ejemplo como guía, cree un mapa coropleto de
# la variable gdp utilizando qtm().

qtm(shp = countries_spdf, fill = "gdp")
