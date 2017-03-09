library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)
#install.packages("shinydashboard")

# Defining the UI
ui <- fluidPage(theme = "bootstrap.css",
 
  
  tags$div(h1("Statistigram" ), class = "jumbotron", style = "background-image: url(http://static.tumblr.com/f13b0a6a22dd72346d930867ce349dff/zatppvx/DVQmt82k8/tumblr_static_colour-big.gif); background-size: cover"),

  tags$div(
    h3("What is It?"),
    p("This is an application that uses the instagram API to gather information and statistics on individual instagram users. It has many different features that tells a lot about a user, how they use instagram, and much more"),
    
    p(em("Note: only works for our sandbox users due to API restrictions", class = "text-info", class = "small")),
    
    h5("Search Bars"),
    p("The search bar can be used to look up different Instagram users, but is limited to only a few due to instagram's API restrictions on public content. Look up a username and the app finds out all their information."),
    
    h5("The Profile Info"),
    p("Under the search bar, you can see a users miniature profile page, which includes their profile picture, follower information, and post information"),
  align = "center"),
  
  hr(),
  
  dashboardBody(  
    fluidRow(
      column(12, align = "center", offset = 3,
          tabBox(
            tabPanel("Map Info",
                     h5("Mapped Location Tags"),
                     p("Here you can see on a map where exactly your posts are, this can be a great way to see trips from a vacation or where specifically you post the most."),
                     p("This map can show if a person stays in the same area often, or if they have a tendency to travel. It also shows if they even put location tags on their photos or if they post untagged images.")
            ),
            tabPanel("Image Data", 
                     h5("Graphed Image Data"),
                     p("This graph shows the amount of comments and likes that a user has gotten on their 20 most recent media. The y-axis is based on the amount of likes and the x-axis is the chronological order of the photos, with the most recent photo on the left."),
                     p("The colors of each bar corresponds with the amount of comments each photo has gotten."),
                     p("Each bar can be clicked to see the corresponding photo as well, and it will appear below the graph. Hovering over each bar also reveals extra information.")
            ),
            tabPanel("Filter Data",
                     h5("Filter Usage"),
                     p("Filters are a big part of what differentiates instagram from other social networks. Here is a graph of the user's filters, and how often they use each of them, if at all.
                       You can use this data to see which filters are more popular to use than others, and compare your filter use to other people!")
            ),
            tabPanel("Why Use the App?",
                     h5("Why Use the App?"),
                     p("You may be asking, why use this app instead of the instagram app itself? This app's main usage is to help users find out more information about how they and others use Instagram. It conveys information from instagram on a much larger scale than using the app itself."),
                     h6("For Personal Use"),
                     p("Our app could be used by many people to show them how they and others use instagram. The main reason people use instagram is to show what they are doing to their friends and family, and our app can make seeing that information clearer. Through the map, users can see where they have been posting from and where others have been posting. This can be a great way to see where a user posts the most and where they have posted vacation photos. The filter data can be used to see which filters a user likes the most and could be used to maybe try for more variety in filter use. The image data could be used personally to see what photos your friends and family like and comment on the most."),
                     h6("For Business Use"),
                     p("Our app can also be used by businesses and digital marketers to gather more information on how successful their instagram presence is. The image data could be used by companies to track which posts are getting the most attention and which are not, to better help shape their decisions on what to advertise through instagram. Companies can also compare how their posts are doing against competitors so that they can try and gain a competitive edge against them. The map could be used by companies that try to market to specific regions, such as Geico, to make sure that they are reaching their locations of interest."),
                     h6("Conclusion"),
                     p("Our app is meant to be a supplement for the instagram app. It allows anyone to gather a ton of data from the instagram api in a efficient, easy, and interactive way. It would make the job of companies that depend advertising through media presence have a much easier time getting valuable data. Though our app is limited in scope due to api restrictions, it shows that it has tons of potential to be useful for both personal and business use.")
            ),
          selected = "Map Info")
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
        
        tags$table(
        p(strong("List of valid usernames to search:")),
        p("accelgor"),
        p("squiwardtennisballs324"),
        p("monmon_hi"),
        p("onaregul_r"),
        p("trickynicky71"),
        p("nikicruzz"),
        class = "table table-hover")
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

