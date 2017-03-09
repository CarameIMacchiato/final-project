library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)
library(plotly)
library(leaflet)
library(shinydashboard)

### in app.R ###
# load the UI and Server 
source('ui.R') 
source('server.R')
shinyApp(ui = ui, server = server)
