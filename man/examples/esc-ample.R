library(shiny)
library(esckey)

ui <- fluidPage(
  "Hit Esc to browse",
    numericInput("num",
                 label = "Number",
                 value = 2),
    textInput("text",
              "Text",
              value = "Placeholder"),
 escUI()
)
server <- function(input, output, session) {
  foo <- "bar"
  escServer(i = input,
            o = output,
            foo = foo)
}

shinyApp(ui, server)
