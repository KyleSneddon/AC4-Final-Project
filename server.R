
# Load needed libraries
library('shiny')
library('dplyr')
library('plotly')
library("lubridate")
# Read in data and convert to data frame

# Construct shiny server
shinyServer(function(input, output) {
  ufo.data <- read.csv(file="data/ufo.csv", header=TRUE) %>% mutate(Country = "us")
  #ufo.data$Years
  ufo.dataset <- reactive({
    selected.df <- ufo.data %>% filter(Shape == input$shape) #%>% filter(Date == input$years) 
    return(selected.df)
  })
  
  output$map <- renderPlotly({
    df <- ufo.dataset()
    
    p <- plot_geo(df, locationmode = 'USA-states', sizes = c(1, 250)) %>%
      add_markers(
        x = ~Longitude, y = ~Latitute
      )
    
  })
  
  
  
  
  # Stuff goes here
})