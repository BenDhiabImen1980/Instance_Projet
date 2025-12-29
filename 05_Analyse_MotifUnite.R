library(ggplot2)
library(dplyr)

# Gestion robuste du nom de colonne (pour WebR et local)
col_name <- if("Unité Traitante" %in% names(data_clean)) {
  "Unité Traitante"
} else {
  "Unité.Traitante"
}

# Préparation des données par Unité Traitante
stats_par_unite <- data_clean %>%
  rename(Unite = !!sym(col_name)) %>%
  group_by(Unite, Motif) %>%
  summarise(Nombre = n(), .groups = "drop") %>%
  group_by(Unite) %>%
  mutate(Pourcentage_Unite = round(Nombre / sum(Nombre) * 100, 1)) %>%
  ungroup()

# Diagramme en barres empilées
p_barres_empilees <- ggplot(
  stats_par_unite,
  aes(x = Unite, y = Nombre, fill = Motif)
) +
  geom_bar(stat = "identity") +
  labs(
    title = "Répartition des motifs par unité traitante",
    subtitle = "Indicateur de charge par unité",
    x = "Unité traitante",
    y = "Nombre d'instances",
    fill = "Motif"
  ) +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5)
  )

# Affichage
print(p_barres_empilees)