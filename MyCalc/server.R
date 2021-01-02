#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$selected_var1 <- renderText({ 
        paste("The first number you selected: ", input$var1)
    })
    output$selected_var2 <- renderText({ 
        paste("The second number you selected: ", input$var2)
    })
    output$selected_var3 <- renderText({ 
        paste("The computation method you selected: ", input$var3)
    })

    v <- reactiveValues(respond = FALSE)
    
    observeEvent(input$compute, {
        v$respond <- input$compute
    })
    
    observeEvent(input$clear, {
        v$respond <- FALSE
    })  
    
    output$answer <- renderText({
        if (v$respond == FALSE) return()
        isolate({
            data <- if (input$var3 == "Addition") {
                (as.numeric(input$var1) + as.numeric(input$var2))
            } else if (input$var3 == "Subtraction") {
                (as.numeric(input$var1) - as.numeric(input$var2))
            } else if (input$var3 == "Multiplication") {
                (as.numeric(input$var1) * as.numeric(input$var2))
            } else if (input$var3 == "Division") {
                (as.numeric(input$var1) / as.numeric(input$var2))
            } else {
                input$var1 
            }
            
            paste("The calculated solution = ", data)
            
        })
    })
})
