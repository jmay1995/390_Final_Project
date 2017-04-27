#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(leaflet)

ui <- fluidPage(
    leafletOutput("map"),
    p ()
    
)




# Choices for drop-downs
# vars <- c(
#     "Is Debut?" = "debut_dummy",
#     "Date" = "date",
#     "Song" = "song",
#     "Location" = "location"
# )



