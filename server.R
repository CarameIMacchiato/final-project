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
filter.bar <- ggplot(data = body$data) +
  geom_bar(mapping = aes(x = body$data$filter)) +
  ggtitle("Filter Statistics") +
  labs(x="Filter Name", y="# of Times Filter is Used")


server <- function(input, output) {
  
  # for searching users
  filtered <- reactive({
    search.response <- GET(paste0("https://api.instagram.com/v1/users/search?q=", input$chosen.search, "&", access.token))
    search.body <- fromJSON(content(search.response, "text"))
    # gets data of searched user
    data <- search.body$data
    return(data)
  })
  
  # check for correct response
  output$search.output <- renderText({
    user.data <- filtered()
    paste0("User Input: ", input$chosen.search)
    
  })
  
  # check for correct response
  output$search.selected.user <- renderText({
    user.data <- filtered()
    paste0("Selected User: ", user.data$username)
    
  })
  
  # check for correct response
  output$search.fullname <- renderText({
    user.data <- filtered()
    paste0("Full name : ", user.data$full_name)
  })
  
  # check for correct response
  output$search.userid <- renderText({
    user.data <- filtered()
    paste0("User Id: ", user.data$id)
    
  })
  
  # check for correct response
  output$search.user.bio <- renderText({
    user.data <- filtered()
    paste0("Bio: ", user.data$bio)
    
  })

  output$plot <- renderPlot({
    
    ggplot(data = body$data) +
      geom_bar(mapping = aes(x = body$data$filter)) +
      ggtitle("Filter Statistics") +
      labs(x="Filter Name", y="# of Times Filter is Used") 
    
  })
  
}
  
shinyServer(server)
