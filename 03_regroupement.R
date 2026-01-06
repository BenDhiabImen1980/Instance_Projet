
unique(data_clean$Motif)
library(dplyr)
library(stringr)

data_clean <- data_clean %>%
  mutate(
    Motif = str_trim(Motif),              # supprime espaces début/fin
    Motif = str_squish(Motif)             # supprime espaces multiples
  )





data_clean <- data_clean %>%
  mutate(
    Motif = case_when(
      
      # Manque équipement
      Motif %in% c(
        "Immeuble non équipé",
        "Immeuble ou lotissement non équipé",
        "Immeuble ou lotissement non raccordé"
      ) ~ "Manque équipement",
      
      # Non Éligible
      Motif %in% c(
        "Le type carte n'est pas eligible",
        "Nécessite correction port POTS et/ou DATA",
        "Non réalisable suite fausse étude ( éligibilité)"
      ) ~ "Non Éligible",
      
      # Manque d'information
      Motif %in% c(
        "Précision Adresse / manque informations",
        "Précision d’adresse / position géographique incorrect",
        "Necessite visite sur place: prise de RDV"
      ) ~ "Manque d'information",
      
      # Saturation
      Motif %in% c(
        "Saturation central/équipements suite port defectueux",
        "Saturation central/MSAN",
        "Saturation central/MSAN suite reservation incorrecte ou port defectueux",
        "Saturation distribution suite paire mauvaise ou reservation incorrecte",
        "Saturation distribution",
        "Saturation transport suite paire mauvaise ou resrvation incorrecte",
        "Saturation transport",
        "Saturation: Extension en cours",
        "Zone non couverte par réseau RLA"
      ) ~ "Saturation",
      
      # Manque Autorisation
      Motif %in% c(
        "Problème autorisation de travaux",
        "Problème autorisation d'accès"
        
      ) ~ "Manque Autorisation",
      
      # Manque de couverture
      Motif %in% c(
        "pas de couverture ADSL distance",
        "pas de couverture VDSL distance",
        "pas de couverture VDSL port",
        "VDSL: débit < demande client"
      ) ~ "Manque de couverture",
      
      TRUE ~ Motif
    )
  )

# Transformer en facteur
data_clean$Motif <- as.factor(data_clean$Motif)

# Vérif
#levels(data_clean$Motif)
table(data_clean$Motif)
unique(data_clean$Motif) 

#Sauvegarder 
write.csv(
  data_clean,
  "data/clean/instances_clean_v1.csv",
  row.names = FALSE
)


