
library(ggplot2)

# Compter le nombre d'occurrences par motif
stats_motif <- as.data.frame(table(data_clean$Motif))
colnames(stats_motif) <- c("Motif", "Nombre")

# Calculer les pourcentages
stats_motif$Pourcentage <- round(stats_motif$Nombre / sum(stats_motif$Nombre) * 100, 1)

# Trier par nombre décroissant 
stats_motif <- stats_motif[order(-stats_motif$Nombre), ]

# Identifier la partie dominante (première ligne après tri)
motif_dominant <- stats_motif$Motif[1]
pourcentage_dominant <- stats_motif$Pourcentage[1]

# Créer une colonne pour la légende avec tous les pourcentages
stats_motif$Motif_Legende <- paste0(stats_motif$Motif, " (", stats_motif$Pourcentage, "%)")

# Afficher un résumé dans la console
cat("=== RÉSUMÉ DES 6 CATÉGORIES DE MOTIF ===\n")
print(stats_motif[, c("Motif", "Nombre", "Pourcentage")])
cat("\nTotal des observations:", sum(stats_motif$Nombre), "\n")
cat("Motif dominant:", motif_dominant, "(", pourcentage_dominant, "%)\n")

# Créer le camembert
camembert <- ggplot(stats_motif, aes(x = "", y = Pourcentage, fill = Motif_Legende)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  
  # Ajouter SEULEMENT le pourcentage dominant sur le graphique
  geom_text(aes(label = ifelse(Motif == motif_dominant, 
                               paste0(Pourcentage, "%"), 
                               "")),
            position = position_stack(vjust = 0.5),
            size = 6, fontface = "bold", color = "white") +
  
  # Personnalisation des couleurs et du titre
  scale_fill_brewer(palette = "Set3") +
  labs(title = "Répartition des motifs d'instances",
       subtitle = paste("Total:", sum(stats_motif$Nombre), "observations"),
       fill = "Motifs (Pourcentage)") +  # Titre de la légende
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12),
        legend.position = "right",
        legend.title = element_text(face = "bold", size = 11),
        legend.text = element_text(size = 10))

# Afficher le graphique
print(camembert)

# Option : Sauvegarder l'image
# ggsave("camembert_motifs.png", camembert, width = 11, height = 8, dpi = 300)
# cat("\nGraphique sauvegardé sous 'camembert_motifs.png'\n")