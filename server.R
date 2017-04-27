#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library (leaflet)
library(maps)
library(readr)
library(dplyr)



#points_data <- map_debuts[order(map_debuts$location),]

# Define server logic required to draw a map
server <- function(input, output, session) {
    phanalytix_map <- read_csv('phanalytix.csv')
    
    
    test <- phanalytix_map %>% group_by(venue_name, latitude, longitude) %>% summarize(num_perform = n()) 
    
    #test2 <- right_join(test, phanalytix_map, by="venue_name") %>% select(venue_name, num_perform, latitude, longitude, song)
    
#    test3 <- left_join(test, phanalytix_map, by = "venue_name") %>% select(venue_name, num_perform, latitude, longitude)
   
    output$map <- renderLeaflet({
        
       # mapStates = map("state", fill = TRUE, plot = FALSE)
        leaflet(test) %>% addTiles() %>%
            addMarkers( ~longitude, ~latitude, popup = paste("Number of performances: ", as.character(test$num_perform), 
                                                              as.character(test$venue_name)) )
           # addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
        
    })
    
    # A reactive expression that returns the set of zips that are
    # in bounds right now
    points_in_bounds <- reactive({
        if (is.null(input$map_bounds))
            return(points_data[FALSE,])
        bounds <- input$map_bounds
        latRng <- range(bounds$north, bounds$south)
        lngRng <- range(bounds$east, bounds$west)
        
        subset(points_data,
               latitude >= latRng[1] & latitude <= latRng[2] &
                   longitude >= lngRng[1] & longitude <= lngRng[2])
        
    })
}
