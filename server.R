library(shiny)
library(ggplot2)
library(scales)
library(grid)
library(gridExtra)

plot_p_square <- function(dim, percents, title = FALSE){
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
  col_display <- c('O','B','G','P','R','Y')[1:cats]
  sub_title <- paste0(col_display, 
                      ": ", 
                      percent(percents_adj), 
                      collapse = ", ")
  
  full_title <- ifelse(title, full_title, '')
  
  #draw plot
  ggplot(sq_table, aes(x = x, y = y))+
    geom_tile(aes(fill = factor(category)),
              colour = 'grey90', alpha = .8)+
    #scale_fill_brewer(palette = 'Set1') +
    scale_fill_manual(values = c(
      '1' = '#FF7F00', '2' = '#377EB8',
      '3' = '#4DAF4A', '4' = '#984EA3',
      '5' = '#E41A1C', '6' = '#FFFF33'
    ))+
    theme_minimal()+
    coord_fixed()+
    theme(legend.position = 'none',
          axis.text = element_blank(),
          axis.title = element_blank(),
          panel.grid = element_blank(),
          plot.margin= unit(rep(.1, 4), "lines"),
          plot.subtitle = element_text(size = 14))+
    ggtitle(full_title, subtitle = sub_title)+
    labs(x = NULL, y = NULL)
}

shinyServer(function(input, output){

  #build vector of percentages
  percs_1 <-   reactive({
    if(input$sq_d == 1){
    c(input$cat1_1, input$cat2_1,
      input$cat3_1, input$cat4_1,
      input$cat5_1, input$cat6_1)[1:input$cats]
    }else{
      c(input$cat1_1b, input$cat2_1b,
        input$cat3_1b, input$cat4_1b,
        input$cat5_1b, input$cat6_1b)[1:input$cats]
    }
  }
  )
  
  percs_2 <-   reactive({
    c(input$cat1_2, input$cat2_2,
      input$cat3_2, input$cat4_2,
      input$cat5_2, input$cat6_2)[1:input$cats]
  }
  )
  
  percs_3 <-   reactive({
    if(input$sq_d == 3){
    c(input$cat1_3, input$cat2_3,
      input$cat3_3, input$cat4_3,
      input$cat5_3, input$cat6_3)[1:input$cats]
    }else{
      c(input$cat1_3b, input$cat2_3b,
        input$cat3_3b, input$cat4_3b,
        input$cat5_3b, input$cat6_3b)[1:input$cats]
    }
  }
  )
  
  percs_4 <-   reactive({
    c(input$cat1_4, input$cat2_4,
      input$cat3_4, input$cat4_4,
      input$cat5_4, input$cat6_4)[1:input$cats]
  }
  )
  
  
  gen_square1 <- reactive({
    plot_p_square(dim = input$dims, percents = percs_1(), title = TRUE)
  })
  
  gen_square2 <- reactive({
    plot_p_square(dim = input$dims, percents = percs_2())
  })
  
  gen_square3 <- reactive({
    plot_p_square(dim = input$dims, percents = percs_3())
  })
  
  gen_square4 <- reactive({
    plot_p_square(dim = input$dims, percents = percs_4())
  })

  #make the plot
  output$squarePlot <- renderPlot(
    {
      if(input$sq_d == 1){
        grid.arrange(gen_square1())
      }else if(input$sq_d == 2){
        grid.arrange(
          gen_square1(),
          gen_square2(),
          nrow = 1
        )
      }else if(input$sq_d == 3){
        grid.arrange(
          gen_square1(),
          gen_square2(),
          gen_square3(),
          nrow = 2,
          clip = TRUE,
          padding = unit(.1, 'line')
        )
      }else{
        grid.arrange(
          gen_square1(),
          gen_square2(),
          gen_square3(),
          gen_square4(),
          nrow = 2,
          clip = TRUE,
          padding = unit(.1, 'line')
        )
      }
      
  }
  )
  }
)