library(ggplot2)

top_offres <- data_clean %>%
  count(Offre, sort = TRUE) %>%
  mutate(Pourcentage = round(n / sum(n) * 100, 1)) %>%
  head(5)

# Graphique type "lollipop"
ggplot(top_offres, aes(x = reorder(Offre, n), y = n)) +
  geom_segment(aes(x = reorder(Offre, n), xend = reorder(Offre, n), 
                   y = 0, yend = n), 
               color = "#457B9D", size = 1.5) +
  geom_point(aes(size = n, color = n), show.legend = FALSE) +
  geom_text(aes(label = paste0(Pourcentage, "%")), 
            hjust = -0.5, size = 4, fontface = "bold") +
  coord_flip() +
  scale_color_gradient(low = "#A8DADC", high = "#1D3557") +
  scale_size_continuous(range = c(8, 15)) +
  labs(
    title = "Top 5 des offres générant le plus d'instances",
    x = "",
    y = "Nombre d'instances"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.text.y = element_text(size = 11, face = "bold"),
    panel.grid.major.y = element_blank()
  )