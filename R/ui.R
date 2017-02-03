library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Probability Squares"),
  
  sidebarLayout(
    
    #ask for number of squares
    sliderInput('dims',
                'Size of Square (will be X by X)',
                min = 10,
                value = 25,
                max = 100),
    #ask for number of categories
    radioButtons('cats',
                 'Number of Categories',
                 choices = 2:6,
                 selected = 2),
    #based on number of categories, we show the number of 
    # fields 
    numericInput('cat1',
                 '% of Total for 1st Category (R)',
                 min = 0,
                 max = 100,
                 step = 1),
    
    numericInput('cat2',
                 '% of Total for 2nd Category (B)',
                 min = 0,
                 max = 100,
                 step = 1
                 ),
    
    conditionalPanel("input.cats >= 3",
    numericInput('cat3',
                 '% of Total for 3rd Category (G)',
                 min = 0,
                 max = 100,
                 step = 1
    )
    ),
    
    conditionalPanel("input.cats >= 4",
    numericInput('cat4',
                 '% of Total for 4th Category (P)',
                 min = 0,
                 max = 100,
                 step = 1
    )
    ),
    
    conditionalPanel("input.cats >= 5",
    numericInput('cat5',
                 '% of Total for 5th Category (O)',
                 min = 0,
                 max = 100,
                 step = 1
    )
    ),
    
    conditionalPanel("input.cats >= 6",
    numericInput('cat6',
                 '% of Total for 6th Category (Y)',
                 min = 0,
                 max = 100,
                 step = 1
    )),
    
    
    mainPanel(
      plotOutput(
        "squarePlot"
      )
    )
    
    
    
    
  )
  
)
)