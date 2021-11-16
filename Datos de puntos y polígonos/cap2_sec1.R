# paquetes ----
library(sp)

# datos ----
countries_sp <- readRDS("~/geostat/viz/cap2/02_countries_sp.rds")
countries_spdf <- readRDS("~/geostat/viz/cap2/02_countries_spdf.rds")

# ejercicio 1  ----
# Veamos un objeto espacial

# Hemos cargado un objeto sp particular en su espacio de 
# trabajo: countries_sp. Existen métodos especiales print(), 
# summary() y plot() para estos objetos. ¿Qué es un método?
# Es una versión especial de una función que se utiliza en 
# función del tipo de objeto que se le pasa. Es habitual que
# cuando un paquete crea nuevos tipos de objetos contenga 
# métodos para su simple exploración y visualización.

# En la práctica, esto significa que puedes llamar a 
# plot(countries_sp) y si hay un método para la clase de 
# countries_sp, se llama. El método print() es el que se 
# llama cuando simplemente se escribe el nombre de un objeto
# en la consola.

# ¿Puedes averiguar qué clase de objeto es este countries_sp?
# ¿Puedes ver qué sistema de coordenadas utilizan estos datos
# espaciales? ¿Qué describen los datos del objeto?
  
# Print countries_sp. ¿Por qué no es muy útil?
print(countries_sp)

# Call summary() on countries_sp
summary(countries_sp)

# Call plot() on countries_sp
plot(countries_sp)

# ejercicio 2 ----
# ¿Qué hay dentro de un objeto espacial?
  
# ¿Qué aprendiste sobre los métodos en el ejercicio anterior?
# print() da una forma impresa del objeto, pero a menudo es 
# demasiado larga y no es muy útil. summary() proporciona una
# descripción mucho más concisa del objeto, incluyendo su 
# clase (en este caso SpatialPolygons), la extensión de los 
# datos espaciales y la información del sistema de referencia
# de coordenadas (aprenderás más sobre esto en el capítulo 4). plot() muestra el contenido, en este caso dibujando un mapa del mundo.

# Pero, ¿cómo se almacena esa información en el objeto 
# SpatialPolygons? En este ejercicio explorarás la estructura
# de este objeto. Ya conoces el uso de str() para mirar los 
# objetos de R, pero lo que quizás no sepas es que toma un 
# argumento opcional max.level que restringe hasta dónde 
# llega la jerarquía del objeto que str() imprime. Esto puede
# ser útil para limitar la cantidad de información que tiene
# que manejar.

# Veamos si puedes manejar cómo está estructurado este objeto.

# Call str() on countries_sp. Esto no será muy útil, 
# excepto para convencerte de que es una estructura 
# complicada.
str(countries_sp)

# Call str() on countries_sp, setting max.level to 2.
# ¿Qué hay en el nivel más alto de este objeto? ¿Puedes 
# ver dónde se pueden almacenar las cosas?
str(object = countries_sp,max.level = 2)

# ejercicio 3 ----
# Un objeto espacial más complicado

# Probablemente haya notado algo diferente en la estructura 
# de countries_sp. Se parece mucho a una lista, pero en lugar
# de que los elementos estén precedidos por $ en la salida, 
# están precedidos por una @. Esto se debe a que las clases
# sp son objetos S4, por lo que en lugar de tener elementos
# tienen ranuras y se accede a ellas con @. Aprenderás más 
# sobre esto en el próximo video.

# Ahora vamos a ver otro objeto countries_spdf. Es un poco 
# más complicado que countries_sp, pero ahora estás bien 
# equipado para averiguar en qué se diferencia este objeto.

# Echa un vistazo.

# instrucción
# * Llama a summary() sobre countries_sp y luego sobre este 
#   nuevo objeto countries_spdf (de uno en uno).
#   ¿Qué tipo de objeto es éste? ¿Qué diferencia hay entre 
#   éste y countries_sp?
summary(countries_sp)
summary(countries_spdf)
  
# * Llame a str() con nivel máximo = 2 en countries_spdf. 
#   ¿En qué se diferencia la estructura de countries_sp?
str(object = countries_spdf,max.level = 2)

# * Llama a plot() sobre countries_spdf.
plot(countries_spdf)
