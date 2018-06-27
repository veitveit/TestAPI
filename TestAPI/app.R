# This is a shiny app template to test api requests that open the app with preset parameter values
# TODO: check how to run button
# TODO: return output files via message?

  library(shiny)
  library(jsonlite)
  
  jscode <- '
window.addEventListener("message", displayMessage, false);
function displayMessage(evt) { 
console.log(evt.data)
var inmessage = JSON.parse(evt.data);
console.log(inmessage); 
Shiny.onInputChange("data", inmessage.exprmatr);
}
$(document).on("shiny:connected", function(event) {
  var objects = [1, 2, 3, 4];  
Shiny.setInputValue("data", objects);
Shiny.setInputValue("dim", 2);
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
  
