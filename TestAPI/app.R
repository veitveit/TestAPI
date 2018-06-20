#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

  library(shiny)
  library(jsonlite)
  
  jscode <- '
window.addEventListener("message", displayMessage, false);
function displayMessage(evt) { console.log(evt.data); Shiny.onInputChange("data", evt.data);}
$(document).on("shiny:connected", function(event) {
  var objects = [1, 2, 3, 4];  
Shiny.onInputChange("data", objects);
Shiny.onInputChange("dim", 2);
Shiny.onInputChange("num",5);
});
'
  
  ui <- fluidPage(
    tags$script(jscode),
    textOutput("messageTest"),
    sliderInput("num","",0,10,2,1)
  )
  
  server <- function(input, output, session) {
    observe({
      dat <- input$data
      # dat <- unlist(lapply(dat,function(x) ifelse(length(x)>0,x,NULL)))
      #print((dat)*2)
      
      
      # print(matrix(as.vector(dat),ncol=2,byrow=T))
      
      # cat(matrix(input$data,ncol=input$dim))
      output$messageTest <- renderText (print(dat))
      
    })
    
    

  }
  
  shinyApp(ui = ui, server = server)
  # Application title
  
