library(shiny)
library(ggplot2)
library(scales)

plot_p_square <- function(dim, percents){
  #require packages
  require(scales)
  require(ggplot2)
  #how many percents were supplied
  #can only handle 2 - 6 currently
  #perform error checking
  cats <- length(percents)
  if (cats < 2){
    stop('You have provided one percentage, please provide 2 -6.')
  }else if(cats > 6){
    stop('You have provided > 6 percentages, we currently support 2-6.')
  }
  #how many squares
  num_of_squares <- dim^2
  #adjusted percentage
  #users will most likely not supply
  #pi_1, ..., pi_j s.t. sum(pi_i) == 1
  percents_adj <- percents / sum(percents)
  #how many squares of each category
  sq_for_each <- round(num_of_squares * percents_adj)
  #how off are we
  diff_between <- num_of_squares - sum(sq_for_each)
  #adjust square numbers if we were off
  if(diff_between > 0){
    samp_it <- sample(1:cats, 1)
    sq_for_each[samp_it] <- sq_for_each[samp_it] + diff_between
  }else if(diff_between < 0){
    sq_for_each[which.max(sq_for_each)] <- 
      sq_for_each[which.max(sq_for_each)] + diff_between
  }
  #generate table
  sq_table <- expand.grid(
    'x' = 1:dim, 'y' = 1:dim
  )
  #add category column
  sq_table$category <- sample(rep(1:cats, sq_for_each))
  #add title
  title1 <- "With a population of 100,000 people, each square would represent about"
  title2 <- comma(round(100000 / num_of_squares))
  title3 <- "people."
  
  full_title <- paste(title1, title2, title3)
  
  #show percentages
  col_display <- c('R','B','G','P','O','Y')[1:cats]
  sub_title <- paste0(col_display, 
                      ": ", 
                      percent(percents_adj), 
                      collapse = ", ")
  
  #draw plot
  ggplot(sq_table, aes(x = x, y = y))+
    geom_tile(aes(fill = factor(category)),
              colour = 'grey90')+
    scale_fill_brewer(palette = 'Set1')+
    theme_minimal()+
    coord_fixed()+
    theme(legend.position = 'none',
          axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank())+
    ggtitle(full_title, subtitle = sub_title)
}

shinyServer(function(input, output){

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
  
  gen_squares <- reactive({
    plot_p_square(dim = input$dims, percents = percs())
  })

  #make the plot, lots of reactivity stuff
  output$squarePlot <- renderPlot(
    {
      gen_squares()
  }
  )
  }
)