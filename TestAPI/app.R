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
Shiny.setInputValue("data", inmessage.exprmatr);
Shiny.setInputValue("numcond", inmessage.numcond);
Shiny.setInputValue("numrep", inmessage.numrep);

}
$(document).on("shiny:connected", function(event) {
  var objects = [1, 2, 3, 4,2,1,2,3,3,4,3,2];  
Shiny.setInputValue("data", objects);
Shiny.setInputValue("numcond", 2);
Shiny.setInputValue("numrep", 2);
});
'
  
  ui <- fluidPage(
    tags$script(jscode),
    textOutput("messageTest"),
    sliderInput("num","",0,10,2,1),
    actionButton("run","Run analysis")
  )
  
  server <- function(input, output, session) {
    dat <- NULL
    observe({
      print(input$data)
      if (!is.null(input$data)) {
      tdat <- matrix(as.vector(input$data),byrow = T, ncol=input$numrep*input$numcond+1)
      print(dim(tdat))
      dat <- matrix(as.numeric(tdat[,2:ncol(tdat)]),ncol=input$numrep*input$numcond, 
                    dimnames = list(rows=tdat[,1], cols=paste(paste("C",rep(1:input$numcond, input$numrep),
                                                                    "R", rep(1:input$numrep, each=input$numcond)))))
      

            # dat <- unlist(lapply(dat,function(x) ifelse(length(x)>0,x,NULL)))
      #print((dat)*2)
      
      
      # print(matrix(as.vector(dat),ncol=2,byrow=T))
      
      # cat(matrix(input$data,ncol=input$dim))
      output$messageTest <- renderText (print("read message"))
      }
      
    })
    
    observeEvent(input$run,{
      output$messageTest <- renderText (print(dat))
      
    })
    
    

  }
  
  shinyApp(ui = ui, server = server)
  # Application title
  
