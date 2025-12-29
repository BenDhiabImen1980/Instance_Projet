library(ggplot2)
library(dplyr)

# Gestion robuste du nom de colonne
col_name <- if("Date Etat OT" %in% names(data_clean)) {
  "Date Etat OT"
} else {
  "Date.Etat.OT"
}

# Préparation : extraire le mois
data_clean <- data_clean %>%
  mutate(
    Date_Clean = as.Date(!!sym(col_name)),
    Mois_Num = as.numeric(format(Date_Clean, "%m")),  # Numéro du mois
    Mois_Nom = format(Date_Clean, "%B")               # Nom du mois
  )

# Compter les instances par mois
evolution_mensuelle <- data_clean %>%
  group_by(Mois_Num, Mois_Nom) %>%
  summarise(n = n(), .groups = "drop") %>%
  arrange(Mois_Num)  # Trier par numéro de mois

# Créer un facteur ordonné pour garantir l'ordre d'affichage
evolution_mensuelle <- evolution_mensuelle %>%
  mutate(Mois_Nom = factor(Mois_Nom, levels = Mois_Nom))

# Histogramme avec mois ordonnés
hist<- ggplot(evolution_mensuelle, aes(x = Mois_Nom, y = n, fill = n)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(
    title = "Nombre d'instances par mois en 2025",
    x = "Mois",
    y = "Nombre d'instances"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "none"
  )
print(hist)