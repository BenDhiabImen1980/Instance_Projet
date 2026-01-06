
# Objectif : Nettoyage des données


# Supprimer les colonnes inutiles
cols_to_remove <- c(
  "ID Dem. Tom",
  "Client",
  "Identifiant client",
  "Contact",
  "Réf Sys Source Tom",
  "Adresse",
  "Equipe",
  "Position d'instance",
  "Type Motif",
  "Réf. WF",
  "Motif de modification",
  "Commentaire"
)

data_clean <- data[, !(colnames(data) %in% cols_to_remove)]

# Vérification
str(data_clean)
