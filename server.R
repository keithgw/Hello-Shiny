library(shiny)
library(ggplot2)
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
        
        # create plot of prediction and interval
        output$mpg <- renderPlot({
            ggplot(as.data.frame(mpg_hat())) +
                geom_line(aes(c(1, 1), c(lwr, upr)), col="#F1BB7B") + 
                geom_point(aes(1, fit), col="#5B1A18", size = 6) +
                geom_point(aes(c(1, 1), c(lwr, upr)), 
                           col="#D67236", size = 6, shape = 18) +
                labs(x = "", y = "Miles per Gallon") +
                theme(axis.title.y = element_text(size = 20),
                      axis.text.x = element_blank()) + 
                coord_cartesian(xlim = c(.9, 1.1),
                                ylim = c(-2, 36))
        })
    }
)

