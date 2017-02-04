library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Probability Squares"),
  p("Here we present a vis design that can be used to",
    "communicate probabilities, likelihoods, or group memberships.",
    "In fact, it's been used to communicate classifier performance."),
  
  
  sidebarLayout(
    sidebarPanel(
    
    #ask for number of squares
    sliderInput('dims',
                'Size of Square (will be X by X)',
                min = 10,
                value = 25,
                max = 100),
    
    #ask for number of categories
    sliderInput('cats',
                 'Number of Categories',
                min = 2,
                max = 6,
                value = 2),
    
    #based on number of categories, we show the number of 
    # fields 
    numericInput('cat1',
                 '% of Total for 1st Category (R)',
                 min = 0,
                 max = 100,
                 value = 50,
                 step = 1),
    numericInput('cat2',
                 '% of Total for 2nd Category (B)',
                 min = 0,
                 max = 100,
                 value = 50,
                 step = 1
                 ),
    
    #here we use conditional panels
    #I'll bet there's a better way, I just haven't
    #figured it out....yet
    conditionalPanel("input.cats >= 3",
    numericInput('cat3',
                 '% of Total for 3rd Category (G)',
                 min = 0,
                 max = 100,
                 step = 1,
                 value = 50
    )
    ),

    conditionalPanel("input.cats >= 4",
    numericInput('cat4',
                 '% of Total for 4th Category (P)',
                 min = 0,
                 max = 100,
                 step = 1,
                 value = 50
    )
    ),

    conditionalPanel("input.cats >= 5",
    numericInput('cat5',
                 '% of Total for 5th Category (O)',
                 min = 0,
                 max = 100,
                 step = 1,
                 value = 50
    )
    ),

    conditionalPanel("input.cats >= 6",
    numericInput('cat6',
                 '% of Total for 6th Category (Y)',
                 min = 0,
                 max = 100,
                 step = 1,
                 value = 50
    )
    ),
    
    helpText(a(href="https://twitter.com/PollsAndVotes/status/826619735152418816", 
               target="_blank", "Inspiration from Twitter")),
    
    helpText(a(href = "http://graphics.cs.wisc.edu/Papers/2014/SAMG14/visualizing-validation-of-protein-surface-classifiers.pdf",
            target = "_blank", "Classifier Paper")),
    
    helpText(a(href="https://github.com/bgstieber/ProbabilitySquares", 
               target="_blank", "View Shiny code"))
    
    
    ),

    mainPanel(
      plotOutput(
        "squarePlot",
        height = "600px"
      )
    )
    
  )
    

)
)