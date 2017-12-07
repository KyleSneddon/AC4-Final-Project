# Load needed libraries
library("shiny")
library("plotly")
library("shinythemes")
library("leaflet")
# Construct shiny UI page
shinyUI(navbarPage(theme = shinytheme("slate"),'UFO Reporting Analysis',
                   
                   # Create a tab panel for the about page
                   tabPanel('About',
                            
                            # Inserts markdown page
                            includeMarkdown("about.md")
                   ), 
                   
                   # Create a tab panel for the map page
                   tabPanel('Map',
                            
                            # Map page title
                            titlePanel(  
                              textOutput("title")),
                            
                            # Create side bar with widgets
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('state', 'State', choices = toupper(state.abb), selected = "WA" ),
                                    sliderInput("years", "Year:", min = 1998, max = 2014, value = 2000),
                                    uiOutput("myList")
                                ),
                                
                                # Insert map plot into main panel
                                mainPanel(
                                  leafletOutput("map")
                                )
                              )
                    ),
              
                   # Create a tab panel for the plot page
                   tabPanel('Chart',
                            
                            # Map page title
                            titlePanel(textOutput("title2")),
                            
                            # Map page side panel widget
                            sidebarLayout(
                              position = "left",
                              sidebarPanel(
                                selectInput(inputId = "options",
                                            label = "UFO Data By:",
                                            choices = c("State", "Shape", "Year"),
                                            selected = "State")
                              ),
                              
                              # Insert pie chart into main panel
                              mainPanel(
                                plotlyOutput("pie")
                              )
                            )
                   ),
                   
                   # Create a tab panel for the conclusion page
                   tabPanel('Findings',
                            
                            # Insert markdown page
                            includeMarkdown("conclusion.md")
                   )
))
