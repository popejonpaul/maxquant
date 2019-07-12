library(tidyverse)

a <- "MEPAAGSSMEPSADWLATAAARGRVEEVRALLEAGALPNAPNSYGRRPIQVMMMGSARVAELLLLHGAEPNCADPATLTRPVHDAAREGFLDTLVVLHRAGARLDVRDAWGRLPVDLAEELGHRDVARYLRAAAGGTRGSNHARIDAAEGPSDIPD"

a2 <- gsub("(.{10})", "\\1 ", a) %>%
  str_split(" ") %>%
  unlist() %>%
  as_tibble() %>%
  set_names("Sequence") %>%
  mutate(Chunk = rownames(.))

a2 %>%
  write_csv("Peptide.csv")