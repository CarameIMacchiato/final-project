library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)

access.token <- "access_token=1942144530.52a837c.52b8ff2e81a5417688ef1fd8c1c5d339"

base.url <- "https://api.instagram.com/v1/"

# example url is https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
# Format is base url / request / access key


response <- GET("https://api.instagram.com/v1/users/self/?access_token=52a837c5cf9b4a2d996a0a7468c7a221")
body <- fromJSON(content(response, "text"))

body$meta

server <- function(input, output) {
  

  
}
  