library(shiny)
library(ggplot2)
library(dplyr)
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
        mpg_hat1 <- reactive({
            predict(fit, 
                    data.frame(wt = input$weight1 / 1000,
                               hp = input$horsepower1,
                               cyl = input$cylinders1,
                               am = input$transmission1), 
                    interval = "prediction")
        })
        mpg_hat2 <- reactive({
            predict(fit, 
                    data.frame(wt = input$weight2 / 1000,
                               hp = input$horsepower2,
                               cyl = input$cylinders2,
                               am = input$transmission2), 
                    interval = "prediction")
        })
        
        # return mpg prediction 1 for printing
        output$prediction1 <- renderText({
            mpg_hat1()[1]
        })
        
        # return prediction interval 1 for printing
        output$lower1 <- renderText({
            mpg_hat1()[2]
        })
        output$upper1 <- renderText({
            mpg_hat1()[3]
        })
        
        # return mpg prediction 2 for printing
        output$prediction2 <- renderText({
            mpg_hat2()[1]
        })
        
        # return prediction interval 2 for printing
        output$lower2 <- renderText({
            mpg_hat2()[2]
        })
        output$upper2 <- renderText({
            mpg_hat2()[3]
        })
        
        # create plot of prediction and interval
        output$mpg <- renderPlot({
            ggplot(full_join(as.data.frame(mpg_hat1()),
                             as.data.frame(mpg_hat2())
                             )
                   ) +
                geom_line(aes(c(1, 1), c(lwr[1], upr[1])), col="#F1BB7B") + 
                geom_line(aes(c(2, 2), c(lwr[2], upr[2])), col="#F1BB7B") +
                geom_point(aes(1, fit[1]), col="#5B1A18", size = 6) +
                geom_point(aes(2, fit[2]), col="#5B1A18", size = 6) +
                geom_point(aes(c(1, 1), c(lwr[1], upr[1])), 
                           col="#D67236", size = 6, shape = 18) +
                geom_point(aes(c(2, 2), c(lwr[2], upr[2])), 
                           col="#D67236", size = 6, shape = 18) +
                labs(x = "Vehicle", y = "Miles per Gallon") +
                theme(axis.title.y = element_text(size = 20)) + 
                scale_x_discrete(limits = c(1, 2)) +
                coord_cartesian(ylim = c(-2, 36))
        })
    }
)

