#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("My Simple Calculator"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("var1", "Select Value 1:", 
                        c(1:10),
                        selected = "1"),
            selectInput("var2", "Select Value 2:", 
                        c(1:10),
                        selected = "1"),
            selectInput("var3", "Select Computation Option:", 
                        c("Addition", "Subtraction", "Multiplication", "Division"),
                        selected = "Addition"),
            actionButton("compute", "Compute"),
            actionButton("clear", "Clear")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("selected_var1"),
            textOutput("selected_var2"),
            textOutput("selected_var3"),
            textOutput("answer")
        )
    )
))
