# Load needed libraries
library('shiny')
library('dplyr')
library('plotly')
library('lubridate')

# Read in data and convert to data frame
ufo.data <- read.csv(file="data/cleandata.csv", header= TRUE) %>% 
            mutate(Date = mdy(Date)) %>% 
            mutate(Years = year(Date))

# Construct shiny server
shinyServer(function(input, output) {
    
  # Construct donut chart with desired fields
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
                 xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                 yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
})