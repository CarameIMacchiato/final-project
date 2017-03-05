library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)
library(leaflet)


# Sourcing the file with the keys in it. Access key is 'access.token'
source("keys.R")

base.url <- "https://api.instagram.com/v1/"

# Get recent media from user
response <- GET(paste0(base.url, "users/self/media/recent/?", access.token))
body <- fromJSON(content(response, "text"))


# Get the filters used in the most recent media
body$data$filter

# Bar graph for the filters from the recent media pulled
ggplot(data = body$data) +
  geom_bar(mapping = aes(x = body$data$filter))

# example url is https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
# Format is base url / request / access key

# MAP SECTION

# Search for a user
response.search <- GET(paste0(base.url, "users/search?q=squiwardtennisballs324&", access.token))
body.search <- fromJSON(content(response.search, "text"))

# Get a users picture info, and adds it on to the overall info if doing a second user
response.pics <- GET(paste0(base.url, "users/", body.search$data$id, "/media/recent/?", access.token))
body.pics <- fromJSON(content(response.pics, "text"))
long <- if(!exists("long")) long <- body.pics$data$location$longitude else append( long, body.pics$data$location$longitude)
lat <- if(!exists("lat")) lat <- body.pics$data$location$latitude else append( lat, body.pics$data$location$latitude)
links <- if(!exists("links")) links <- (paste0("<img src=\"", body.pics$data$images$thumbnail$url, "\">")) else append( links, (paste0("<img src=\"", body.pics$data$images$thumbnail$url, "\">")))
captions <- if(!exists("captions")) captions <- body.pics$data$caption$text else append(captions, body.pics$data$caption$text)
usernames <- if(!exists("usernames")) usernames <- body.pics$data$user$username else append(usernames, body.pics$data$user$username)


server <- function(input, output) {
  output$maps <- renderLeaflet({
    m <- leaflet() %>%
      addTiles() %>%
      addMarkers(lng= long, lat= lat, popup= paste(sep = "<br>", links, usernames, captions),
                 clusterOptions = markerClusterOptions())
      
    m  # Print the map
  })
  

}

shinyServer(server)

