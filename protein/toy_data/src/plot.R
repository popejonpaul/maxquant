plot(1:500, 1:500, type = "n", xlab = "bot", ylab = "side")
#text(50,25,indexed_protein_sequence)
#textplot(temptext1, valign="center", cex=0.8, halign= "left", mar=c(0,0,0,0), col=2)
indexed_protein_sequence
#text(5, y = 50, labels = indexed_protein_sequence, adj = 0,
 #    pos = NULL, offset = 0.5, vfont = NULL,
  #   cex = 1, col = 3, font = NULL)


x_coordinates <- rep(seq(0, 400, 100), 8)

f1_a <- function(x) map(x, ~rep(.x, 5))
y_coordinates <- unlist(f1_a(seq(500, 0, -70)))
label_values <- indexed_protein_sequence[[1]]


plot(1:500, 1:500, type = "n")
text(x = x_coordinates, y = y_coordinates, labels = label_values, adj = 0,
     pos = NULL, vfont = NULL,
     cex = .7,  font = NULL,col=3)

ggplot() +
  geom_text(aes(x = x_coordinates, y = y_coordinates, label = label_values), size = 3) +
  theme_void()