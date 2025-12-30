
library(ggplot2)
library(dplyr)

# Top 5 offres avec leur motif dominant
offre_motif <- data_clean %>%
  group_by(Offre, Motif) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Offre) %>%
  slice_max(n, n = 1) %>%
  arrange(desc(n)) %>%
  head(5)

# Graphique
hist <- ggplot(offre_motif, aes(x = reorder(Offre, n), y = n, fill = Motif)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Top 5 offres et leur motif principal",
    x = "Type d'offre",
    y = "Nombre d'instances",
    fill = "Motif dominant"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )
