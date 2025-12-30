library(ggplot2)
library(dplyr)

# Compter les instances par type d'offre
instances_par_offre <- data_clean %>%
  count(Offre, sort = TRUE)


# Préparer les données
top_offres <- data_clean %>%
  count(Offre, sort = TRUE) %>%
  mutate(Pourcentage = round(n / sum(n) * 100, 1)) %>%
  head(5)

# Graphique moderne
hist <- ggplot(top_offres, aes(x = reorder(Offre, n), y = n)) +
  geom_col(aes(fill = n), show.legend = FALSE) +
  geom_text(aes(label = paste0(n, " (", Pourcentage, "%)")), 
            hjust = -0.1, size = 4, fontface = "bold") +
  coord_flip() +
  scale_fill_gradient(low = "lightcoral", high = "darkred") +
  labs(
    title = "Top 5 des offres les plus demandées",
    x = "",
    y = "Nombre d'instances"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.text.y = element_text(size = 11, face ="bold"),
    panel.grid.major.y = element_blank()
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15)))
print(hist)


