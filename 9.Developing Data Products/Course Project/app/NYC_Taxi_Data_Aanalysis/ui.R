#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)
library(plotly)

# Define UI for application that draws a histogram

navbarPage(
  title = "NYC Yellow Taxi Data Analysis (June 2023)",
  #theme = shinytheme("flatly"),
  #theme = bs_theme(version = 4, bootswatch = "minty"),
  
  tabPanel(
    title = "Data Analysis",
    
    sidebarLayout(
      
      sidebarPanel(width=3, 
        
        sliderInput(
          "hour",
          "Hour:",
          min = 0,
          max = 23,
          value = c(0,23)),
        
        checkboxGroupInput(
          "days",
          "Days:",
          choices = c("Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                      "Saturday",
                      "Sunday"),
          selected = c("Monday",
                       "Tuesday",
                       "Wednesday",
                       "Thursday",
                       "Friday",
                       "Saturday",
                       "Sunday")
                           
        ),
        
        checkboxGroupInput(
          "boroughs",
          "Pickup Borough:",
          choices = c("Manhattan",
                      "Bronx",
                      "Brooklyn",
                      "EWR",
                      "Queens",
                      "Staten Island"),
          selected  = c("Manhattan",
                        "Bronx",
                        "Brooklyn",
                        "EWR",
                        "Queens",
                        "Staten Island")
        ),
        
        actionButton("reset", "Reset")
      ),
      
     
      mainPanel(
        
        tabsetPanel(type = "tabs",
          tabPanel(
            "Trip Count",
                   
            fluidRow(
             column(6, 
                    h3("Daily Trip Count"), 
                    plotlyOutput("daycount_plot"))
             ,
             column(6,
                    h3("Hourly Trip Count"),
                    plotlyOutput("hourcount_plot"))
            ),
            
            fluidRow(h3("Heatmap"),
                     plotlyOutput("heatmap_count"))
          ),
          
        
          tabPanel(
            "Trip Fare",
            fluidRow(
             column(6, 
                    h3("Daily Trip Mean Fare"), 
                    plotlyOutput("dayfare_plot"))
             ,
             column(6,
                    h3("Hourly Trip Mean Fare"),
                    plotlyOutput("hourfare_plot"))
            ),
            
            fluidRow(h3("Heatmap"),
                    plotlyOutput("heatmap_fare"))
          ),
          
          
          tabPanel(
            "Trip Distance",
            fluidRow(
             column(6, 
                    h3("Daily Trip Mean Distance"), 
                    plotlyOutput("daydist_plot"))
             ,
             column(6,
                    h3("Hourly Trip Mean Distance"),
                    plotlyOutput("hourdist_plot"))
            ),
            
            fluidRow(h3("Heatmap"),
                    plotlyOutput("heatmap_dist"))
          ),
          
          
          tabPanel(
            "Trip Duration",
            fluidRow(
              column(6, 
                     h3("Daily Trip Mean Duration"), 
                     plotlyOutput("daydur_plot"))
              ,
              column(6,
                     h3("Hourly Trip Mean Duration"),
                     plotlyOutput("hourdur_plot"))
            ),
            
            fluidRow(h3("Heatmap"),
                     plotlyOutput("heatmap_dur"))
          )
          
        )
      )
    )
           ),
  
  tabPanel(
    title = "Supporting Documentation",
    h4("How to go through analysis"),
    p("This app displays an analysis of NYC Yellow Taxi trip data for the month of June 2023. In the main tab, Data Analysis, there are 4 sub-tabs corresponding to:",
      HTML("<ol>
      <li>Trip Count</li>
      <li>Trip Fare</li>
      <li>Trip Distance</li>
      <li>Trip Duration</li>
      </ol>
      "),
      "Each sub-tab indcludes charts for daily, hourly and heatmap."
    ),
    p("In the sidebar of the Data Analysis tab, you can filter the values displayed in the charts based on:",
      HTML("<ul>
      <li>Hour </li>
      <li>Day</li>
      <li>Pickup Borough</li>
      </ul>
      "),
      "You can select the range of hours through the slider, select day and borough using the check boxes."
    ),
    p("Use the ", strong("Reset"), " button the roll back to original range and selections.")
    
  ),
  
#  tabPanel(
#    title = "Fare Estimation",
#    p(strong(em("DISCLAIMER: These estimations are based on a subset of the original dataset and only estimates the fare amount not the total amount. This is only for educational purposes and not to be used for real life applications."))
#    )
#    ),
  
  tabPanel(
    title = "References",
    
    h3("Data Science Specialization - Coursera"),
    p("This is a ",
      a("Shiny", href="https://shiny.posit.co/"),
      " app developed using RStudio, for the course procject of ",
      a("Developing Data Products",href="https://www.coursera.org/learn/data-products"),
      " under ",
      a("Data Science Specialization",href="https://www.coursera.org/specializations/jhu-data-science"),"."
    ),
    
    h3("TLC Trip Record Data"),
    p("The data were obtained from the public datasets provided by NYC Taxi and Limousine Commission (TLC).",
      "Yellow Taxi Trip Records for the month of June 2023 was used in this project which can be found here:",  
      a("TLC Trip Record Data",href="https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page"),
      "Original data set was cleaned of missing values and outliers before using in this analysis"
    ),
    h3("Project Files"),
    p("Source files can be found here:",
      a("Repo", href="https://github.com/eranda-ihalagedara/datasciencecoursera/tree/master/9.Developing%20Data%20Products/Course%20Project"))
  )
)


