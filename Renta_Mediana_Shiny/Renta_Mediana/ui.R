library(shiny)
if (!"shinyWidgets" %in% installed.packages()) {
  install.packages("shinyWidgets", dependencies = TRUE)
}
library("shinyWidgets")

setwd("D:/R/Practica/Renta_Mediana_Shiny/Renta_Mediana")

shinyUI(fluidPage(
  includeCSS("styles.css"),
  # Application title
  titlePanel("Renta mediana por comunidad autónoma y países de la UE 2019"),
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(6,
           wellPanel(
             checkboxGroupButtons(
               inputId = "inputUE",
               label = "Países Unión Europea",
               choices = c("Austria", "Bélgica", "Bulgaria", "Chipre", "República Checa",
                           "Alemania", "Dinamarca", "Estonia", "Grecia", "España",
                           "Finlandia", "Francia", "Croacia", "Hungría", "Irlanda",
                           "Italia", "Letonia", "Lituania", "Luxemburgo", "Malta",
                           "Países Bajos", "Polonia", "Portugal", "Rumanía", "Suecia",
                           "Eslovenia", "Eslovaquia"),
               selected = "España",
               status = "UE-class"
             )
           )
    ),
    column(6,
           wellPanel(
             checkboxGroupButtons(
               inputId = "inputCCAA",
               label = "Comunidades Autónomas",
               choices = c("Andalucía", "Aragón", "Asturias", "Balears",
                           "Canarias", "Cantabria", "Castilla y León", "Castilla - La Mancha",
                           "Cataluña", "Comunitat Valenciana", "Extremadura", "Galicia",
                           "Madrid", "Murcia", "Navarra", "País Vasco",
                           "Rioja", "Ceuta", "Melilla"),
               status = "CCAA-class",
               selected = "Andalucía"
             )
           )
    )
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    column(12,
           plotOutput("graficaRenta")
    )
  )
))

