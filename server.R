library(shiny)
library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)
library(anytime)


# Sourcing the file with the keys in it. Access key is 'access.token'
source("keys.R")

base.url <- "https://api.instagram.com/v1/"

# example url is https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN

access.token <- "1942144530.52a837c.52b8ff2e81a5417688ef1fd8c1c5d339"
# Get recent media from user
insta.response <- GET(paste0(base.url, "users/self/media/recent/"), query = list("access_token" = access.token))
insta.body <- fromJSON(content(response, "text"))
insta.result <- flatten(insta.body$data)


# Get the filters used in the most recent media

# Bar graph for the filters from the recent media pulled
ggplot(data = body$data) +
  geom_bar(mapping = aes(x = body$data$filter))


server <- function(input, output) {
  output$bar_chart <- renderPlot({
    insta.result$created_time <- as.POSIXct(as.numeric(insta.result$created_time),origin="1970-01-01",tz=Sys.timezone())
    insta.result$number <- nrow(insta.result):1
    g <- ggplot(data = insta.result, aes(x = number, y = likes.count, fill = comments.count)) +
      geom_bar(stat = "identity") + labs(x = "Numbers of Pictures", y = ("LIKES counts"), fill = "Comments counts")
    return(g)
  })

}
  
shinyServer(server)
