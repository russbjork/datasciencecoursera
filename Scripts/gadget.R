library(shiny)
library(miniUI)

myFirstGadget <- function() {
  ui <- miniPage(
    gadgetTitleBar("This is a Gadget")
  )
  server <- function(input,output,session) {
    #The Done button closes the application
    observeEvent(input$done, {
      stopApp()
    })
  }
  runGadget(ui, server)
}