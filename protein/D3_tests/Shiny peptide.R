library(shiny)
library(tidyverse)
library(r2d3)

ui <- fluidPage(
  h1("Press me", id = "text1"),
  sliderInput("slider1", "Random dependency", min = 0, max = 10, value = 5),
  textInput("Peptide", "Peptide sequence:"),
  textOutput("text2"),
  d3Output("d3")
)

server <- function(input, output) {
  output$d3 <- renderD3({
    #a <- "MEPAAGSSMEPSADWLATAAARGRVEEVRALLEAGALPNAPNSYGRRPIQVMMMGSARVAELLLLHGAEPNCADPATLTRPVHDAAREGFLDTLVVLHRAGARLDVRDAWGRLPVDLAEELGHRDVARYLRAAAGGTRGSNHARIDAAEGPSDIPD"
    a <- as.character(input$Peptide)
    a2 <- gsub("(.{10})", "\\1 ", a) %>%
      str_split(" ") %>%
      unlist() %>%
      as_tibble() %>%
      set_names("Sequence") %>%
      mutate(Chunk = rownames(.))
    
    a <- read_csv("Peptide.csv")
    r2d3(
      "Plot_peptide2.js",
      data = a2
    )
  })
  output$text2 <- renderText({
    input$Peptide
  })
}

shinyApp(ui = ui, server = server)