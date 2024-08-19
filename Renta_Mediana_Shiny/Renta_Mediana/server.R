library(tidyverse)
library(eurostat)
library(rvest)
library(knitr)
library(data.table)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  setwd("D:/R/Practica")
  
  tema_3 <- function(base_size = 13,
                     base_family = "sans",
                     plot_width = 12
  )
  {
    
    tema <-
      theme_bw(base_size=base_size) +
      
      theme(legend.position="none") +
      theme(plot.title=element_blank()) +
      
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
            panel.grid.minor = element_blank(),
      )
    
    return (tema)
  }
  
  dataset_ue <- get_eurostat("ilc_di03")
  renta_mediana_ccaa <- read.csv2("Renta media y mediana. Serie 2008-2022 por renta, CCAA y periodo.csv")
  
  diccionario_paises<- c("AT" = "Austria","BE" = "Bélgica","BG" = "Bulgaria","CY" = "Chipre","CZ" = "República Checa",
                         "DE" = "Alemania","DK" = "Dinamarca","EE" = "Estonia","EL" = "Grecia","ES" = "España",
                         "FI" = "Finlandia","FR" = "Francia","HR" = "Croacia","HU" = "Hungría","IE" = "Irlanda",
                         "IT" = "Italia","LV" = "Letonia","LT" = "Lituania","LU" = "Luxemburgo","MT" = "Malta",
                         "NL" = "Países Bajos","PL" = "Polonia","PT" = "Portugal","RO" = "Rumanía","SE" = "Suecia",
                         "SI" = "Eslovenia","SK" = "Eslovaquia")
  
  
  renta_mediana_ue <- subset(dataset_ue, geo %in% names(diccionario_paises) & TIME_PERIOD == "2019-01-01" & sex == "T" & indic_il == "MED_E" & unit == "EUR" & age == "TOTAL")
  
  renta_mediana_ue$geo <- sapply(renta_mediana_ue$geo, function(x) diccionario_paises[x])
  
  
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
  
  #Unimos las tablas
  renta_mediana_conjunta <- rbind(renta_mediana_ccaa, renta_mediana_ue)
  
  
  renta_mediana_conjunta <- mutate(renta_mediana_conjunta,
                                   titulo_grafica = paste0(CCAA, " (", Total, ")"))
  
  #Transformamos el Total a entero para su correcta interpretación gráfica
  renta_mediana_conjunta$Total <- as.integer(renta_mediana_conjunta$Total)
  
  array_UE <- reactive({
    input$inputUE
  })
  
  array_CCAA <- reactive({
    input$inputCCAA
  })
  
  output$graficaRenta <- renderPlot({
    dataset_final <- subset(renta_mediana_conjunta, CCAA %in% array_UE() | CCAA %in% array_CCAA() )
    ggplot(dataset_final,
           #Ordenamos por el total de manera Creciente
           aes(y = reorder(titulo_grafica, Total, decreasing = FALSE), x = Total, fill = as.integer(reorder(titulo_grafica, Total, decreasing = TRUE)))) +
      geom_bar(stat = "identity") +
      labs(title = "Renta mediana por comunidad autónoma y paises de la UE 2019",
           caption ="Alejandro García Gallego\nFuente: INE",y = "", x="Renta anual €")+
      scale_fill_gradient(low ="#AA3225",high = "#FABD00")+
      tema_3()  
    
  })
})
