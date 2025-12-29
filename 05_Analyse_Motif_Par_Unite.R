#| echo: false

library(ggplot2)
library(dplyr)


# 2️⃣ Préparer les données par Unité Traitante

stats_par_unite <- data_clean %>%
  group_by(`Unité Traitante`, Motif) %>%
  summarise(Nombre = n(), .groups = 'drop') %>%
  group_by(`Unité Traitante`) %>%
  mutate(Pourcentage_Unite = round(Nombre / sum(Nombre) * 100, 1)) %>%
  ungroup()

# 3️⃣ Créer le diagramme en barres empilées

p_barres_empilees <- ggplot(stats_par_unite,
                            aes(x = `Unité Traitante`, y = Nombre, fill = Motif)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Répartition des motifs par Unité Traitante",
       subtitle = paste("Total :", sum(stats_par_unite$Nombre), "observations"),
       x = "Unité Traitante",
       y = "Nombre d'instances",
       fill = "Motif") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
        plot.subtitle = element_text(hjust = 0.5))

# 4️⃣ Afficher le graphique

print(p_barres_empilees)
