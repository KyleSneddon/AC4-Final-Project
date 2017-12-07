# Load needed libraries
library("shiny")
library("plotly")
library("shinythemes")
library("leaflet")

# Construct shiny UI page
shinyUI(navbarPage(theme = shinytheme("slate"), 'UFO Analysis',
                   # shinythemes::themeSelector(),
                   
                   # Create a tab panel for the about page
                   tabPanel('About',
                            
                            # About page title
                            titlePanel('About Page Title')
                            
                            # About page information goes here 
                   ), 
                   
                   # Create a tab panel for map page
                   tabPanel('Map',
                            
                            # Map page title
                            titlePanel(  
                              textOutput("title")
                              ),
                            # Map page information goes here
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('state', 'State', choices = toupper(state.abb), selected = "WA" ),
                                    sliderInput("years", "Year:", min = 1998, max = 2014, value = 2000),
                                    uiOutput("myList")
                                ),
                                
                                mainPanel(
                                  leafletOutput("map")
                                )
                              )
                    ),
                   
                   # Create a tab panel for the plot page
                   tabPanel('Plot',
                            align = "center",
                            
                            # Map page title
                            titlePanel('Proportion of UFO Reports by State, Shape, or Year'),
                            
                            # Map page information goes here
                            sidebarLayout(
                              position = "left",
                              sidebarPanel(
                                selectInput(inputId = "options",
                                            label = "UFO Data By:",
                                            choices = c("State", "Shape", "Year"),
                                            selected = "State")
                              ),
                              
                              # Map page main panel chart 
                              mainPanel(
                                plotlyOutput("pie")
                              )
                            )
                   ),
                   
                   # Create a tab panel for the conclusion page
                   tabPanel('Conclusion',
                            
                            # Map page title
                            titlePanel('Conclusion Page Title')
                            
                            # Conclusion page information goes here
                   )
      )
)
