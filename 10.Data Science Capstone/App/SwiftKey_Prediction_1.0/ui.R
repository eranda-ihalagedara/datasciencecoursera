#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
navbarPage(
  
    title = "SwiftKey Prediction",

    # Application title
    tabPanel(
      title = "Predictor",
      # Sidebar with a slider input for number of bins
      sidebarLayout(
          sidebarPanel(
            width=3,
            textAreaInput("phrase", "Text Input", height = "100px"),
            submitButton("Submit"),
            em("*Prediction may take few seconds")
              
          ),
  
          # Show a plot of the generated distribution
          mainPanel(
              #wordcloud2Output("cloud", height = "200px"),
            
            tabsetPanel(
  
              tabPanel("Possible next words", 
                       tableOutput("next_word")
                       ),
              
              tabPanel("Word Cloud",
                       plotOutput("cloud")
              )
              
            )
          )
      )
    ),
    
    tabPanel(
      title = "About",
      
      h3("Data Science Specialization - Coursera"),
      p("This is a ",
        a("Shiny", href="https://shiny.posit.co/"),
        " app developed using RStudio, for the course procject of ",
        a("Data Science Capstone",href="https://www.coursera.org/learn/data-science-project"),
        " under ",
        a("Data Science Specialization",href="https://www.coursera.org/specializations/jhu-data-science"),". The goal is to build a prediction model that predicts the next word, given a phrase."
      ),
      p(
        "The datasets used in this project can be found here:",
        a("Coursera-SwiftKey.zip", href="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip")
        
      ),
      p(
        "Source code + Presentation: ",
        a("repo", href="https://github.com/eranda-ihalagedara/datasciencecoursera/tree/master/10.Data%20Science%20Capstone")
      )
      
    )
)
