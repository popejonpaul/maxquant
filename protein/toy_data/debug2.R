

Uniprotid <- input$UniprotID
#For debugging
Uniprotid <- "Q9R0L4"
    
    filtered_list <- protein_groups %>%
      filter(str_detect(Protein_IDs, Uniprotid)) 
    
    filpepids <- filtered_list$Peptide_IDs
    
    peptide_ids <- filpepids %>%
      strsplit(';') %>%
      .[[1]] %>%
      as.integer()
    
    filtered_peptides <- peptides %>%
      filter(id %in% peptide_ids)
    
    peptide_sequences <- filtered_peptides$Sequence
  protein_Seq <- f1(Uniprotid)
  protein_Seq
    str_subset(protein_Seq, peptide_sequences[1])
    
    str_length(protein_Seq)
    matchesloc <- str_locate_all(protein_Seq, peptide_sequences)
    matchesloc[[1]][1,][2] #extract start of seq match
    matchesloc[[1]][1,][1]#goal to make bars length of each sequence
    newvar1 <- matchesloc[[1]][1,][2]-matchesloc[[1]][1,][1]#seqlen
    newvar1+1
    peptide_sequences[1]
    
    newvar <- do.call(rbind, matchesloc) %>%
      as_tibble %>%
      mutate(Sequence = peptide_sequences)
    newvar
    select(newvar,.data$start)