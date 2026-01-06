Mini projet du module R

📊 Analyse des Instances des Fournisseurs Internet - Région de Sousse
📋 Description
Ce projet propose une analyse complète des demandes d'abonnement Internet en instance dans la région de Sousse pour l'année 2025. L'objectif est d'identifier les motifs récurrents de blocage, quantifier leur impact sur la qualité de service et fournir des données exploitables pour optimiser le processus de traitement des demandes.

🎯 Objectifs
Identifier les motifs récurrents de blocage des demandes d'abonnement
Quantifier leur impact sur la qualité de service
Analyser la charge par unité traitante
Examiner les tendances temporelles
Segmenter les instances par type d'offre
Fournir des recommandations stratégiques basées sur les données

📁 Structure du Projet
mini_projet/
├── Presentation/
│   ├── Ma-presentation.qmd             # Document Quarto principal (présentation RevealJS)
│   ├── essaie.qmd                      # Document de test
│   └── _extensions/                    # Extensions Quarto (WebR)
├── scripts/
│   ├── 00-exploration-dataset-skimr.R   # Exploration du dataset avec skimr
│    ├── 01_chargement.R                  # Exploration du dataset
│    ├── 02_removeCol                     # script de nettoyage 
│    ├── 03_regroupement                  # script de transformation
│   ├── 04_Analyse_Motif.R               # Analyse de distribution des motifs
│   ├── 05_Analyse_MotifUnite.R          # Analyse par unité traitante
│   ├── 06_Analyse_Temporelle.R          # Analyse des tendances temporelles
│   ├── 07_Analyse_Par_Offre.R           # Segmentation par type d'offre
│   └── 08_Analyse_Offre_Par_Motif.R     # Relation offre-motif
├── data/
│   └── brute
            instance.xls               # Données brutes (4723 enregistrements)
    └── clean
            instances_clean_v1.csv     # Données nettoyées
├── images/                              # Ressources visuelles
└── README.md                            # Ce fichier


🔧 Prérequis
Logiciels requis

R (version ≥ 4.0)
RStudio (recommandé)
Quarto (version ≥ 1.3)

Packages R nécessaires
rinstall.packages(c(
  "ggplot2",
  "dplyr",
  "plotly",
  "scales",
  "readr"
))


🚀 Installation et Utilisation
1. Cloner le repository
bashgit clone https://github.com/BenDhiabImen1980/Instance_Projet.git
cd Instance_Projet
2. Installer les dépendances R
Ouvrez R ou RStudio et exécutez :
rinstall.packages(c("ggplot2", "dplyr", "plotly", "scales", "readr"))

3. Générer la présentation
Option A : Depuis RStudio

Ouvrir Presentation/Ma-presentation.qmd
Cliquer sur le bouton "Render"

Option B : Depuis le terminal
bashcd Presentation/
quarto render Ma-presentation.qmd
4. Visualiser la présentation
Ouvrir le fichier Ma-presentation.html dans un navigateur web.

🛠️ Technologies Utilisées
Langage : R
Visualisation : ggplot2, plotly
Manipulation de données : dplyr, readr
Présentation : Quarto (RevealJS)
Exécution web : WebR (R dans le navigateur)
Versioning : Git / GitHub

🔍 Méthodologie
Collecte : Extraction des données d'instances 2025
Nettoyage : Traitement et validation des données
Analyse : Exploration statistique et visualisations
Synthèse : Identification des insights clés
Recommandations : Propositions d'actions basées sur les données

👤 Auteur
IMEN BEN DHIAB

GitHub : @BenDhiabImen1980
Projet : Instance_Projet

📄 Licence
Ce projet est à usage académique et professionnel.

Date de dernière mise à jour : 06 janvier 2025
Version : 1.0.0
