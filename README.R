


setwd("D:/R/Practica") #cambiar el working directory

library(tidyverse)
if (!"mapSpain" %in% installed.packages()) {install.packages("mapSpain", dependencies = TRUE)}
library (mapSpain)

if (!"eurostat" %in% installed.packages()) {install.packages("eurostat", dependencies = TRUE)}
library(eurostat)


tema_1 <- function(base_size = 13,
                    base_family = "sans"
)
{
  
  tema <-
    theme_bw(base_size=base_size) +
    
    theme(legend.position="none") +
    theme(legend.text = element_text(size=base_size+1,family = base_family)) +
    theme(plot.title=element_text(size=base_size+4,
                                  face = "bold",
                                  vjust=1.25, 
                                  family=base_family, 
                                  hjust = 0.5
    )) +
    
    theme(plot.subtitle=element_text(size=base_size+3, family = base_family,  hjust = 0.5))  +
    theme(text = element_text(size=base_size+2,family = base_family)) +
    theme(axis.text.x=element_text(size=base_size+1,family = base_family)) +
    theme(axis.text.y=element_text(size=base_size+1, family = base_family)) +
    
    theme(axis.title.x=element_text(size=base_size+2, vjust=0, family = base_family)) +
    theme(axis.title.y=element_text(size=base_size+2, vjust=1.25, family = base_family)) +
    theme(plot.caption=element_text(size=base_size, family = base_family)) +
    theme(strip.text = element_text(size=base_size, family = base_family)) +
    theme(strip.text.x = element_text(size=base_size, family = base_family)) +
    theme(strip.text.y = element_text(size=base_size, family = base_family)) +
    theme(plot.caption = element_text(hjust = 1))+
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
  
  return (tema)
}

tema_2 <- function(base_size = 13,
                    base_family = "sans"
)
{
  
  tema <-
    
    theme(legend.position="right") +
    theme(legend.text = element_text(size=base_size+1,family = base_family)) +
    theme(plot.title=element_text(size=base_size+4,
                                  face = "bold",
                                  vjust=1.25, 
                                  family=base_family, 
                                  hjust = 0.5
    )) +
    
    theme(plot.subtitle=element_text(size=base_size+3, family = base_family,  hjust = 0.5))  +
    theme(text = element_text(size=base_size+2,family = base_family)) +
    theme(axis.text.x=element_text(size=base_size+1,family = base_family)) +
    theme(axis.text.y=element_text(size=base_size+1, family = base_family)) +
    
    theme(axis.title.x=element_blank()) +
    theme(axis.title.y=element_blank()) +
    theme(plot.caption=element_text(size=base_size, family = base_family)) +
    theme(axis.line.x = element_blank())+
    theme(axis.text.x = element_blank())+
    theme(axis.text.y = element_blank())+
    theme(axis.line.y = element_blank())+
    theme(axis.ticks.x = element_blank())+
    theme(axis.ticks.y = element_blank())+
    theme(panel.background = element_rect(fill = "lightblue"))+
    theme(strip.text = element_text(size=base_size, family = base_family)) +
    theme(plot.caption = element_text(hjust = 1))+
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
  
  return (tema)
}

tema_3 <- function(base_size = 13,
                   base_family = "sans"
)
{
  
  tema <-
    theme_bw(base_size=base_size) +
    
    theme(legend.position="none") +
    theme(plot.title=element_text(size=base_size+4,
                                  face = "bold",
                                  vjust=1.25, 
                                  family=base_family, 
                                  hjust = 0.5
    )) +
    
    theme(plot.subtitle=element_text(size=base_size+3, family = base_family,  hjust = 0.5))  +
    theme(text = element_text(size=base_size+2,family = base_family)) +
    theme(axis.text.x=element_text(size=base_size+1,family = base_family)) +
    theme(axis.text.y=element_text(size=12,family = base_family)) +
  
    
    theme(axis.title.x=element_text(size=base_size+2, vjust=0, family = base_family)) +
    theme(axis.title.y=element_text(size=base_size+2, vjust=1.25, family = base_family)) +
    theme(plot.caption=element_text(size=base_size, family = base_family)) +
    theme(strip.text = element_text(size=base_size, family = base_family)) +
    theme(strip.text.x = element_text(size=base_size, family = base_family)) +
    theme(strip.text.y = element_text(size=base_size, family = base_family)) +
    theme(plot.caption = element_text(hjust = 1))+
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
  
  return (tema)
}

################ GRÁFICA 1 TASA DE EMPLEO POR COMUNIDAD AUTÓNOMA


