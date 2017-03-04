library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)

# Sourcing the file with the keys in it. Access key is 'access.token'
source("keys.R")

base.url <- "https://api.instagram.com/v1/"

# example url is https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
# Format is base url / request / access key
# In case : 6ff7a923483441ea8b19c9ecd8b23d5a

# Get user info
response <- GET(paste0(base.url, "users/self/?", access.token))
body <- fromJSON(content(response, "text"))

body$data

response <- GET(paste0(base.url, "locations/search?lat=48.858844&lng=2.294351&", access.token))
body <- fromJSON(content(response, "text"))

body$meta

server <- function(input, output) {

}
  
shinyServer(server)
