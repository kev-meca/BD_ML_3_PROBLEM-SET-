# Predicting poverty -------------------------------------------------------
# Autores: Martinez, Kevin. 
# Materia: Big Data and Machine Learning para Economía Aplicada
# Año: 2023


# 1| Preparacion ----------------------------------------------------------
rm(list = ls())
graphics.off()
options(scipen = 999)
set.seed(123)  # Replicabilidad en las simulaciones.

# 1.1| Librerias ----------------------------------------------------------
librerias <- c(
  'here', 'tidyverse', 'tidymodels', 'conflicted', 'xtable',
  'gtsummary', 'gt', 'stringr', 'extrafont', 'xgboost',
  'lightgbm', 'bonsai', 'vip', 'randomForest', 'rpart',
  'baguette', 'themis', 'doParallel'
)
noInstaladas <- librerias[!(librerias %in% rownames(installed.packages()))]

if (length(noInstaladas)) {
  install.packages(noInstaladas)
}

invisible(sapply(librerias, function(pkg) {
  library(pkg, character.only = TRUE, quietly = TRUE)
}))
loadfonts(device = 'win')
conflict_prefer(name = 'filter', winner = 'dplyr')
conflict_prefer(name = 'slice', winner = 'dplyr')
conflict_prefer(name = 'spec', winner = 'yardstick')
conflict_prefer(name = 'step', winner = 'recipes')
conflict_prefer(name = 'setdiff', winner = 'base')
conflict_prefer(name = 'starts_with', winner = 'tidyselect')

# 1.2| Directorios ---------------------------------------------------------

# Directorio base

# Elegir un archivo de manera interactiva para obtener el directorio base
file_selected <- file.choose()
base_dir <- dirname(file_selected)

# Sub-directorios
codigo_dir <- file.path(base_dir, "Scripts")
datos_dir <- file.path(base_dir, "DATA")
resultados_dir <- file.path(base_dir, "Results.R")

# Fijar directorio de trabajo
setwd(base_dir)

# Verifica y crea el directorio base si no existe
if (!dir.exists(base_dir)) {
  cat("El directorio base no existe. Por favor, verifica la ruta.\n")
  stop("La ejecución del script se detuvo debido a un error en la ruta del directorio base.")
}


# Cargar funciones
source(file.path(codigo_dir, "Functions/Cleaning.R"), encoding = "UTF-8")

# Guardar resultados
primera_vez <- FALSE
if (!primera_vez) {
  # Cargar resultados previos
  dat_limpios <- readRDS(file.path(resultados_dir, "Results.R"))
} else {
  # Ejecutar preprocesamiento
  source(file.path(codigo_dir, "Scripts/Data_cleaning.R"), encoding = "UTF-8")
  
  # Guardar resultados
  saveRDS(dat_limpios, file.path(resultados_dir, "Functions/Cleaning.R"))
}


