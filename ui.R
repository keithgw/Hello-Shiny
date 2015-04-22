# load shiny package
library(shiny)
# Initialize Shiny UI
shinyUI(
    pageWithSidebar(
        headerPanel("Fuel Economy Prediction"),
        sidebarPanel(
            sliderInput('weight', 
                        'Select weight (lb)', 
                        3325, 
                        min=1513,
                        max=5424,
                        step=10
                        ),
            sliderInput('horsepower',
                        'Select horsepower',
                        123.0,
                        min=52.0,
                        max=335.0,
                        step=1.0
                        ),
            selectInput('cylinders',
                        'Number of cylinders',
                        c('4' = 4, '6' = 6, '8' = 8),
                        selected = '4'
                        ),
            selectInput('transmission',
                        'Transmission type',
                        c('automatic', 'manual')
                        )
            ),
        mainPanel(
            tabsetPanel(
                tabPanel("Prediction",
                         h3('Predicted Fuel Economy'),
                         h4('Predicted miles per gallon'),
                         verbatimTextOutput("prediction"),
                         h4('Prediction interval lower bound'),
                         verbatimTextOutput("lower"),
                         h4('Prediction interval upper bound'),
                         verbatimTextOutput("upper"),
                         plotOutput("mpg", width = "25%")
                         ),
                tabPanel("Documentation",
                         p(                           
                             'This app is designed to give a predicted fuel
                             economy (mpg) for a car with a given weight, 
                             horsepower, number of cylinders, and 
                             transmission type. The prediction is fit from 
                             a linear model based on the mtcars data set 
                             in R. This app is an extension of the project 
                             created in the regression models course.'
                             ),
                         br(),
                         p(
                             'To get a prediction, the user can modify the 
                             parameters in the side bar. In addition to a 
                             prediction (in mpg), the user will also be 
                             given a prediction interval as a measure of 
                             uncertainty.'
                             )
                         )
                )
           
            )
        )
)