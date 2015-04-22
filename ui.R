# load shiny package
library(shiny)
# Initialize Shiny UI
shinyUI(
    pageWithSidebar(
        headerPanel("Fuel Economy Prediction"),
        sidebarPanel(
            h3("Vehicle 1"),
            sliderInput('weight1', 
                        'Select weight (lb)', 
                        3325, 
                        min=1513,
                        max=5424,
                        step=10
                        ),
            sliderInput('horsepower1',
                        'Select horsepower',
                        123.0,
                        min=52.0,
                        max=335.0,
                        step=1.0
                        ),
            selectInput('cylinders1',
                        'Number of cylinders',
                        c('4' = 4, '6' = 6, '8' = 8),
                        selected = '4'
                        ),
            selectInput('transmission1',
                        'Transmission type',
                        c('automatic', 'manual')
                        ),
            h3("Vehicle 2"),
            sliderInput('weight2', 
                        'Select weight (lb)', 
                        3325, 
                        min=1513,
                        max=5424,
                        step=10
                        ),
            sliderInput('horsepower2',
                        'Select horsepower',
                        123.0,
                        min=52.0,
                        max=335.0,
                        step=1.0
                        ),
            selectInput('cylinders2',
                        'Number of cylinders',
                        c('4' = 4, '6' = 6, '8' = 8),
                        selected = '4'
                        ),
            selectInput('transmission2',
                        'Transmission type',
                        c('automatic', 'manual'),
                        selected = 'manual'
                        )
            ),
        mainPanel(
            tabsetPanel(
                tabPanel("Prediction",
                         plotOutput("mpg", width = "40%"),
                         h3('Predicted Fuel Economy: Vehicle 1'),
                         h4('Predicted miles per gallon'),
                         verbatimTextOutput("prediction1"),
                         h4('Prediction interval lower bound'),
                         verbatimTextOutput("lower1"),
                         h4('Prediction interval upper bound'),
                         verbatimTextOutput("upper1"),
                         h3('Predicted Fuel Economy: Vehicle 2'),
                         h4('Predicted miles per gallon'),
                         verbatimTextOutput("prediction2"),
                         h4('Prediction interval lower bound'),
                         verbatimTextOutput("lower2"),
                         h4('Prediction interval upper bound'),
                         verbatimTextOutput("upper2")
                         ),
                tabPanel("Documentation",
                         p(                           
                             'This app is designed to compare predicted fuel
                             economies (mpg) for two cars with given weights, 
                             horsepower, numbers of cylinders, and 
                             transmission types. The predictions are fit from 
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
                             uncertainty. The comparison is plotted for easy 
                             visualization.'
                             )
                         )
                )
           
            )
        )
)