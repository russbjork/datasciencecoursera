library(shiny)
library(miniUI)

multiplynums <- function(numb1,numb2) {

    ui <- miniPage(
    gadgetTitleBar("Multiply two numbers"),
    miniContentPanel(
      selectInput("num1", "First Number", choices=numb1),
      selectInput("num2", "Second Number", choices=numb2)
      )
    )

    server <- function(input,output,session) {
    #The Done button closes the application
    observeEvent(input$done, {
      num1 <- as.numeric(input$num1)
      num2 <- as.numeric(input$num2)
      stopApp(num1 * num2)
      })
    }

  runGadget(ui, server)
}