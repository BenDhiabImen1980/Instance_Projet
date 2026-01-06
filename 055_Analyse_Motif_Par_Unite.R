library(ggplot2)
library(dplyr)

# 1. Convertir Unité Traitante en facteur
data_clean$`Unité Traitante` <- as.factor(data_clean$`Unité Traitante`)

# Vérifier les niveaux du facteur
cat("=== UNITÉS TRAITANTES DISPONIBLES ===\n")
print(levels(data_clean$`Unité Traitante`))
cat("\nNombre d'unités:", nlevels(data_clean$`Unité Traitante`), "\n\n")

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

# 3. Affichage des statistiques dans la console
cat("=== RÉPARTITION DES MOTIFS PAR UNITÉ TRAITANTE ===\n")
for(unite in levels(data_clean$`Unité Traitante`)) {
  donnees_unite <- stats_par_unite %>% filter(`Unité Traitante` == unite)
  if(nrow(donnees_unite) > 0) {
    cat("\n", paste0(rep("=", 50), collapse = ""), "\n")
    cat("UNITÉ:", unite, "\n")
    cat("Total instances:", sum(donnees_unite$Nombre), "\n")
    print(donnees_unite[, c("Motif", "Nombre", "Pourcentage_Unite")])
  }
}

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

# 6. SAUVEGARDE OPTIONNELLE
cat("\n\n=== SAUVEGARDE OPTIONNELLE ===\n")
dossier_save <- "analyse_unites_traitantes"
if(!dir.exists(dossier_save)) {
  dir.create(dossier_save)
  cat("Dossier créé:", dossier_save, "\n")
}

# Sauvegarde des données
write.csv(stats_par_unite, 
          file.path(dossier_save, "stats_motifs_par_unite.csv"),
          row.names = FALSE, fileEncoding = "UTF-8")

# Sauvegarde du graphique
ggsave(file.path(dossier_save, "barres_empilees.png"), 
       p_barres_empilees, width = 14, height = 8, dpi = 300)

cat("\n✅ Analyse terminée avec succès !\n")
cat("📁 Résultats sauvegardés dans le dossier :", dossier_save, "\n")
cat("   • stats_motifs_par_unite.csv - Tableau complet\n")
cat("   • barres_empilees.png       - Diagramme en barres empilées (sans nombres)\n")