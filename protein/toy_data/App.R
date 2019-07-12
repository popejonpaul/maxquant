library(shiny)
library(seqinr)
library(tidyverse)
library(r2d3)
#r2d3(data=c(0.3, 0.6, 0.8, 0.95, 0.40, 0.20), script = "d3.js")

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
  
  filtered_peptides$Sequence
}
f3 <- function(x){
  peptide_sequences <- f2(x)
  protein_Seq <- f1(x)
  matchesloc <- str_locate_all(protein_Seq, peptide_sequences)
  
  newvar <- do.call(rbind, matchesloc) %>%
    as_tibble %>%
    mutate(Sequence = peptide_sequences)
  newvar
}

ui <- fluidPage(
  pageWithSidebar(
    headerPanel('MaxQuant Sequence Generator'),
    sidebarPanel(
      fileInput("Fasta", "Fasta file:"),
      fileInput("ProteinGroups", "Protein groups file:"),
      fileInput("Peptides","Peptides file:"),
      textInput("UniprotID", "Uniprot ID",
                value = "P11517"),
      selectizeInput("TestInput", "Testing",
                     choices = protein_groups$Fasta_headers,
                     multiple = TRUE)
    ),
    mainPanel(
      textOutput("plot"),
      dataTableOutput('plot1'),
      dataTableOutput('plot4'),
      textOutput("plot2"),
      textOutput("plot5"),
      tableOutput("plot3"),
      verbatimTextOutput("selected"),
      d3Output("d3")
    )
  )
)
server <- function(input, output, session) {
  output$plot <- renderText("Use ctrl+F to search peptides")
  
  output$plot2 <- renderText({
    Uniprot_ID <- input$UniprotID

    peptide_sequences <- f2(Uniprot_ID)
    protein_Seq <- f1(Uniprot_ID)
    
   paste0("Protein sequence followed by peptides:",
          protein_Seq,
          paste0(peptide_sequences, collapse = " "))
  
   
   
    })
output$plot5 <- renderText({
  req(input$UniprotID)
  Uniprot_ID <- input$UniprotID
  
  filtered_list <- protein_groups %>%
    filter(str_detect(Protein_IDs, Uniprot_ID))
  paste0("Sequence coverage is ",
         filtered_list$`Sequence_coverage_[%]`,
         "%. ","Unique + razor sequence coverage is ",
         filtered_list$`Unique_+_razor_sequence_coverage_[%]`,"%")
  
})
  peptide_file <- reactive({
    req(input$Peptides)
    protein_file <- input$Peptides
    read_tsv(protein_file$datapath, guess_max = 20000) %>%
      {set_names(., gsub(" ", "_", names(.)))}
  })
  protein_file <- reactive({
    req(input$ProteinGroups)
    protein_file <- input$ProteinGroups
    read_tsv(protein_file$datapath, guess_max = 20000) %>%
      {set_names(., gsub(" ", "_", names(.)))}
  })

  output$plot1 <- renderDataTable({
    protein_file()
  })
  output$plot4 <- renderDataTable({
    peptide_file()
  })
  
  output$plot3 <- renderTable({
    f3(input$UniprotID)
  })
  output$d3 <- renderD3({
    #For debugging
    #Uniprot_ID <- "A0JPM9"
    req(input$UniprotID)
    Uniprot_ID <- input$UniprotID

    peptide_sequences <- f2(Uniprot_ID)
    protein_Seq <- f1(Uniprot_ID)

    seqdata <- c(protein_Seq, peptide_sequences)

    r2d3(
      seqdata,
      script = "Plot_peptide2_updated.js"
    )
})
output$selected <- renderText({
  bar_number <- as.numeric(req(input$bar_clicked))
  if (bar_number > 0) bar_number
})
}
shinyApp(ui, server)