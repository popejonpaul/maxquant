library(shiny)
library(r2d3)

ui <- fluidPage(
  h1("Press me", id = "text1"),
  sliderInput("slider1", "Random dependency", min = 0, max = 10, value = 5),
  textOutput("text2"),
  d3Output("d3")
)

server <- function(input, output) {
  output$d3 <- renderD3({
    a <- as.numeric(input$slider1)
    a2 <- read.csv("iris.csv")[,c(1:4)]
    a2$Key <- as.integer(rownames(a2)) * a
    r2d3(
      a2 * a,
      "scraps4.js"
    )
  })
  output$text2 <- renderText({
    input$slider1
  })
}

shinyApp(ui = ui, server = server)