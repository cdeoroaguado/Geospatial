# paquetes ----
library(classInt)

# datos ----
preds <- readRDS("~/geostat/viz/cap3/01_corv_predicted_grid.rds")
values <- preds$predicted_price

# ejemplos ----
# intervalos iguales
classIntervals(values, n = 5, style = "equal")

# intervalos por cuartiles
classIntervals(values, n = 5, style = "quantile")

# intervalos por pretty
classIntervals(values, n = 5, style = "pretty")

# invervalos por decision del investigador
classIntervals(values, style = "fixed",
               fixedBreaks = c(100000, 230000, 255000, 300000))

# ejericicio 1 ----
# Un ejemplo de escala de intervalo

# Volvamos a su gráfico de la proporción de la población que está 
# entre 18 y 24 años:

prop_by_age <- readRDS(file = "_data/03-proportion-by-age.rds")
tm_shape(prop_by_age) +
  tm_raster("edad_18_24", paleta = vir) +
  tm_legend(position = c("right", "bottom"))
# Tu gráfico era problemático porque la mayoría de las proporciones
# caían en el nivel de color más bajo y, en consecuencia, no se veía
# mucho detalle en tu gráfico. Una forma de resolver este problema
# es la siguiente: en lugar de dividir el rango de su variable en 
# intervalos de igual longitud, puede dividirlo en categorías más 
# útiles.

# Empecemos por replicar los intervalos por defecto de tmap: cinco
# categorías, cortadas con cortes "bonitos". Luego puede probar 
# algunos de los otros métodos para cortar una variable en 
# intervalos. El uso directo de la función classIntervals() le 
# permite saber rápidamente cuáles serán los cortes, pero la mejor
# manera de probar un conjunto de cortes es trazarlos.

# (Como apunte, otra forma de resolver este tipo de problema es 
# buscar una transformación de la variable para que sean más 
# útiles los intervalos de igual longitud de la escala transformada).

# instruccion

# * Llame a classIntervals() sobre values(prop_by_age[["age_18_24"]])
#   con n = 5 y style = "pretty". ¿Ve el problema? 130.770 de sus 
#   celdas de la cuadrícula terminan en la primera casilla.
classIntervals(values(prop_by_age[["age_18_24"]]), 
               n = 5, style = "pretty")

# * Ahora llame a classIntervals() como arriba, pero con style = "quantile".
classIntervals(values(prop_by_age[["age_18_24"]]), 
               n = 5, style = "quantile")

# * Utilice los intervalos equisados pasando los argumentos n y 
#   estilo a la capa tm_raster() de su gráfico.
tm_shape(prop_by_age$age_18_24) +
  tm_raster(palette = mag, style = "quantile") +
  tm_legend(position = c("right", "bottom"))

# * Haga un histograma de valores(prop_by_age[["age_18_24"]]). 
#   ¿Dónde harías los cortes?
hist(values(prop_by_age)[, "age_18_24"])

# * Cree sus propios saltos en tm_raster() especificando 
#   breaks = c(0.025, 0.05, 0.1, 0.2, 0.25, 0.3, 1).
tm_shape(prop_by_age) +
  tm_raster("age_18_24", palette = mag,
            style = "fixed",
            breaks = c(0.025, 0.05, 0.1, 0.2, 0.25, 0.3, 1)) -> map

# * Guarde su gráfico final como un gráfico de folleto utilizando 
#   tmap_save() y el nombre de archivo "prop_18-24.html".
tmap_save(tm = map, filename = "home/carlos/geostat/viz/cap3/prop_18-24.html")

# ejercicio 2 ----
# Un ejemplo de escala divergente

# Veamos otro conjunto de datos en el que la escala de colores por
# defecto no es apropiada. Esta trama, la migración, tiene una 
# estimación del número neto de personas que se han trasladado 
# a cada celda de la trama entre los años 1990 y 2000. Un número
# positivo indica una inmigración neta, y un número negativo una
# emigración. Echa un vistazo:
  
tm_shape(migration) +
  tm_raster() +
  tm_legend(outside = TRUE, 
            outside.position = c("bottom"))

# La escala de color por defecto no parece muy útil, pero tmap 
# está haciendo algo bastante inteligente: ha elegido automáticamente
# una escala de color divergente. Una escala divergente es apropiada 
# ya que los grandes movimientos de la gente son grandes números 
# positivos o grandes (en magnitud) números negativos. Cero (es 
# decir, ninguna migración neta) es un punto medio natural.

# tmap elige una escala divergente cuando hay valores positivos y
# negativos en la variable mapeada y elige el cero como punto 
# medio. Este no es siempre el enfoque correcto. Imagine que está
# mapeando un cambio relativo en forma de porcentajes; el 100% 
# podría ser el punto medio más intuitivo. Si necesita algo 
# diferente, la mejor manera de proceder es generar una paleta 
# divergente (con un número impar de pasos, para que haya un color
# intermedio) y especificar usted mismo las pausas.

