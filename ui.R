# Load needed libraries
library("shiny")
library("plotly")
library("shinythemes")

# Construct shiny UI page
shinyUI(navbarPage(theme = shinytheme("slate"),'UFO Analysis',
                   
                   # Create a tab panel for the about page
                   tabPanel('About',
                            
                            includeMarkdown("about.md")
                   ), 
                   
                   # Create a tab panel for the map page
                  
                   
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
                            
                            includeMarkdown("conclusion.md")
                   )
))