#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(viridis)

load("data.RData")

# Define server logic required to draw a histogram
function(input, output, session) {
  
  observe({
    if(length(input$boroughs) < 1){
      updateCheckboxGroupInput(session, "boroughs", selected= "Staten Island")
    }
    
    if(length(input$days) < 1){
      updateCheckboxGroupInput(session, "days", selected= "Sunday")
    }
    
  })
  
  observeEvent(input$reset, {
    updateSliderInput(session, "hour", val = c(0,23))
    updateCheckboxGroupInput(
      session, 
      "days", 
      selected=c("Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                  "Sunday"))
    updateCheckboxGroupInput(
      session, 
      "boroughs", 
      selected=c("Manhattan",
                 "Bronx",
                 "Brooklyn",
                 "EWR",
                 "Queens",
                 "Staten Island"))

  })
  


  # ========================= Count =========================
  output$daycount_plot <- renderPlotly({
    
    dayp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day) %>% summarise(count=sum(count)) %>% 
      ggplot()+geom_col(aes(x=day, y=count), fill="red4")+
      theme(axis.text.x = element_text(angle = 30))+
      labs(x="Day", y="Count")
    
    ggplotly(dayp)
    
  })
  
  output$hourcount_plot <- renderPlotly({
    
    hourp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(hour) %>% summarise(count=sum(count)) %>% 
      ggplot()+geom_col(aes(x=hour, y=count), fill="blue4")+
      labs(x="Hour", y="Count")
    
    ggplotly(hourp)
    
  })
  
  output$heatmap_count = renderPlotly({
    
    if((length(input$days)<1)|(length(input$boroughs)<1)){
      boroughs = c("Staten Island")
      days = c("Sunday")
    }else{
      boroughs=input$boroughs
      days = input$days
    }
    
    countp = day_hour_summ %>% 
      filter(Borough %in% boroughs) %>% 
      filter(day %in% days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day, hour) %>% summarise(count=sum(count)) %>% 
      ggplot()+
      geom_tile(aes(x=day, y=hour, fill=count))+
      scale_fill_viridis(discrete=FALSE, name="Count")+
      labs(x="Day", y="Hour")
  })
  
  
  # ========================= Fare =========================
  output$dayfare_plot <- renderPlotly({
    
    dayp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day) %>% summarise(mean_fare=weighted.mean(mean_fare, count)) %>% 
      ggplot()+geom_col(aes(x=day, y=mean_fare), fill="red4")+
      theme(axis.text.x = element_text(angle = 30))+
      labs(x="Day", y="Mean Fare")
    
    ggplotly(dayp)
    
  })
  
  output$hourfare_plot <- renderPlotly({
    
    hourp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(hour) %>% summarise(mean_fare=weighted.mean(mean_fare, count)) %>% 
      ggplot()+geom_col(aes(x=hour, y=mean_fare), fill="blue4")+
      labs(x="Hour", y="Mean Fare")
    
    ggplotly(hourp)
    
  })
  
  
  output$heatmap_fare = renderPlotly({
    
    if((length(input$days)<1)|(length(input$boroughs)<1)){
      boroughs = c("Staten Island")
      days = c("Sunday")
    }else{
      boroughs=input$boroughs
      days = input$days
    }
    
    countp = day_hour_summ %>% 
      filter(Borough %in% boroughs) %>% 
      filter(day %in% days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day, hour) %>% summarise(mean_fare=weighted.mean(mean_fare, count)) %>% 
      ggplot()+
      geom_tile(aes(x=day, y=hour, fill=mean_fare))+
      scale_fill_viridis(discrete=FALSE, name="Mean Fare")+
      labs(x="Day", y="Hour")
  })
  
  # ========================= Distance =========================
  
  output$daydist_plot <- renderPlotly({
    
    dayp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day) %>% summarise(mean_distance=weighted.mean(mean_distance, count)) %>% 
      ggplot()+geom_col(aes(x=day, y=mean_distance), fill="red4")+
      theme(axis.text.x = element_text(angle = 30))+
      labs(x="Day", y="Mean Distance (miles)")
    
    ggplotly(dayp)
    
  })
  
  output$hourdist_plot <- renderPlotly({
    
    hourp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(hour) %>% summarise(mean_distance=weighted.mean(mean_distance, count)) %>% 
      ggplot()+geom_col(aes(x=hour, y=mean_distance), fill="blue4")+
      labs(x="Day", y="Mean Distance (miles)")
    
    ggplotly(hourp)
    
  })
  
  
  output$heatmap_dist = renderPlotly({
    
    if((length(input$days)<1)|(length(input$boroughs)<1)){
      boroughs = c("Staten Island")
      days = c("Sunday")
    }else{
      boroughs=input$boroughs
      days = input$days
    }
    
    countp = day_hour_summ %>% 
      filter(Borough %in% boroughs) %>% 
      filter(day %in% days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day, hour) %>% summarise(mean_distance=weighted.mean(mean_distance, count)) %>% 
      ggplot()+
      geom_tile(aes(x=day, y=hour, fill=mean_distance))+
      scale_fill_viridis(discrete=FALSE, name="Mean Distance (miles)")+
      labs(x="Day", y="Hour")
  })
  
 
  # ========================= Duration =========================

  output$daydur_plot <- renderPlotly({
    
    dayp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day) %>% summarise(mean_duration=weighted.mean(as.numeric(mean_duration), count)/60) %>% 
      ggplot()+geom_col(aes(x=day, y=mean_duration), fill="red4")+
      theme(axis.text.x = element_text(angle = 30))+
      labs(x="Day", y="Mean Duration (minutes)")
    
    ggplotly(dayp)
    
  })
  
  output$hourdur_plot <- renderPlotly({
    
    hourp = day_hour_summ %>% 
      filter(Borough %in% input$boroughs) %>% 
      filter(day %in% input$days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(hour) %>% summarise(mean_duration=weighted.mean(as.numeric(mean_duration), count)/60) %>% 
      ggplot()+geom_col(aes(x=hour, y=mean_duration), fill="blue4")+
      labs(x="Hour", y="Mean Duration (minutes)")
    
    ggplotly(hourp)
    
  })
  
  
  output$heatmap_dur = renderPlotly({
    
    if((length(input$days)<1)|(length(input$boroughs)<1)){
      boroughs = c("Staten Island")
      days = c("Sunday")
    }else{
      boroughs=input$boroughs
      days = input$days
    }
    
    countp = day_hour_summ %>% 
      filter(Borough %in% boroughs) %>% 
      filter(day %in% days) %>% 
      filter(between(hour, input$hour[1], input$hour[2])) %>% 
      group_by(day, hour) %>% summarise(mean_duration=weighted.mean(as.numeric(mean_duration), count)/60) %>% 
      ggplot()+
      geom_tile(aes(x=day, y=hour, fill=mean_duration))+
      scale_fill_viridis(discrete=FALSE, name="Mean Duration (minutes)")+
      labs(x="Day", y="Hour")
  })
  
}
