library(shiny)
data(mtcars)

# change transmission variable to factor and relabel
mtcars$am <- factor(mtcars$am)
mtcars$cyl <- factor(mtcars$cyl)
levels(mtcars$am) <- c('automatic', 'manual')

# fit a linear model to predict mpg
fit <- lm(mpg ~ am + wt + cyl + hp, data=mtcars)

shinyServer(
    function(input, output) {
        
        # create prediction object with interval from inputs
        mpg_hat <- reactive({
            predict(fit, 
                    data.frame(wt = input$weight / 1000,
                               hp = input$horsepower,
                               cyl = input$cylinders,
                               am = input$transmission), 
                    interval = "prediction")
        })
        
        # return mpg prediction for printing
        output$prediction <- renderText({
            mpg_hat()[1]
        })
        
        # return prediction interval for printing
        output$lower <- renderText({
            mpg_hat()[2]
        })
        output$upper <- renderText({
            mpg_hat()[3]
        })
    }
)