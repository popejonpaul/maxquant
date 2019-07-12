library(seqinr)
library(tidyverse)
library(gtools)

fasta <- read.fasta("toy_data/uniprot-proteome_UP000002494+reviewed_yes.fasta",
                    seqtype = "AA")

protein_groups <- read_tsv("toy_data/proteinGroups.txt", guess_max = 20000) %>%
  {set_names(., gsub(" ", "_", names(.)))}

peptides <- read_tsv("toy_data/peptides_truncated.txt", guess_max = 20000) %>%
  {set_names(., gsub(" ", "_", names(.)))}

fasta_names <- getName(fasta)

f1 <- function(x1){
  getSequence(fasta[str_detect(fasta_names, x1)],as.string=TRUE)[[1]][[1]]
}
x2
#f2 <- function(x2){
  protein_groups %>%
    filter(str_detect(Protein_IDs, x2)) %>%
    select(Protein_IDs, Peptide_IDs)
  
  filtered_list <- protein_groups %>%
    filter(str_detect(Protein_IDs, x2)) 
  
  peptide_ids <- filtered_list$Peptide_IDs %>%
    strsplit(';') %>%
    .[[1]] %>%
    as.integer()
  
  filtered_peptides <- peptides %>%
    filter(id %in% peptide_ids)
  
  peptide_sequences <- filtered_peptides$Sequence
  str_subset(protein_Seq, peptide_sequences[1])
  
  str_length(protein_Seq)
  matchesloc <- str_locate_all(protein_Seq, peptide_sequences)
  
  do.call(rbind, matchesloc) %>%
    as_tibble %>%
    mutate(Sequence = peptide_sequences)
#}
f1("F1LMZ8")
f2("F1LMZ8")