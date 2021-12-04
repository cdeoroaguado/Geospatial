# paquetes
library(rgdal)

# ejemplo
x <- SpatialPoints(data.frame(-123.2620, 44.5646))
x

proj4string(x) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
x

spTransform(x, "+proj=lcc +lat_1=40.66666666666666
+lat_2=41.03333333333333 +lat_0=40.16666666666666
+lon_0=-74 +x_0=300000 +y_0=0 +datum=NAD83
+units=us-ft +no_defs +ellps=GRS80 +towgs84=0,0,0")

spTransform(x, proj4string(neighborhoods))

# ejercicio 1 ----
# Fusión de datos de diferentes SRC/proyecciones
# Cada objeto espacial tiene asociado un sistema de referencia de coordenadas
# (CRS). Por lo general, éste se establece cuando se importan los datos y se 
# lee directamente de los archivos espaciales. Así es como los barrios y 
# nyc_tracts obtuvieron la información de su sistema de coordenadas.

# Tanto el paquete sp como el raster tienen una función proj4string() que 
# devuelve el CRS del objeto al que se llama.

# Tratar de trabajar con datos espaciales utilizando diferentes CRSs es un
# poco como tratar de trabajar con un conjunto de datos en millas y otro en 
# kilómetros. Están midiendo lo mismo, pero los números no son directamente 
# comparables.

# Echemos un vistazo a nuestros dos objetos poligonales.

# instruccion
# * Llame a proj4string() en neighborhoods, y luego de nuevo en nyc_tracts. 
#   Compruebe que las dos cadenas son diferentes.
proj4string(nyc_tracts)
proj4string(neighborhoods)

# * Echa un vistazo a la head() de las coordinates() de neighborhoods y 
#   repite para nyc_tracts. ¿Puedes ver el problema? nyc_tracts tiene 
#   coordenadas x alrededor de -70, ¡pero neighborhoods está alrededor de 
#   1.000.000!
head(coordinates(nyc_tracts))
head(coordinates(neighborhoods))

# * Traza neighborhoods, luego traza nyc_tracts con col = "red" y add = TRUE 
#   para añadirlos encima.

plot(neighborhoods)
plot(nyc_tracts, add = TRUE, col = "red")

# ¿Por qué no vimos los tramos en nuestra parcela de los barrios? 
# Simplemente porque las coordenadas de los tramos los sitúan muy lejos de 
# los límites de nuestro plot.