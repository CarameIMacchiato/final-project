library(shiny)
library(ggplot2)
library(dplyr)


# Defining the UI
ui <- fluidPage(
  
  titlePanel("Instagram Project"),
  
  sidebarPanel(
    
  ),
  
  mainPanel(
    navbarPage(
               tabPanel("Statistics"),
               tabPanel("Not Map", leafletOutput('maps')),
               tabPanel("Mini Profile Page")
               
    )
  )
)
  