# Veamos si puedes obtener un mapa más informativo añadiendo tú 
# mismo una escala divergente.

# (Fuente de datos: de Sherbinin, A., M. Levy, S. Adamo, K. 
# MacManus, G. Yetman, V. Mara, L. Razafindrazay, B. Goodrich, 
# T. Srebotnjak, C. Aichele y L. Pistolesi. 2015. Cuadrículas 
# mundiales de migración neta estimada por década: 1970-2000. 
# Palisades, NY: NASA Socioeconomic Data and Applications Center
# (SEDAC). http://dx.doi.org/10.7927/H4319SVC Consultado el 27 
# de septiembre de 2016)

# instruccion
# * Imprime la migración para verificar que se trata de un objeto
#   RasterLayer y echa un vistazo al rango de valores de la 
#   migración.
migration <- readRDS(file = "_data/03_migration.rds")
print(migration)

# * Genere una paleta divergente, llamada red_gray, de 7 colores
#   desde la paleta "RdGy" en RColorBrewer.
red_gray <- brewer.pal(7, "RdGy")

# * Utilice el conjunto de colores divergentes, red_gray, como
#   paleta para su gráfico. Esto utiliza sus colores, pero las 
#   pausas no son útiles.
tm_shape(migration) +
  tm_raster(palette = red_gray) +
  tm_legend(outside = TRUE, outside.position = c("bottom"))

# * Añade pausas fijas para la escala de colores de: 
#   c(-5e6, -5e3, -5e2, -5e1, 5e1, 5e2, 5e3, 5e6)
tm_shape(migration) +
  tm_raster(palette = red_gray, style = "fixed", 
            breaks = c(-5e6, -5e3, -5e2, -5e1, 5e1, 5e2, 5e3, 5e6)) +
  tm_legend(outside = TRUE, outside.position = c("bottom"))

# Por fin tienes un mapa útil. ¿Puedes ver la migración hacia el 
# sur, lejos de México, y lejos de partes del noreste?

# ejercicio 3 ----
#Un ejemplo cualitativo

# Por último, veamos un ejemplo de variable categórica. El ráster
# land_cover contiene una categorización cuadriculada de la 
# superficie terrestre. Eche un vistazo a land_cover imprimiéndolo:

land_cover

# Observará que los valores son numéricos, pero hay atributos que
# asignan estos números a categorías (al igual que el funcionamiento
# de los factores).

# La elección de los colores para las variables categóricas 
# depende mucho del propósito del gráfico. Cuando se quiere que las
# categorías tengan aproximadamente el mismo peso visual -es decir,
# no se quiere que una categoría destaque más que las otras- una 
# aproximación es utilizar colores de diferentes tonalidades, pero
# con igual croma (una medida de la vivacidad) y luminosidad 
# (esto es lo que se hace por defecto para las escalas de color 
# discretas en ggplot2 y se puede generar utilizando la función 
# hcl()).

# Las paletas cualitativas de RColorBrewer equilibran el hecho de
# tener colores de igual peso visual con la facilidad de 
# identificación del color. Los esquemas "emparejados" y 
# "acentuados" se desvían de esto al proporcionar pares de 
# colores de diferente luminosidad y una paleta con algunos 
# colores más intensos que pueden utilizarse para resaltar 
# ciertas categorías, respectivamente.

# Para estos datos en particular, podría tener más sentido elegir
# colores intuitivos, como el verde para el bosque y el azul para
# el agua. Cualquiera que sea más apropiado, establecer nuevos 
# colores es sólo cuestión de pasar un vector de colores a través
# del argumento de la paleta en la capa tm_*** correspondiente.

# instruccion 
# * Traza el raster de land_cover combinando tm_shape() y 
#   tm_raster(). Por defecto tmap utiliza la paleta cualitativa 
#   RColorBrewer "Set3".
tm_shape(land_cover) +
  tm_raster()
# * Examine el código para hcl_cols, que imita la paleta utilizada
#   por ggplot2. A continuación, vuelva a trazar la trama de 
#   land_cover, pasando hcl_cols al argumento de la paleta a 
#   tm_raster().
hcl_cols <- hcl(h = seq(15, 375, length = 9), 
                c = 100, l = 65)[-9]
tm_shape(land_cover) +
  tm_raster(palette = hcl_cols) 

# * Llame a levels() sobre land_cover para ver las categorías.
str(land_cover)
summary(land_cover)
levels(land_cover)
# * Esta vez, utilice intuitive_cols como paleta y añada una capa
#   tm_legend() con el argumento position = c("left", "bottom").

tm_shape(land_cover) +
  tm_raster(palette = intuitive_cols) +
  tm_legend(position = c("left", "bottom"))