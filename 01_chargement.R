
# Charger le package
library(readxl)

# Charger les données brutes
data_brute <- read_excel("data/brute/instances.xls")

# Vérification
str(data_brute)
head(data_brute)

# Dimensions (nombre de lignes et colonnes)
dim(data_brute)
nrow(data_brute)  # Nombre de lignes
ncol(data_brute)  # Nombre de colonnes

# Noms des colonnes
names(data_brute)
colnames(data_brute)

# Type de chaque colonne
sapply(data_brute, class)

# Nombre de valeurs manquantes par colonne
colSums(is.na(data_brute))

# Nombre de lignes dupliquées
sum(duplicated(data_brute))