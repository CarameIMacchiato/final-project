library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)

access.token <- "access_token=1942144530.52a837c.52b8ff2e81a5417688ef1fd8c1c5d339"

base.url <- "https://api.instagram.com/v1/"

# example url is https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
# Format is base url / request / access key

# Get user info
response <- GET(paste0(base.url, "users/self/", access.token))
body <- fromJSON(content(response, "text"))

# User search 
response <- GET(paste0(base.url, "users/search?q=portugaltheman&", access.token))
body <- fromJSON(content(response, "text"))

body$meta
server <- function(input, output) {
  

  
}
  