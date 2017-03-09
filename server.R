library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)
library(plotly)
library(leaflet)
# install.packages("leaflet")
# install.packages("plotly")

# Sourcing the file with the keys in it. Access key is 'access.token'
source("keys.R")

base.url <- "https://api.instagram.com/v1/"

# Format is base url / request / access key
# In case : 6ff7a923483441ea8b19c9ecd8b23d5a

# Get user info
response <- GET(paste0(base.url, "users/self/?", access.token))
body <- fromJSON(content(response, "text"))

search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=abigail_oceanna", "&", access.token))
search.body <- fromJSON(content(search.response, "text"))


server <- function(input, output) {
  
  ## General data for first user
  
  # for general data on user (i.e. username, full name, user id, bio, etc.)
  general.data <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    
    if(length(search.body$data) == 0){
      search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=acccelgor", "&", access.token))
      search.body <- fromJSON(content(search.response, "text"))
    }
    
    # gets data of searched user
    data <- search.body$data
    return(data)
  })
  
  ## General data for second user
  
  # for general data on user (i.e. username, full name, user id, bio, etc.)
  general.data.2 <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search.2, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    
    if(length(search.body$data) == 0){
      search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=onaregul", "&", access.token))
      search.body <- fromJSON(content(search.response, "text"))
    }
    
    # gets data of searched user
    data <- search.body$data
    return(data)
  })
  
  ## Recent media for first user
  
  # for user's recent media
  recent.media <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    
    if(length(search.body$data) == 0){
      search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=acccelgor", "&", access.token))
      search.body <- fromJSON(content(search.response, "text"))
    }
    
    # gets data of searched user
    data <- search.body$data
    user.id <- data$id
    media.response <- GET(paste0("https://api.instagram.com/v1/users/", user.id, "/media/recent/?", access.token))
    media.body <- fromJSON(content(media.response, "text"))
    media.data <- media.body$data
    return(media.data)
  })
  
  
  ## Recent media for second user
  
  recent.media.2 <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search.2, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    
    if(length(search.body$data) == 0){
      search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=onaregul", "&", access.token))
      search.body <- fromJSON(content(search.response, "text"))
    }
    
    # gets data of searched user
    data <- search.body$data
    user.id <- data$id
    media.response <- GET(paste0("https://api.instagram.com/v1/users/", user.id, "/media/recent/?", access.token))
    media.body <- fromJSON(content(media.response, "text"))
    media.data <- media.body$data
    return(media.data)
  })
  
  
  ## Specific counts for first user
  
  # for more specific user data (followers, following, etc.)
  specific.counts <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    
    if(length(search.body$data) == 0){
      search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=acccelgor", "&", access.token))
      search.body <- fromJSON(content(search.response, "text"))
    }
    
    # gets data of searched user
    data <- search.body$data
    user.id <- data$id
    specific.response <- GET(paste0("https://api.instagram.com/v1/users/", user.id, "/?", access.token))
    specific.body <- fromJSON(content(specific.response, "text"))
    specific.data <- specific.body$data
    specific.counts <- specific.data$counts
    return(specific.counts)
  })
  
  
  ## Specific counts for second user
  
  specific.counts.2 <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search.2, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    
    if(length(search.body$data) == 0){
      search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=onaregul", "&", access.token))
      search.body <- fromJSON(content(search.response, "text"))
    }
    
    # gets data of searched user
    data <- search.body$data
    user.id <- data$id
    specific.response <- GET(paste0("https://api.instagram.com/v1/users/", user.id, "/?", access.token))
    specific.body <- fromJSON(content(specific.response, "text"))
    specific.data <- specific.body$data
    specific.counts <- specific.data$counts
    return(specific.counts)
  })
  
  
  ## Map for the first user
  
  # Creation of data for leaflet map for the searched user
  map.stuff <- reactive({
    media.frame <- data.frame(recent.media())
    long <- if(!exists("long")) long <- media.frame$location$longitude else append( long, body.pics$data$location$longitude)
    lat <- if(!exists("lat")) lat <- media.frame$location$latitude else append( lat, body.pics$data$location$latitude)
    links <- if(!exists("links")) links <- (paste0("<img src=\"", media.frame$images$thumbnail$url, "\">")) else append( links, (paste0("<img src=\"", body.pics$data$images$thumbnail$url, "\">")))
    captions <- if(!exists("captions")) captions <- media.frame$caption$text else append(captions, body.pics$data$caption$text)
    usernames <- if(!exists("usernames")) usernames <- media.frame$user$username else append(usernames, body.pics$data$user$username)
    map.info <- data.frame(long, lat, links, captions, usernames)
    return(map.info)
  })
  
  ## Map data for the second user
  
  map.stuff.2 <- reactive({
    media.frame <- data.frame(recent.media.2())
    long <- if(!exists("long")) long <- media.frame$location$longitude else append( long, body.pics$data$location$longitude)
    lat <- if(!exists("lat")) lat <- media.frame$location$latitude else append( lat, body.pics$data$location$latitude)
    links <- if(!exists("links")) links <- (paste0("<img src=\"", media.frame$images$thumbnail$url, "\">")) else append( links, (paste0("<img src=\"", body.pics$data$images$thumbnail$url, "\">")))
    captions <- if(!exists("captions")) captions <- media.frame$caption$text else append(captions, body.pics$data$caption$text)
    usernames <- if(!exists("usernames")) usernames <- media.frame$user$username else append(usernames, body.pics$data$user$username)
    map.info <- data.frame(long, lat, links, captions, usernames)
    return(map.info)
  })
  
  
  # Creation of filter plot for the first user. 
  output$plot <- renderPlotly({
    filter.data <- recent.media()
    data.filter <- flatten(filter.data) %>% 
                    select(filter) 
    colnames(data.filter) <- c("Filter")
    filter <- ggplot(data = data.filter) +
      geom_bar(mapping = aes(x = Filter), fill = "#2b8cbe") +
      ggtitle("Filter Statistics") +
      labs(x="Filter Name", y="# of Times Filter is Used") 
    filter.graph <- ggplotly(filter, width = 700, tooltip = c("x", "y"))
  })
  
  
  # Creation of filter plot for the second user. 
  output$plot.2 <- renderPlotly({
    filter.data <- recent.media.2()
    data.filter <- flatten(filter.data) %>% 
      select(filter) 
    colnames(data.filter) <- c("Filter")
    filter <- ggplot(data = data.filter) +
      geom_bar(mapping = aes(x = Filter), fill = "#9ecae1") +
      ggtitle("Filter Statistics") +
      labs(x="Filter Name", y="# of Times Filter is Used") 
    filter.graph <- ggplotly(filter, width = 700, tooltip = c("x", "y"))
    
  })
  
  ## Creation of outputs for first user
  
  # Username for profile page
  output$selected.user <- renderText({
    user.data <- general.data()
    paste(user.data$username)
  })
  
  # Count of followees for profile page
  output$following <- renderText({
    follow.counts <- specific.counts()
    paste(follow.counts$follows)
  })
  
  # Count of followers for profile page
  output$follows <- renderText({
    follow.counts <- specific.counts()
    paste(follow.counts$followed_by)
  })
  
  # Count of media count for profile page
  output$media.count <- renderText({
    follow.counts <- specific.counts()
    paste(follow.counts$media)
  })
  
  # Name for profile page
  output$name <- renderText({
    user.data <- general.data()
    paste(user.data$full_name)
  })
  
  # Count of media count for profile page
  output$bio <- renderText({
    user.data <- general.data()
    paste(user.data$bio)
  })
  
  # Profile pic for profile page 
  output$pic <- renderUI({
    user.data <- general.data()
    src = user.data$profile_pic
    tags$img(src = src)
  })
  
  
  ## Creation of outputs for second user
  
  # Username for profile page
  output$selected.user.2 <- renderText({
    user.data <- general.data.2()
    paste(user.data$username)
  })
  
  # Count of followees for profile page
  output$following.2 <- renderText({
    follow.counts <- specific.counts.2()
    paste(follow.counts$follows)
  })
  
  # Count of followers for profile page
  output$follows.2 <- renderText({
    follow.counts <- specific.counts.2()
    paste(follow.counts$followed_by)
  })
  
  # Count of media count for profile page
  output$media.count.2 <- renderText({
    follow.counts <- specific.counts.2()
    paste(follow.counts$media)
  })
  
  # Name for profile page
  output$name.2 <- renderText({
    user.data <- general.data.2()
    paste(user.data$full_name)
  })
  
  # Count of media count for profile page
  output$bio.2 <- renderText({
    user.data <- general.data.2()
    paste(user.data$bio)
  })
  
  # Profile pic for profile page 
  output$pic.2 <- renderUI({
    user.data <- general.data.2()
    src = user.data$profile_pic
    tags$img(src = src)
  })
  
  
  
  ## Map for first user
  
  # Creation of maps with leaflet
  output$maps <- renderLeaflet({
    map.final <- map.stuff()
    m <- leaflet() %>%
      addTiles() %>%
      addMarkers(lng= map.final$long, lat= map.final$lat, popup= paste(sep = "<br>", map.final$links, paste0("<b><i>", map.final$usernames, "</i></b>"), map.final$captions),
                 clusterOptions = markerClusterOptions())
    
    m  # Print the map
  })
  
  ## Map for second user
  
  # Creation of maps with leaflet for second user
  output$maps.2 <- renderLeaflet({
    map.final <- map.stuff.2()
    m <- leaflet() %>%
      addTiles() %>%
      addMarkers(lng= map.final$long, lat= map.final$lat, popup= paste(sep = "<br>", map.final$links, paste0("<b><i>", map.final$usernames, "</i></b>"), map.final$captions),
                 clusterOptions = markerClusterOptions())
    
    m  # Print the map
  })

  
  
  ## Chart for first user
  
  # For the bar chart about likes in each picture
  output$bar_chart <- renderPlotly({
    media.result <- recent.media()
    media.result <- flatten(media.result)
    media.result <- select(media.result, created_time, likes.count, comments.count, images.low_resolution.url)
    media.result$number <- nrow(media.result):1
    media.result$created_time <- as.POSIXct(as.numeric(media.result$created_time), origin = "1970-01-01")
    colnames(media.result) <- c("Time", "LIKEs", "Comments", "url", "Image")
    g <- ggplot(data = media.result, aes(x = Image, y = LIKEs, fill = factor(Comments), label = Time, label2 = LIKEs, label3 = Comments)) +
      geom_bar(stat = "identity", color = "purple") + 
      labs(x = "Image #", y = ("LIKES"), fill = "Comments") +
      scale_x_discrete(limits = 1:nrow(media.result))
    g <- ggplotly(g, width = 700, tooltip = c("x", "label", "label2", "label3"), source = "user.1") 
  })
  
  # The picture of each instagram photo
  output$click <- renderUI({
    media.result <- recent.media()
    media.result <- flatten(media.result)
    bar <- event_data("plotly_click", source = "user.1")
    link <- media.result[bar$x, "images.low_resolution.url"]

    if (is.null(bar)) {
      tags$strong("Click the bar for the Image!!!")
    } else {
      tags$img(src = link)
    }
  })
  
  
  ## Chart for second user
  
  # For the bar chart about likes in each picture
  output$bar_chart.2 <- renderPlotly({
    media.result <- recent.media.2()
    media.result <- flatten(media.result)
    media.result <- select(media.result, created_time, likes.count, comments.count, images.low_resolution.url)
    media.result$number <- nrow(media.result):1
    media.result$created_time <- as.POSIXct(as.numeric(media.result$created_time), origin = "1970-01-01")
    colnames(media.result) <- c("Time", "LIKEs", "Comments", "url", "Image")
    g <- ggplot(data = media.result, aes(x = Image, y = LIKEs, fill = factor(Comments), label = Time, label2 = LIKEs, label3 = Comments)) +
      geom_bar(stat = "identity", color = "purple") + 
      labs(x = "Image #", y = ("LIKES"), fill = "Comments") +
      scale_x_discrete(limits = 1:nrow(media.result))
    g <- ggplotly(g, width = 700, tooltip = c("x", "label", "label2", "label3"), source = "user.2") 
  })
  
  # The picture of each instagram photo
  output$click.2 <- renderUI({
    media.result <- recent.media.2()
    media.result <- flatten(media.result)
    bar <- event_data("plotly_click", source = "user.2")
    link <- media.result[bar$x, "images.low_resolution.url"]
    
    if (is.null(bar)) {
      tags$strong("Click the bar for the Image!!!")
    } else {
      tags$img(src = link)
    }
  })
  
}

shinyServer(server)