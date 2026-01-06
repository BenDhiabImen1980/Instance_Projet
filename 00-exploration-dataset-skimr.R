# Charger les packages
library(readxl)
library(skimr)
library(dplyr)

# Charger les données
data_brute <- read_excel("data/brute/instances.xls")

# ============================================
# INFORMATIONS ESSENTIELLES
# ============================================

cat("\n===== RÉSUMÉ DU DATASET =====\n\n")

# 1. Nombre de lignes et colonnes
cat("📊 Nombre de lignes      :", nrow(data_brute), "\n")
cat("📋 Nombre de colonnes    :", ncol(data_brute), "\n")

# 2. Nombre de colonnes numériques
nb_numeriques <- sum(sapply(data_brute, is.numeric))
cat("🔢 Colonnes numériques   :", nb_numeriques, "\n\n")

# 3. Colonnes avec valeurs manquantes
cat("❌ VALEURS MANQUANTES :\n")
valeurs_na <- colSums(is.na(data_brute))
colonnes_avec_na <- valeurs_na[valeurs_na > 0]

if (length(colonnes_avec_na) > 0) {
  na_df <- data.frame(
    Colonne = names(colonnes_avec_na),
    Valeurs_manquantes = as.numeric(colonnes_avec_na)
  )
  print(na_df, row.names = FALSE)
} else {
  cat("   ✅ Aucune valeur manquante\n")
}

# 4. Outliers par colonne
cat("\n⚠️  OUTLIERS PAR COLONNE :\n")

# Sélectionner uniquement les colonnes numériques
cols_numeriques <- names(data_brute)[sapply(data_brute, is.numeric)]

if (length(cols_numeriques) > 0) {
  outliers_list <- list()
  
  for (col in cols_numeriques) {
    x <- data_brute[[col]]
    q1 <- quantile(x, 0.25, na.rm = TRUE)
    q3 <- quantile(x, 0.75, na.rm = TRUE)
    iqr <- q3 - q1
    lower <- q1 - 1.5 * iqr
    upper <- q3 + 1.5 * iqr
    nb_outliers <- sum(x < lower | x > upper, na.rm = TRUE)
    outliers_list[[col]] <- nb_outliers
  }
  
  outliers_df <- data.frame(
    Colonne = names(outliers_list),
    Outliers = unlist(outliers_list)
  )
  print(outliers_df, row.names = FALSE)
} else {
  cat("   ✅ Aucune colonne numérique\n")
}

# 5. Lignes dupliquées
nb_duplicates <- sum(duplicated(data_brute))
cat("\n🔁 Lignes dupliquées     :", nb_duplicates, "\n")

cat("\n=============================\n\n")

# Afficher le résumé complet avec skim
cat("===== RÉSUMÉ DÉTAILLÉ AVEC SKIM =====\n\n")
print(skim(data_brute))