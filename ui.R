library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)

# Defining the UI
ui <- fluidPage(theme = "bootstrap.css",
 
  
  tags$div(h1("InStatistics" ), class = "jumbotron", style = "background-image: url(http://static.tumblr.com/f13b0a6a22dd72346d930867ce349dff/zatppvx/DVQmt82k8/tumblr_static_colour-big.gif); background-size: cover"),

  h3("What is It?"),
  p("This is an application that uses the instagram API to gather information and statistics on individual instagram users. It has many different features that tells a lot about a user, how they use instagram, and much more"),
  
  p(em("Note: only works for our sandbox users", class = "text-info", class = "small")),
  
  h5("Search Bars"),
  p("The search bar can be used to look up different Instagram users, but is limited to only a few due to instagram's API restrictions on public content. Look up a username and the app finds out all their information."),
  
  h5("The Profile Info"),
  p("Under the search bar, you can see a users miniature profile page, which includes their profile picture, follower information, and post information"),
  
  hr(),
  
  dashboardBody(  
    fluidRow(
      column(12, align = "center", offset = 3,
          tabBox(
            tabPanel("Map Info",
                     h4("Map"),
                     p("Here you can see on a map where exactly your posts are, this can be a great way to see trips from a vacation or where specifically you post the most.")
                     ),
            tabPanel("Image Data", 
                     h4("Image Data"),
                     p("Here you can see a graph of how many likes and comments a users photos get")
                    ),
            tabPanel("Filter Use Data",
                     h4("Filter Use Data"),
                     p("Filters are a big part of what differentiates instagram from other social networks. Here is a graph of the user's filters, and how often they use each of them (if at all).
                       You can use this data to see which filters are more popular to use than others, and compare your filter use to other people!")
                    )
          )
      )
    )
  ),
  
  hr(),
  
  fluidRow(
      column(3,
        
        # Search for first instagram user
        textInput("chosen.search", h4("First User"), placeholder = "Type username here"),
    
        # Display profile for first user
        tags$div(h4(uiOutput('pic', class = "img-thumbnail"), textOutput("selected.user", inline = TRUE)),
        p(strong("Following: "), textOutput("following", inline = TRUE), strong("Followers: "), textOutput("follows", inline = TRUE),
        strong("Media Count: "), textOutput("media.count", inline = TRUE)),
        p(strong("Name: "), textOutput("name", inline = TRUE)),
        p(strong("Bio: "), textOutput("bio", inline = TRUE)), class = "well"),
        
        p(strong("List of valid usernames to search:")),
        p("accelgor"),
        p("squiwardtennisballs324"),
        p("monmon_hi"),
        p("onaregul_r"),
        p("trickynicky71")
      ),
      
      column(3,
             tags$div(tabsetPanel(type = "tabs",
                tabPanel("Map", 
                         leafletOutput('maps')),
                tabPanel("Image Data",
                         plotlyOutput("bar_chart"), hr(), uiOutput("click")),
                tabPanel("Filter Use Data",
                         plotlyOutput("plot"))
                ), class = "well")
      ),
        
      column(3,
             tags$div(tabsetPanel(type = "tabs",
                tabPanel("Map", 
                         leafletOutput('maps.2')),
                tabPanel("Image Data", 
                         plotlyOutput("bar_chart.2"), hr(), uiOutput("click.2")),
                tabPanel("Filter Use Data",
                         plotlyOutput("plot.2"))
                ), class = "well")
      ),
      
      column(3,
             
        # Search for second instagram user
        textInput("chosen.search.2", h4("Second User"), placeholder = "Type username here"),
        
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

