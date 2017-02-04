library(shiny)
library(ggplot2)



shinyServer(function(input, output){
  #create square data.frame
  gen_squares <- reactive({expand.grid(
    'x' = 1:input$dims,
    'y' = 1:input$dims
  )})
  
  #take in number of squares
  num_of_squares <- reactive({input$dims ^ 2})
  
  #build vector of percentages
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

  #make the plot, lots of reactivity stuff
  output$squarePlot <- renderPlot(
    {
    
    #adjusted percentage, because people will not supply
    #pi_1 , ... , pi_j s.t. sum(pi_1, ..., pi_j) == 1
    percs_adjust <- percs() / sum(percs())
    
    #how many squares (approx.) shall we draw?
    nums_for_each <- num_of_squares() * percs_adjust
    nums_for_each.r <- round(nums_for_each)
    #how off are we?
    diff_between <- num_of_squares() - sum(nums_for_each.r)
    
    #correct for how off we are
    #if diff is > 0 (not enough), add to a randomly selected entry
    #if diff < 0 (too many squares), take away from largest category
    if(diff_between > 0){
      samp_it <- sample(1:input$cats, 1)
      nums_for_each.r[samp_it] <- nums_for_each.r[samp_it] + diff_between
    }else if(diff_between < 0){
      nums_for_each.r[which.max(nums_for_each.r)] <- 
        nums_for_each.r[which.max(nums_for_each.r)] + diff_between
    }
    #sample the colors
    do_cols <- sample(rep(1:input$cats, nums_for_each.r))
    #create data
    square_data <- gen_squares()
    #add color column 
    square_data$color <- do_cols
    
    #make the plot
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
    #draw the plot
    plot(the_plot)
  }
  )
  }
)