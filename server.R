
# Load needed libraries
library('shiny')
library('dplyr')
library('plotly')
library("lubridate")
# Read in data and convert to data frame

# Construct shiny server
shinyServer(function(input, output) {
  
  ufo.data <- read.csv(file="data/ufo.csv", header= TRUE) %>% mutate(Date = mdy(Date)) %>% mutate(Years = year(Date)) #%>% select(City, State,Shape,Duration,Description,Longitude,Latitute,Years)
  
  ufo.dataset <- reactive({
    if(input$select){
    selected.df <- ufo.data %>% filter(Years == input$years) 
    }else{
    selected.df <- ufo.data  %>% filter(Shape == input$shape) %>% filter(Years == input$years) 
    }
    return(selected.df)
  })
  

  output$map <- renderPlotly({
    df <- ufo.dataset()
    
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showland = TRUE,
      landcolor = toRGB("gray85"),
      subunitwidth = 1,
      countrywidth = 1,
      subunitcolor = toRGB("white"),
      countrycolor = toRGB("white")
    )
    p <- plot_geo(df, locationmode = 'USA-states', sizes = c(1, 300), x = ~Latitute, y = ~Longitude) %>%
      add_markers(
        size = ~Duration,
        color = ~Shape,
        text = ~paste(" State: ",State,"<br />","Shape: ",Shape,"<br />","Date: ",Date,"<br />","Duration: ",Duration,"s")
      ) %>%
      layout(title = 'UFO', geo = g)
    
  })
  

})
