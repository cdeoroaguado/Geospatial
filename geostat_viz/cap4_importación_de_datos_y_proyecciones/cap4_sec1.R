# paquetes ----
library(sp)
library(rgdal)
library(raster) 

# datos ----
#nynta_16c <- readRDS(file = "_data/04_nynta_16c.rds")
#rgdal::writeOGR(nynta_16c, "_data/nynta_16c", "nynta", driver = "ESRI Shapefile")

# ejercicio 1 ----
# Lectura de un shapefile

# Los shapefiles son una de las formas más comunes de compartir datos 
# espaciales y se leen fácilmente en R utilizando readOGR() del paquete rgdal.
# readOGR() tiene dos argumentos importantes: dsn y layer. Lo que se pasa exactamente
# a estos argumentos depende del tipo de datos que se esté leyendo. En el vídeo 
# aprendiste que para los shapefiles, dsn debe ser la ruta del directorio que 
# contiene los archivos que componen el shapefile y layer es el nombre del 
# archivo del shapefile en particular (sin ninguna extensión).

# Para su mapa, quiere los límites de los barrios. Hemos descargado las áreas 
# de tabulación de los barrios, definidas por la ciudad de Nueva York, de la 
# Plataforma de Datos Abiertos del Departamento de Planificación Urbana. 
# https://www1.nyc.gov/site/planning/data-maps/open-data/census-download-metadata.page?tab=2
# La descarga fue en forma de archivo zip y hemos puesto el resultado de 
# descomprimir el archivo descargado en su directorio de trabajo.

# Utilizarás la función dir() de la base R para examinar el contenido de tu
# directorio de trabajo y luego leerás el shapefile en R.

# instruccion 

# * Utilice dir() sin argumentos para averiguar el nombre del directorio 
#   del shapefile.
# dir()

# * Utilice dir(), pasando la ruta al directorio del shapefile, para ver los
#   archivos que hay dentro.

dir("_data/nynta_16c")

# * Ahora ya sabe el nombre del directorio y de los archivos. Utilice readOGR()
#   para leer el shapefile de los barrios en un objeto llamado neighborhoods.

neighborhoods <- readOGR("_data/nynta_16c", "nynta")

# * Compruebe el contenido llamando a summary() en neighborhoods.
summary(neighborhoods)

# * Compruebe el contenido trazando los neighborhoods.
plot(neighborhoods)

# ejercicio 2 ----
# Lectura de un archivo raster

# Los archivos raster se leen más fácilmente en R con la función raster() del 
# paquete raster. Basta con pasar el nombre del archivo (incluyendo la 
# extensión) del raster como primer argumento, x.

# La función raster() utiliza algunas funciones nativas del paquete raster 
# para leer ciertos tipos de archivos (basándose en la extensión del nombre 
# del archivo) y, por lo demás, pasa la lectura del archivo a readGDAL() 
# del paquete rgdal. El beneficio de no usar readGDAL() directamente es 
# simplemente que raster() devuelve un objeto RasterLayer.

# Un tipo común de archivo raster es el GeoTIFF, con extensión de archivo 
# .tif o .tiff. Hemos descargado un raster de ingresos medios del censo de los
# Estados Unidos y lo hemos puesto en su directorio de trabajo.

# Vamos a echarle un vistazo y a leerlo.

# instruccion 

#income_grid_raster <- readRDS(file = "_data/04_income_grid.rds")
#income_grid_raster <- raster(income_grid_raster)
#raster::writeRaster(income_grid_raster,"_data/nyc_grid_data/m5602ahhi00.tif", options=c('TFW=YES'))

# * Utilice dir() para echar un vistazo en su directorio de trabajo.
dir()

# * Utilice dir() de nuevo para mirar dentro del directorio nyc_grid_data.
dir("nyc_grid_data")

# * Utilice raster() para leer la trama de ingresos medios en la variable 
#   income_grid pasando la ruta completa al archivo .tif.
income_grid <- raster("_data/nyc_grid_data/m5602ahhi00.tif")

# * Utilice summary() para verificar que el ráster se almacena en un 
#   RasterLayer.
summary(income_grid)

# * Utilice plot() para verificar el contenido de la trama.
plot(income_grid)

# ejercicio 3 ----
# Obtención de datos mediante un paquete

# La lectura de datos espaciales desde un archivo es una forma de obtener 
# datos espaciales en R, pero también hay algunos paquetes que proporcionan 
# datos espaciales de uso común. Por ejemplo, el paquete rnaturalearth 
# proporciona datos de Natural Earth (http://www.naturalearthdata.com/), 
# una fuente de mapas mundiales de alta resolución que incluye costas, 
# estados y lugares poblados. De hecho, ésta fue la fuente de los datos del
# capítulo 2.

# Se examinará la renta media a nivel de sección censal en el condado de 
# Nueva York (también conocido como el Bourough de Manhattan), pero para 
# ello será necesario conocer los límites de las secciones censales. El 
# paquete tigris de R permite descargar e importar fácilmente archivos shape
# basados en las geografías del censo de Estados Unidos. Utilizaremos la 
# función tracts() para descargar los límites de los tramos, pero tigris 
# también proporciona states(), counties(), places() y muchas otras funciones
# que coinciden con los distintos niveles de entidades geográficas definidas
# por el Censo.

# Vamos a tomar los datos espaciales de los tracts..

# instruccion
library(sp)
library(tigris)

# * Llame a tracts() con state = "NY", county = "New York", y 
#   cb = TRUE. Guarde el resultado en nyc_tracts.
nyc_tracts <- tracts(state = "NY", county = "New York", cb = TRUE)

nyc_tracts <- as_Spatial(nyc_tracts)
# * Utilice summary() en nyc_tracts para verificar que el objeto devuelto es 
#   un SpatialPolygonsDataFrame.
summary(nyc_tracts)

# * Trazar nyc_tracts para comprobar el contenido con plot().
plot(nyc_tracts)

# En caso de que te lo preguntes, el argumento final cb = TRUE descarga 
# los límites de menor resolución, lo que hace que la descarga sea más 
# rápida.
