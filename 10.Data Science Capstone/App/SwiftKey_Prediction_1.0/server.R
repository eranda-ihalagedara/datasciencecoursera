#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(wordcloud)
library(scales)

load("pred_data.Rda")

predict_next = function(input=""){
  input = str_to_lower(str_squish(input))
  
  if(str_count(input)==0){
    next_w = unigram_df %>% head(5) %>% rename(nxt = word)
    
  }else if(str_count(input)>0){
    wcount = str_count(input, " ") + 1
    
    if(wcount>=3){
      phr = word(input, -3,-1)
      next_w = tetragrams_pred %>% filter(phrase==phr)
      
      if(nrow(next_w)<1){
        phr = word(input, -2,-1)
        next_w = trigrams_pred %>% filter(phrase==phr)
        
        if(nrow(next_w)<1){
          phr = word(input,-1)
          next_w = bigrams_pred %>% filter(phrase==phr)
          
        }
        
      }
      
    } else if(wcount==2){
      phr = word(input, -2,-1)
      next_w = trigrams_pred %>% filter(phrase==phr)
      
      if(nrow(next_w)<1){
        phr = word(input,-1)
        next_w = bigrams_pred %>% filter(phrase==phr)
        
      }
      
    } else if(wcount==1){
      phr = word(input,-1)
      next_w = bigrams_pred %>% filter(phrase==phr)
      
    }
    
  }
  
  if(nrow(next_w)<1){
    next_w = unigram_df %>% head(5)%>% rename(nxt = word)
  }
  
  next_w
}

bb = bigrams_pred %>% head()

# Define server logic required to draw a histogram
server = function(input, output, session) {
  
    nxt = reactive({
      predict_next(input$phrase)
    })
    
    output$next_word = renderTable({
      gc()
      nxt()  %>% ungroup() %>% select(nxt, n) %>% rename(word=nxt, frequency=n)
    })
    
    #output$cloud = renderWordcloud2({
    #  nxt() %>% ungroup() %>% select(nxt, n) %>% wordcloud2(kk, size = 0.8)
    #  
    #})
    
    output$cloud = renderPlot({
      pred = nxt()
      gc()
      wordcloud(pred$nxt, pred$n,
                colors = hue_pal()(nrow(pred)), 
                min.freq = 1, max.words = 10, scale = c(6,2))
    })


}
