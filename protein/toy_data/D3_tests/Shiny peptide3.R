library(shiny)
library(tidyverse)
library(r2d3)


a <- c(
  'MAAAAAAAAGDSDSWDADTFSMEDPVRKVAGGGTAGGDRWEGEDEDEDVKDNWDDDDDENKEEAEVKPEVKISEKKKIAEKIKEKERQQKKRQEEIKKRLEEPEESKVLTPEEQLADKLRLKKLQEESDLELAKETFGVNNTVYGIDAMNPSSRDDFTEFGKLLKDKITQYEKSLYYASFLEALVRDVCISLEIDDLKKITNSLTVLCSEKQKQEKQSKAKKKKKGVVPGGGLKATMKDDLADYGGYDGGYVQDYEDFM',
  'AAAAAAAAGDSDSWDADTFSMEDPVRK',
  'DDFTEFGK',
  'GVVPGGGLK',
  'ITNSLTVLCSEK',
  'LEEPEESK',
  'LQEESDLELAK',
  'RLEEPEESK'
)

ui <- fluidPage(
  h1("Press me", id = "text1"),
  sliderInput("slider1", "Random dependency", min = 0, max = 10, value = 5),
  textInput("Peptide", "Peptide sequence:"),
  textOutput("text2"),
  d3Output("d3")
)

server <- function(input, output) {
  output$d3 <- renderD3({
    r2d3(
      "Plot_peptide2.js",
      data = a
    )
  })
  output$text2 <- renderText({
    a
  })
}

shinyApp(ui = ui, server = server)