tasa_empleo_ccaa <- read_csv2("Tasa de empleo por CCAA y periodo.csv")
tasa_empleo_ue <- read.csv2("Tasa de empleo por ámbito geográfico y periodo.csv")


var_periodo <- 2019

#Nos quedamos con el año 2019
tasa_empleo_ccaa <- filter(tasa_empleo_ccaa, periodo == var_periodo)
#Nos quedamos con el año 2019 y la UE
tasa_empleo_ue <- filter(tasa_empleo_ue, periodo == var_periodo & Ámbito.geográfico == "Unión Europea")

#Eliminamos las filas nulas
tasa_empleo_ccaa <- na.omit(tasa_empleo_ccaa)

tasa_empleo_ccaa <- select(tasa_empleo_ccaa, -"Total Nacional")

#Modificamos los nombres de las columnas para su union
colnames(tasa_empleo_ccaa)[1] <- "CCAA"
colnames(tasa_empleo_ue)[1] <- "CCAA"

#Eliminamos los números de las CCAA
tasa_empleo_ccaa$CCAA <- str_replace_all(tasa_empleo_ccaa$CCAA, "[0-9]+ ", "")

#Eliminamos el sobrante del nombre
tasa_empleo_ccaa$CCAA <- str_replace_all(tasa_empleo_ccaa$CCAA, ",.*", "")

#Unimos las tablas
tasa_empleo_conjunta <- rbind(tasa_empleo_ccaa, tasa_empleo_ue)

tasa_empleo_conjunta

tasa_empleo_conjunta <- tasa_empleo_conjunta[order(tasa_empleo_conjunta$Total,decreasing = TRUE), ]

#Añadimos una columna con el formato CCAA(Total) para una mejor visualización
tasa_empleo_conjunta <- mutate(tasa_empleo_conjunta,
                               titulo_grafica = paste0(CCAA, " (", Total, ")"))

tasa_empleo_conjunta

colores <- c("#AA3225","#AE3922","#B24120","#B7491E","#BB501C","#004494","#C0581A","#C46018","#C96816" #Color UE
             ,"#CD6F14","#D27712","#D67F10","#DA860E","#DF8E0C",
             "#E3960A","#E89E08","#ECA506","#F1AD04","#F5B502","#FABD00") #Rojo y Gualda


ggplot(tasa_empleo_conjunta,
       #Ordenamos por el total de manera Creciente
       aes(y = reorder(titulo_grafica, Total, decreasing = FALSE), x = Total,fill=reorder(titulo_grafica, Total, decreasing = TRUE))) +
  geom_bar(stat = "identity") +
  labs(title = "Tasa de empleo por comunidad autónoma 2019",
       caption ="Alejandro García Gallego\nFuente: INE",y = "", x="Tasa de empleo %")+
  scale_fill_manual(values = colores)+
  tema_1()



################ GRÁFICA 2 TASA DE DELINCUENCIA POR COMUNIDAD AUTÓNOMA


delicuencia_ccaa <- read.csv2("Tasa de homicidios y criminalidad por CCAA, tipo de tasa y periodo.csv")


#Nos quedamos con el año 2019 y la tasa de criminalidad
delicuencia_ccaa <- filter(delicuencia_ccaa, periodo == var_periodo, Tipo.de.tasa == "Tasa de criminalidad")


#Eliminamos las filas nulas
delicuencia_ccaa <- na.omit(delicuencia_ccaa)

#Eliminamos la columna innecesaria
delicuencia_ccaa <- select(delicuencia_ccaa, -"Total.Nacional")

#Cambiamos el nombre de la columna para su mejor interpretación
colnames(delicuencia_ccaa)[1] <- "CCAA"

#Eliminamos los que no tenga CCAA (Nivel nacional)
delicuencia_ccaa <- subset(delicuencia_ccaa, CCAA != "")

#Eliminamos los números de las CCAA
delicuencia_ccaa$CCAA <- str_replace_all(delicuencia_ccaa$CCAA, "[0-9]+ ", "")

head(delicuencia_ccaa)

#Cargamos el mapa de españa por CCAA
mapa_ccaa <- esp_get_ccaa()

#Cambiamos el nombre de la columna para hacer la unión
mapa_ccaa <- rename(mapa_ccaa, CCAA = ine.ccaa.name)

#Unimos las tablas para visualizar el gráfico
df_mapa <- inner_join(delicuencia_ccaa, mapa_ccaa, by ="CCAA")

head(df_mapa)

ggplot(data = df_mapa) +
  geom_sf(aes(fill = Total,geometry = geometry)) +
  labs(title = "Tasa de criminalidad por comunidad autónoma 2019",
       caption ="Alejandro García Gallego\nFuente: INE",
       fill = "%")+
  scale_fill_continuous(low = "#FABD00", high = "#AA3225")+
  tema_2()


