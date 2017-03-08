library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)

# Defining the UI
ui <- fluidPage(theme = "bootstrap.css",
 
  tags$div(h1("Self Worth Evaluator" ), class = "jumbotron", style = "background-image: url(http://static.tumblr.com/f13b0a6a22dd72346d930867ce349dff/zatppvx/DVQmt82k8/tumblr_static_colour-big.gif); background-size: cover"),
  
  h2("What is It?"),
  p("The Self-Worth Evaluator is an application that uses the instagram API to gather information and statistics on individual instagram users. It has many different features that tells a lot about a user, how they use instagram, and much more"),
  
  p(em("Note: only works for our sandbox users", class = "text-info", class = "small")),
  
  dashboardBody(  
    fluidRow(
        tabBox(
          title = icon("gear"), "Feature Info",
          tabPanel("Map",
                   "Infoinfoinfoinfo"
                   )
        )
      )
  ),
  
  br(),
  
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
      
      column(3,
             tags$div(tabsetPanel(type = "tabs",
                tabPanel("Map", leafletOutput('maps')),
                tabPanel("Image Data", plotlyOutput("bar_chart"), hr(), 
                         uiOutput("click")),
                tabPanel("Statistics",
                         h2("Statistics"),
                         p("Filters are a big part of Instagram."),
                         plotOutput("plot"))
         ), class = "well")
      ),
        
      column(3,
             tags$div(tabsetPanel(type = "tabs",
                tabPanel("Map", leafletOutput('maps.2')),
                tabPanel("Image Data", plotlyOutput("bar_chart.2"), hr(), uiOutput("click.2")),
                tabPanel("Statistics",
                         h2("Statistics"),
                         p("Filters are a big part of Instagram."),
                        plotOutput("plot.2"))
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

