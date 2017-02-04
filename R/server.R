library(shiny)
library(ggplot2)



shinyServer(function(input, output){
  #create square data.frame
  gen_squares <- reactive({expand.grid(
    'x' = 1:input$dims,
    'y' = 1:input$dims
  )})
  

  num_of_squares <- reactive({input$dims ^ 2})
  
  # 
  percs <-   reactive({
    if(input$cats == 2){
    c(input$cat1, input$cat2)
  }else if(input$cats == 3){
    c(input$cat1, input$cat2,
      input$cat3)
  }else if(input$cats == 4){
    c(input$cat1, input$cat2,
      input$cat3, input$cat4)
  }else if(input$cats == 5){
    c(input$cat1, input$cat2,
      input$cat3, input$cat4,
      input$cat5)
  }else{
    c(input$cat1, input$cat2,
      input$cat3, input$cat4,
      input$cat5, input$cat6)
  }})
  # 
  #user may have entered too high / low percentages,
  #adjust accordingly
  
  # percs_adjust <- percs / sum(percs)
  # 
  # nums_for_each <- num_of_squares * percs_adjust
  # nums_for_each.r <- round(nums_for_each)
  # 
  # diff_between <- num_of_squares - sum(nums_for_each.r)
  
  #sum of categories is less than squares needed
  #need to add the difference to a category
  #note that we are randomly selecting which category to add
  #the difference to
  
  #sum of categories is greater than squares needed 
  #take difference away from the (first) largest entry

  
  # if(diff_between > 0){
  #   samp_it <- sample(1:input$cats, 1)
  #   nums_for_each.r[samp_it] <- nums_for_each.r[samp_it] + diff_between
  # }else if(diff_between < 0){
  #   nums_for_each.r[which.max(nums_for_each.r)] <- 
  #     nums_for_each.r[which.max(nums_for_each.r)] + diff_between
  # }
  # 
  
  #create the sample
  



  
  output$squarePlot <- renderPlot({
    
    percs_adjust <- percs() / sum(percs())
    
    nums_for_each <- num_of_squares() * percs_adjust
    nums_for_each.r <- round(nums_for_each)
    
    diff_between <- num_of_squares() - sum(nums_for_each.r)
    
    
    if(diff_between > 0){
      samp_it <- sample(1:input$cats, 1)
      nums_for_each.r[samp_it] <- nums_for_each.r[samp_it] + diff_between
    }else if(diff_between < 0){
      nums_for_each.r[which.max(nums_for_each.r)] <- 
        nums_for_each.r[which.max(nums_for_each.r)] + diff_between
    }
    
    do_cols <- sample(rep(1:input$cats, nums_for_each.r))
    
    square_data <- gen_squares()
    
    square_data$color <- do_cols
  
    the_plot <- 
      ggplot(square_data, aes(x = x, y = y))+
      geom_tile(aes(fill = factor(color)), colour = 'grey90')+
      scale_fill_brewer(palette = 'Set1')+
      theme_minimal()+
      coord_fixed()+
      theme(legend.position = 'none',
            axis.text = element_blank(),
            axis.title = element_blank(),
            panel.grid = element_blank())
    
    plot(the_plot)
  })
  
  
  
  
}
)