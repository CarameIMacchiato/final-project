### in app.R ###
# load the UI and Server 
source('ui.R') 
source('server.R')
shinyApp(ui = ui, server = server)
