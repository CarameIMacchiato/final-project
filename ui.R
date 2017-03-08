library(shiny)
library(ggplot2)
library(dplyr)


# Defining the UI
ui <- fluidPage(theme = "bootstrap.css",
 
  tags$div(h1("Self Worth Evaluator" ), class = "jumbotron", style = "background-image: url(http://static.tumblr.com/f13b0a6a22dd72346d930867ce349dff/zatppvx/DVQmt82k8/tumblr_static_colour-big.gif); background-size: cover"),
  
  p(em("Note: only works for our sandbox users", class = "text-info", class = "small")),
  
  fluidRow(
      column(3,
        
        # Search for first instagram user
        textInput("chosen.search", strong("First User")),
    
        # Display profile for first user
        tags$div(h4(uiOutput('pic', class = "img-thumbnail"), textOutput("selected.user", inline = TRUE)),
        p(strong("Following: "), textOutput("following", inline = TRUE), strong("Followers: "), textOutput("follows", inline = TRUE),
        strong("Media Count: "), textOutput("media.count", inline = TRUE)),
        p(strong("Name: "), textOutput("name", inline = TRUE)),
        p(strong("Bio: "), textOutput("bio", inline = TRUE)), class = "well")
      ),
      
      column(6,
             tags$div(tabsetPanel(type = "tabs",
                                  tabPanel("Explanation",
                                           h2("What is It?"),
                                           p("The Self-Worth Evaluator is an application that uses the instagram API to gather information and statistics on individual instagram users. It has many different features that tells a lot about a user, how they use instagram, and much more"),
                                           h4("Search Bar"),
                                           p("The search bar can be used to look up different Instagram users, but is limited to only a few due to instagram's API restrictions on public content. Look up a username and the app finds out all their information"),
                                           h4("The Profile Info"),
                                           p("Under the search bar, you can see a users miniature profile page, which includes their profile picture, follower information, and post information"),
                                           h4("The Photo Map"),
                                           p("This map displays all the different places pictures were posted, along with the actual pictures and captions"),
                                           h4("The Image Data"),
                                           p("This graph shows the amount of likes each photo has and shows in color how many comments it has, and can be clicked to display the image"),
                                           h4("The Filter Data"),
                                           p("Filters are a big part of Instagram. Here is a graph of the user's filters, and how often they use each of them (if at all).
                                             You can use this data to see which filters are more popular to use than others, and compare your filter use to other people!")
                                  ),
                                  tabPanel("Map", leafletOutput('maps'), leafletOutput('maps.2')),
                                  tabPanel("Image Data", plotlyOutput("bar_chart"), hr(), 
                                           uiOutput("click"), plotlyOutput("bar_chart.2"), hr(), uiOutput("click.2")),
                                  tabPanel("Statistics",
                                           plotlyOutput("plot"), hr(), plotlyOutput("plot.2"))

         ), class = "well")
      ),
        
      column(3,
             
        # Search for second instagram user
        textInput("chosen.search.2", strong("Second User")),
        
        # Display profile for second user
        tags$div(h4(uiOutput('pic.2', class = "img-thumbnail"), textOutput("selected.user.2", inline = TRUE)),
        p(strong("Following: "), textOutput("following.2", inline = TRUE), strong("Followers: "), textOutput("follows.2", inline = TRUE),
        strong("Media Count: "), textOutput("media.count.2", inline = TRUE)),
        p(strong("Name: "), textOutput("name.2", inline = TRUE)),
        p(strong("Bio: "), textOutput("bio.2", inline = TRUE)), class = "well")
    
      )
    )
  )

shinyUI(ui)

