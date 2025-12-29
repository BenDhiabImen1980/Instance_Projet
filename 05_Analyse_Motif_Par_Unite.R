library(ggplot2)
library(dplyr)

# 1. Convertir Unité Traitante en facteur
data_clean$`Unité Traitante` <- as.factor(data_clean$`Unité Traitante`)


# 2. Préparation des données par Unité Traitante
stats_par_unite <- data_clean %>%
  group_by(`Unité Traitante`, Motif) %>%
  summarise(Nombre = n(), .groups = 'drop') %>%
  group_by(`Unité Traitante`) %>%
  mutate(
    Pourcentage_Unite = round(Nombre / sum(Nombre) * 100, 1),
    Total_Unite = sum(Nombre)
  ) %>%
  ungroup()


# 4. Création du diagramme en barres empilées (SANS NOMBRES)
cat("\n\n=== CRÉATION DU DIAGRAMME EN BARRES EMPILÉES ===\n")

p_barres_empilees <- ggplot(stats_par_unite, 
                            aes(x = `Unité Traitante`, y = Nombre, fill = Motif)) +
  geom_bar(stat = "identity", position = "stack") +
  # SUPPRIMÉ: geom_text(aes(label = Nombre), ...)
  labs(title = "Répartition des motifs par Unité Traitante",
       subtitle = "Vue empilée - Effectifs absolus",
       x = "Unité Traitante",
       y = "Nombre d'instances",
       fill = "Motif") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    legend.position = "right",
    panel.grid.major.x = element_blank()
  )

# 5. Afficher le graphique
print(p_barres_empilees)

