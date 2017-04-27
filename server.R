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




# Define server logic required to draw a map
server <- function(input, output, session) {
    # map_world = map("world", fill = TRUE, plot = FALSE)
    # map_world <- as.data.frame(map_world)
    # map_world
    
    phanalytix_map <- read_csv('phanalytix.csv')
    
    
    test <- phanalytix_map %>% group_by(venue_name, latitude, longitude, city, state, country) %>% summarize(num_perform = n()) 
    
    #test2 <- right_join(test, phanalytix_map, by="venue_name") %>% select(venue_name, num_perform, latitude, longitude, song)
    
#    test3 <- left_join(test, phanalytix_map, by = "venue_name") %>% select(venue_name, num_perform, latitude, longitude)
   
    output$map <- renderLeaflet({
        
        leaflet(test) %>% addTiles() %>%
            addMarkers( ~longitude, ~latitude, popup = paste("Number of songs performed at: ", 
                                                             as.character(test$venue_name), 
                                                             "=",  
                                                             as.character(test$num_perform)) )
           # addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
        
    })
    
    # 
    # points_in_bounds <- reactive({
    #     if (is.null(input$map_bounds))
    #         return(points_data[FALSE,])
    #     bounds <- input$map_bounds
    #     latRng <- range(bounds$north, bounds$south)
    #     lngRng <- range(bounds$east, bounds$west)
    #     
    #     subset(points_data,
    #            latitude >= latRng[1] & latitude <= latRng[2] &
    #                longitude >= lngRng[1] & longitude <= lngRng[2])
    #     
    #})
}
