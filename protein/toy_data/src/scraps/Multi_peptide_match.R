output$d3 <- renderD3({

})

#For debugging
#Uniprot_ID <- "A0JPM9"
Uniprot_ID <- input$UniprotID

peptide_sequences <- f2(Uniprot_ID)
protein_Seq <- f1(Uniprot_ID)
matchesloc <- str_locate_all(protein_Seq, peptide_sequences)

Sequence_df <- map2_df(matchesloc,
                       peptide_sequences,
                       ~ as.data.frame(.x) %>%
                         mutate(Sequence = .y)) %>%
  mutate(Sequence_length = (end - start) + 1)

test1 <- Sequence_df$Sequence_length / max(Sequence_df$Sequence_length)

r2d3(
  Sequence_df$Sequence_length,
  script = "d3.js"
)