library(seqinr)
library(tidyverse)
library(gtools)

fasta <- read.fasta("toy_data/uniprot-proteome_UP000002494+reviewed_yes.fasta",
                    seqtype = "AA")

protein_groups <- read_tsv("toy_data/proteinGroups.txt", guess_max = 20000) %>%
  {set_names(., gsub(" ", "_", names(.)))}

peptides <- read_tsv("toy_data/peptides_truncated.txt", guess_max = 20000) %>%
  {set_names(., gsub(" ", "_", names(.)))}

names(protein_groups)

fasta[1]
class(fasta[1])
getSequence(fasta[1], as.string=TRUE)[[1]][[1]]

attr(fasta[1])
attributes(fasta)

for (i in seq_along(fasta)){
  #print(fasta[i])
  id <- substr()
}

fasta_names <- getName(fasta)
fasta_names

str_extract()

seq_along(fasta)

str_detect(fasta_names, "D3ZWK4")
fasta[str_detect(fasta_names, "D3ZWK4")]
#onclick with uniprotID as input          "UniprotID"
getSequence(fasta[str_detect(fasta_names, "D3ZWK4")],as.string=TRUE)

f1 <- function(x1){
  getSequence(fasta[str_detect(fasta_names, x1)],as.string=TRUE)[[1]][[1]]
}

f1("Q64598")
a

protein_groups %>%
  filter(str_detect(Protein_IDs, "Q64598")) %>%
  select(Protein_IDs, Peptide_IDs) %>%
  View()



filtered_list <- protein_groups %>%
  filter(str_detect(Protein_IDs, "Q64598"))# %>%
  #select(Protein_IDs, Peptide_IDs)

c(filtered_list$Peptide_IDs %>%
strsplit(';')) %in% c(peptide_groups %>%
  select(id))


peptide_ids <- filtered_list$Peptide_IDs %>%
  strsplit(';') %>%
  .[[1]] %>%
  as.integer()

filtered_peptides <- peptides %>%
  filter(id %in% peptide_ids)

peptide_sequences <- filtered_peptides$Sequence
protein_Seq <- f1("Q64598")

peptide_sequences
peptide_sequences[1]

str_subset(protein_Seq, peptide_sequences[1])

str_length(protein_Seq)
matchesloc <- str_locate_all(protein_Seq, peptide_sequences)

do.call(rbind, matchesloc) %>%
  as_tibble %>%
  mutate(Sequence = peptide_sequences)

indexed_protein_sequence <- gsub("(.{10})", "\\1 ", protein_Seq) %>%
  str_split(" ")

indexed_protein_sequence

tib <- do.call(rbind, indexed_protein_sequence)%>%
  as.tibble

plot(0,0,type='n',xlim=NULL,ylim=NULL,tib)
warnings()
unlist(matchesloc)
str_extract_all(protein_Seq, peptide_sequences)
str_length(str_replace(protein_Seq, peptide_sequences,""))
plot(-1:1,-1:1,type='n',frame.plot=F,axes=F,xlab="",ylab="")
plot(indexed_protein_sequence)
names(indexed_protein_sequence)
text(0,y=NULL,indexed_protein_sequence)
text(0, y = NULL, labels = seq_along(indexed_protein_sequence), adj = NULL,
     pos = NULL, offset = 0.5, vfont = NULL,
     cex = 1, col = NULL, font = NULL)
text(5.8,1,"Red",col='red',font=2)
text(6.3,1,"looks.")
demo(graphics)
plot(-1:1, -1:1, type = "n", xlab = "Re", ylab = "Im")
K <- 16; text(exp(1i * 2 * pi * (1:K) / K), col = 2)

## The following two examples use latin1 characters: these may not
## appear correctly (or be omitted entirely).
plot(1:10, 1:10, main = "text(...) examples\n~~~~~~~~~~~~~~",
     sub = "R is GNU ©, but not ® ...")
mtext("«Latin-1 accented chars»: éè øØ å<Å æ<Æ", side = 3)
points(c(6,2), c(2,1), pch = 3, cex = 4, col = "red")
text(6, 2, "the text is CENTERED around (x,y) = (6,2) by default",
     cex = .8)
text(2, 1, "or Left/Bottom - JUSTIFIED at (2,1) by 'adj = c(0,0)'",
     adj = c(0,0))
text(4, 9, expression(hat(beta) == (X^t * X)^{-1} * X^t * y))
text(4, 8.4, "expression(hat(beta) == (X^t * X)^{-1} * X^t * y)",
     cex = .75)
text(4, 7, expression(bar(x) == sum(frac(x[i], n), i==1, n)))

## Two more latin1 examples
text(5, 10.2,
     "Le français, c'est façile: Règles, Liberté, Egalité, Fraternité...")
text(5, 9.8,
     "Jetz no chli züritüütsch: (noch ein bißchen Zürcher deutsch)")
plot(1:500, 1:500, type = "n", xlab = "bot", ylab = "side")
#text(50,25,indexed_protein_sequence)
textplot(temptext1, valign="center", cex=0.8, halign= "left", mar=c(0,0,0,0), col=2)
indexed_protein_sequence
#text(5, y = 50, labels = indexed_protein_sequence, adj = 0,
 #    pos = NULL, offset = 0.5, vfont = NULL,
  #   cex = 1, col = 3, font = NULL)



