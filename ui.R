# Load needed libraries
library("shiny")
library("plotly")

# Construct shiny UI page
shinyUI(navbarPage('UFO Analysis',
                   
                   # Create a tab panel for the about page
                   tabPanel('About',
                            
                            # About page title
                            titlePanel('About Page Title')
                            
                            # About page information goes here 
                   ), 
                   
                   # Create a tab panel for the map page
                  
                   
                   tabPanel('Map',
                            
                            # Map page title
                            titlePanel('Map Page Title'),
                            # Map page information goes here
                            sidebarLayout(
                                sidebarPanel(
                                    sliderInput("years", "Year:", min = 1998, max = 2014, value = 2000),
                                    checkboxInput("select","Show all shapes UFO?",value = TRUE),
                                    selectInput('shape', 'Shape', choices =ufo.data$Shape, selected = "All")
                                ),
                                
                                mainPanel(
                                  plotlyOutput("map")
                                )
                              )
                    ),
                            
              
                   # Create a tab panel for the plot page
                   tabPanel('Plot',
                            
                            # Map page title
                            titlePanel('Plot Page Title')
                            
                            # Plot page information goes here
                   ),
                   
                   # Create a tab panel for the conclusion page
                   tabPanel('Conclusion',
                            
                            # Map page title
                            titlePanel('Conclusion Page Title')
                            
                            # Conclusion page information goes here
                   )
))