################ GRÁFICA 3 RENTA MEDIANA ENTRE CCAA Y UE

#Obtenemos los datos de Renta media y mediana de eurostat
dataset_ue <- get_eurostat("ilc_di03")

#Cargamos las rentas de las CCAA
renta_mediana_ccaa <- read.csv2("Renta media y mediana. Serie 2008-2022 por renta, CCAA y periodo.csv")

#Creamos un diccionario para relacionarlos con sus siglas
diccionario_paises<- c("AT" = "Austria","BE" = "Bélgica","BG" = "Bulgaria","CY" = "Chipre","CZ" = "República Checa",
                  "DE" = "Alemania","DK" = "Dinamarca","EE" = "Estonia","EL" = "Grecia","ES" = "España",
                  "FI" = "Finlandia","FR" = "Francia","HR" = "Croacia","HU" = "Hungría","IE" = "Irlanda",
                  "IT" = "Italia","LV" = "Letonia","LT" = "Lituania","LU" = "Luxemburgo","MT" = "Malta",
                  "NL" = "Países Bajos","PL" = "Polonia","PT" = "Portugal","RO" = "Rumanía","SE" = "Suecia",
                  "SI" = "Eslovenia","SK" = "Eslovaquia")

#Nos quedamos con la renta mediana de las UE del 2019 en euros
renta_mediana_ue <- subset(dataset_ue, geo %in% names(diccionario_paises) & TIME_PERIOD == "2019-01-01" & sex == "T" & indic_il == "MED_E" & unit == "EUR" & age == "TOTAL")

#Cambiamos sus siglas por el nombre en Español de los países 
renta_mediana_ue$geo <- sapply(renta_mediana_ue$geo, function(x) diccionario_paises[x])

#Nos quedamos con la renta mediana de las comunidades en el 2019
renta_mediana_ccaa <- subset(renta_mediana_ccaa, periodo == "2019" & Renta == "Mediana")

#Cambiamos el nombre de la columna para su mejor interpretación
renta_mediana_ccaa <- rename(renta_mediana_ccaa, CCAA = Comunidades.y.Ciudades.Autónomas)

#Cambiamos el nombre de la columna para su mejor interpretación
renta_mediana_ue <- rename(renta_mediana_ue, CCAA = geo)
renta_mediana_ue <- rename(renta_mediana_ue, Total = values)

#Eliminamos las columnas innecesarias
renta_mediana_ccaa <- select(renta_mediana_ccaa, c(CCAA,Total))

#Eliminamos las columnas innecesarias
renta_mediana_ue <- select(renta_mediana_ue, c(CCAA,Total))

#Eliminamos los que no tenga CCAA (Nivel nacional)
renta_mediana_ccaa <- subset(renta_mediana_ccaa, CCAA != "")

#Quitamos el . del Total
renta_mediana_ccaa$Total <- gsub("\\.", "", renta_mediana_ccaa$Total)

#Eliminamos los números de las CCAA
renta_mediana_ccaa$CCAA <- str_replace_all(renta_mediana_ccaa$CCAA, "[0-9]+ ", "")

#Eliminamos el sobrante del nombre
renta_mediana_ccaa$CCAA <- str_replace_all(renta_mediana_ccaa$CCAA, ",.*", "")

renta_mediana_ccaa

renta_mediana_ue

#Unimos las tablas
renta_mediana_conjunta <- rbind(renta_mediana_ccaa, renta_mediana_ue)

#Añadimos una columna con el formato CCAA/País(Total) para una mejor visualización
renta_mediana_conjunta <- mutate(renta_mediana_conjunta,
                               titulo_grafica = paste0(CCAA, " (", Total, ")"))

#Transformamos el Total a entero para su correcta interpretación gráfica
renta_mediana_conjunta$Total <- as.integer(renta_mediana_conjunta$Total)

renta_mediana_conjunta

ggplot(renta_mediana_conjunta,
       #Ordenamos por el total de manera Creciente
       aes(y = reorder(titulo_grafica, Total, decreasing = FALSE), x = Total, fill = as.integer(reorder(titulo_grafica, Total, decreasing = TRUE)))) +
  geom_bar(stat = "identity",width = 0.6) +
  labs(title = "Renta mediana por comunidad autónoma y paises de la UE 2019",
       caption ="Alejandro García Gallego\nFuente: INE",y = "", x="Renta anual €")+
  scale_fill_gradient(low ="#AA3225",high = "#FABD00")+
  tema_3()


