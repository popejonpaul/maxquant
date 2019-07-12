library(shiny)
library(r2d3)

ui <- fluidPage(
  h1("Press me", id = "text1", onclick = "updateData()"),
  sliderInput("slider1", "Random dependency", min = 0, max = 10, value = 5),
  textOutput("text2"),
  d3Output("d3")
)

server <- function(input, output) {
  output$d3 <- renderD3({
    a <- input$slider1
    r2d3(
      read.csv("iris.csv"),
      "scraps3.js"
    )
  })
  output$text2 <- renderText({
    input$slider1
  })
}

shinyApp(ui = ui, server = server)