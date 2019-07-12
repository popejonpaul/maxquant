library(shiny)
library(seqinr)
library(tidyverse)

fasta <- read.fasta("toy_data/uniprot-proteome_UP000002494+reviewed_yes.fasta",
                    seqtype = "AA")
fasta_names <- getName(fasta)


protein_groups <- read_tsv("toy_data/proteinGroups.txt", guess_max = 20000) %>%
  {set_names(., gsub(" ", "_", names(.)))}

peptides <- read_tsv("toy_data/peptides_truncated.txt", guess_max = 20000) %>%
  {set_names(., gsub(" ", "_", names(.)))}



f1 <- function(x1){
  getSequence(fasta[str_detect(fasta_names, x1)],as.string=TRUE)[[1]][[1]]
}
f2 <- function(x2){
  Uniprotid <- x2
  
  filtered_list <- protein_groups %>%
    filter(str_detect(Protein_IDs, Uniprotid)) 
  
  filpepids <- filtered_list$Peptide_IDs
  
  peptide_ids <- filpepids %>%
    strsplit(';') %>%
    .[[1]] %>%
    as.integer()
  
  filtered_peptides <- peptides %>%
    filter(id %in% peptide_ids)
  protein_Seq <- f1(Uniprotid)
  
  filtered_peptides$Sequence
}

ui <- fluidPage(
  pageWithSidebar(
    headerPanel('MaxQuant Sequence Generator'),
    sidebarPanel(
      fileInput("Fasta", "Fasta file:"),
      fileInput("ProteinGroups", "Protein groups file:"),
      textInput("UniprotID", "Uniprot ID")
    ),
    mainPanel(
      textOutput("plot"),
      dataTableOutput('plot1'),
      textOutput("plot2"),
      #textOutput("plot4"),
      tableOutput("plot3")
      
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderText("Use ctrl+f to search and highlight peptides")
  output$plot1 <- renderDataTable({
    protein_file <- input$ProteinGroups
    read_tsv(protein_file$datapath, guess_max = 20000) %>%
      {set_names(., gsub(" ", "_", names(.)))}
  })
  
  output$plot2 <- renderText({
    f1(input$UniprotID)
    })
  #output$plot4 <- renderText({#todo replace pepmatches with blanks
    #peptide_sequences <- f2(input$UniprotID)
    #str_replace(f1(input$UniprotID),peptide_sequences," ")
  #})
  
  output$plot3 <- renderTable({
    peptide_sequences <- f2(input$UniprotID)
    matchesloc <- str_locate_all(protein_Seq, peptide_sequences)
    
    newvar <- do.call(rbind, matchesloc) %>%
      as_tibble %>%
      mutate(Sequence = peptide_sequences)
    newvar
  })
}
shinyApp(ui, server)