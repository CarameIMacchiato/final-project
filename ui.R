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
               tabPanel("Map"),
               tabPanel("Search"),
               tabPanel("Heat Map"),
               tabPanel("Statistics"),
               tabPanel("Mini Profile Page")
               
    )
  )
)
  