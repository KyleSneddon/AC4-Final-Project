
# Load needed libraries
library('shiny')
library('dplyr')
library("lubridate")
library("stringr")
library("leaflet")


# Read in data and convert to data frame, formatting data.
ufo.data <- read.csv(file="data/ufo.csv", header= TRUE, stringsAsFactors = FALSE) %>% mutate(Date = mdy(Date)) %>% mutate(Years = year(Date)) %>% select(City,State,Date,Shape,Longitude,Latitute,Duration,Years)
BlankShape <- function(shape.take){
  if(shape.take == ""){
    return("Unknown")
  }
    return(shape.take)
}
ufo.data$Shape<- lapply(ufo.data$Shape, BlankShape)
ufo.data$Shape <- as.character(ufo.data$Shape)


ufo.data$Duration <- as.numeric(ufo.data$Duration)
DurationClean <- function(duration){
  if(is.na(duration)){
    return(0.01)
  }
  return(duration)
}
ufo.data$Duration <- lapply(ufo.data$Duration, DurationClean)
ufo.data$Duration <- as.numeric(ufo.data$Duration)


GetSize <- function(due.time){
  if(due.time <= 60){
    return(5)
  }else if(due.time >60 && due.time <= 1800){ #0.5 hour
    return(8)
  }else if(due.time >1800 && due.time <= 3600){ #1 hour
    return(15)
  }else if(due.time >3600 && due.time <= 21600){ # 6 hour
    return(25)
  }else if(due.time >21600 && due.time <= 86400){ # 24 hour
    return(35)
  }else{
    return(45)
  }
}
ufo.data$size <- lapply(ufo.data$Duration, GetSize)
ufo.data$size <- as.numeric(ufo.data$size)


# Construct shiny server
shinyServer(function(input, output) {
  output$myList <- renderUI({
    shape.df <- ufo.data %>% filter(Years == input$years)%>% filter(State == input$state)
    selectInput('shape', 'Shape', choices = c("All"="all",shape.df$Shape), selected = "All")
  })
  
  
  ufo.dataset <- reactive({
    if(input$shape == "all"){
    selected.df <- ufo.data %>% filter(Years == input$years) %>% filter(State == input$state)
    }else{
    selected.df <- ufo.data %>% filter(Years == input$years) %>% filter(Shape == input$shape) %>% filter(State == input$state) 
    }
    return(selected.df)
  })
  
  

  output$map <- renderLeaflet({
    map.df <- ufo.dataset()
    factpal <- colorFactor(topo.colors(nrow(ufo.data)), ufo.data$Shape)
    m <- leaflet(map.df) %>%
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addCircleMarkers(~Latitute, ~Longitude, label = ~City, 
                        popup = ~paste( "City: ",City,"<br/>","Shape: ",Shape,"<br/>","Date: ",Date,"<br/>","Duration: ",Duration,"s"),
                       radius = ~size,
                       color = ~factpal(Shape),
                       stroke = FALSE, 
                       fillOpacity = 0.45
                       )

  })
  
  output$title <- renderText(paste("Year",input$years,state.name[grep(input$state, state.abb)],"UFO MAP"))

  output$pie <- renderPlotly({
    
    # Get desired filters through widget inputs
    if(input$options == "Duration") {
      pie.df <- mutate(ufo.data, option = State)
    } else if (input$options == "Shape") {
      pie.df <- mutate(ufo.data, option = Shape)
    } else if (input$options == "Year") {
      pie.df <- mutate(ufo.data, option = year(Date))
    } else {
      pie.df <- mutate(ufo.data, option = State)
    }
    
    # Build the chart with input filters
    p <- group_by(pie.df, option) %>%
      summarize(count = n()) %>%
      plot_ly(labels = ~option,
              values = ~count, 
              textinfo = 'label+percent',
              textposition = "inside") %>%
      add_pie(hole = 0.5) %>%
      layout(title = "",  
             showlegend = F, 
             width=800,
             height=800,
             plot_bgcolor='rgb(40, 43, 48)',
             paper_bgcolor='rgb(40, 43, 48)',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
  
})
  
  
  

