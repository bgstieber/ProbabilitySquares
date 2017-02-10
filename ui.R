library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Probability Squares"),
  p("Here we present a vis design that can be used to",
    "communicate probabilities, likelihoods, or group memberships.",
    "In fact, it's been used to communicate classifier performance."),
  
  fluidRow(
    
    column(2,
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
                       selected = 2,
                       inline = TRUE),
           
           radioButtons('sq_d',
                       'Squares to Draw',
                       choices = 1:4,
                       inline = TRUE,
                       selected = 2),
           
           #how many squares will we draw?
           conditionalPanel("input.sq_d == 1",
                            h4('Parameters for First Square'),
                            numericInput('cat1_1',
                                         '% of Total for 1st Category (O)',
                                         min = 0,
                                         max = 100,
                                         value = 50,
                                         step = 1),
                            numericInput('cat2_1',
                                         '% of Total for 2nd Category (B)',
                                         min = 0,
                                         max = 100,
                                         value = 50,
                                         step = 1
                            ),
                            conditionalPanel("input.cats >= 3",
                                             numericInput('cat3_1',
                                                          '% of Total for 3rd Category (G)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            ),
                            
                            conditionalPanel("input.cats >= 4",
                                             numericInput('cat4_1',
                                                          '% of Total for 4th Category (P)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            ),
                            
                            conditionalPanel("input.cats >= 5",
                                             numericInput('cat5_1',
                                                          '% of Total for 5th Category (R)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            ),
                            
                            conditionalPanel("input.cats >= 6",
                                             numericInput('cat6_1',
                                                          '% of Total for 6th Category (Y)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            )
           ),
           
           
           #more than one square
           conditionalPanel("input.sq_d > 1",
                            h4('Parameters for First and Second Squares'),
                            h5('% of Total for 1st Category(O)'), 
                            fluidRow(
                              column(6,
                                     numericInput('cat1_1b',
                                                  'Square 1',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              ),
                              column(6,
                                     numericInput('cat1_2',
                                                  'Square 2',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              )
                              
                            ),
                            h5('% of Total for 2nd Category(B)'), 
                            fluidRow(
                              column(6,
                                     numericInput('cat2_1b',
                                                  'Square 1',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              ),
                              column(6,
                                     numericInput('cat2_2',
                                                  'Square 2',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              )
                            
                            ),
                              
                            conditionalPanel("input.cats > 2",
                                               h5('% of Total for 3rd Category(G)'), 
                                               fluidRow(
                                                 column(6,
                                                        numericInput('cat3_1b',
                                                                     'Square 1',
                                                                     min = 0,
                                                                     max = 100,
                                                                     value = 50,
                                                                     step = 1)
                                                 ),
                                                 column(6,
                                                        numericInput('cat3_2',
                                                                     'Square 2',
                                                                     min = 0,
                                                                     max = 100,
                                                                     value = 50,
                                                                     step = 1)
                                                 )
                                               
                                               )
                              ),
                            conditionalPanel("input.cats > 3",
                                             h5('% of Total for 4th Category(P)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat4_1b',
                                                                   'Square 1',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat4_2',
                                                                   'Square 2',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            ),
                            conditionalPanel("input.cats > 4",
                                             h5('% of Total for 5th Category(R)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat5_1b',
                                                                   'Square 1',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat5_2',
                                                                   'Square 2',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            ),
                            conditionalPanel("input.cats > 5",
                                             h5('% of Total for 6th Category(Y)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat6_1b',
                                                                   'Square 1',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat6_2',
                                                                   'Square 2',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            )
                              
                            )
                            
           ),
           
           
    column(8,
           plotOutput(
             "squarePlot",
             height = "750px"
           )
    ),
    column(2,
           conditionalPanel("input.sq_d == 3",
                            h4('Parameters for Third Square'),
                            numericInput('cat1_3',
                                         '% of Total for 1st Category (O)',
                                         min = 0,
                                         max = 100,
                                         value = 50,
                                         step = 1),
                            numericInput('cat2_3',
                                         '% of Total for 2nd Category (B)',
                                         min = 0,
                                         max = 100,
                                         value = 50,
                                         step = 1
                            ),
                            conditionalPanel("input.cats >= 3",
                                             numericInput('cat3_3',
                                                          '% of Total for 3rd Category (G)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            ),
                            
                            conditionalPanel("input.cats >= 4",
                                             numericInput('cat4_3',
                                                          '% of Total for 4th Category (P)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            ),
                            
                            conditionalPanel("input.cats >= 5",
                                             numericInput('cat5_3',
                                                          '% of Total for 5th Category (R)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            ),
                            
                            conditionalPanel("input.cats >= 6",
                                             numericInput('cat6_3',
                                                          '% of Total for 6th Category (Y)',
                                                          min = 0,
                                                          max = 100,
                                                          step = 1,
                                                          value = 50
                                             )
                            )
             
             
           ),
           
           
           
           conditionalPanel("input.sq_d == 4",
                            h4('Parameters for Third and Fourth Squares'),
                            h5('% of Total for 1st Category(O)'), 
                            fluidRow(
                              column(6,
                                     numericInput('cat1_3b',
                                                  'Square 3',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              ),
                              column(6,
                                     numericInput('cat1_4',
                                                  'Square 4',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              )
                              
                            ),
                            h5('% of Total for 2nd Category(B)'), 
                            fluidRow(
                              column(6,
                                     numericInput('cat2_3b',
                                                  'Square 3',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              ),
                              column(6,
                                     numericInput('cat2_4',
                                                  'Square 4',
                                                  min = 0,
                                                  max = 100,
                                                  value = 50,
                                                  step = 1)
                              )
                              
                            ),
                            conditionalPanel("input.cats > 2",
                                             h5('% of Total for 3rd Category(G)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat3_3b',
                                                                   'Square 3',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat3_4',
                                                                   'Square 4',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            ),
                            conditionalPanel("input.cats > 3",
                                             h5('% of Total for 4th Category(P)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat4_3b',
                                                                   'Square 3',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat4_4',
                                                                   'Square 4',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            ),
                            conditionalPanel("input.cats > 4",
                                             h5('% of Total for 5th Category(R)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat5_3b',
                                                                   'Square 3',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat5_4',
                                                                   'Square 4',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            ),
                            conditionalPanel("input.cats > 5",
                                             h5('% of Total for 6th Category(Y)'), 
                                             fluidRow(
                                               column(6,
                                                      numericInput('cat6_3b',
                                                                   'Square 3',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               ),
                                               column(6,
                                                      numericInput('cat6_4',
                                                                   'Square 4',
                                                                   min = 0,
                                                                   max = 100,
                                                                   value = 50,
                                                                   step = 1)
                                               )
                                               
                                             )
                            )
                ),
           
           
           helpText(a(href="https://twitter.com/PollsAndVotes/status/826619735152418816", 
                      target="_blank", "Inspiration from Twitter")),
           
           helpText(a(href = "http://graphics.cs.wisc.edu/Papers/2014/SAMG14/visualizing-validation-of-protein-surface-classifiers.pdf",
                      target = "_blank", "Classifier Paper")),
           
           helpText(a(href="https://github.com/bgstieber/ProbabilitySquares", 
                      target="_blank", "View Shiny code")) 
    )
    
  )
)


)
