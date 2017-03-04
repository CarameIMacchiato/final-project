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

# Get recent media from user
response <- GET(paste0(base.url, "users/self/media/recent/?", access.token))
body <- fromJSON(content(response, "text"))


# Get the filters used in the most recent media
body$data$filter

# Bar graph for the filters from the recent media pulled
ggplot(data = body$data) +
  geom_bar(mapping = aes(x = body$data$filter))



server <- function(input, output) {

}
  
shinyServer(server)
