library("tidyr")

rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Read posterior model probabilities
postMProb <- readRDS("posterior-model-prob/posterior-model-probabilities.rds")

# Load data and results Klauer 2007
source("../klauer2007/Klauer2007_data.R")
source("../klauer2007/Klauer2007_results.R")

# Calculate median posterior model probability over repetitions
medianPMP <- aggregate(postMProb$post_model_prob, 
                       list(postMProb$method, postMProb$model, 
                            postMProb$experiment, postMProb$group), 
                       median)
colnames(medianPMP) <- c("method", "model", "experiment", "group", 
                         "median_pmp")

# Change median df from long to wide
medianPMPWide <- spread(medianPMP, model, median_pmp)

# Split data frame by method
pMPBridgeNormal <- medianPMPWide[medianPMPWide$method == "bridge_normal", -1]
pMPBridgeWarp3 <- medianPMPWide[medianPMPWide$method == "bridge_warp3", -1]
pMPImportance <- medianPMPWide[medianPMPWide$method == "importance", -1]

# Data frame for mean ranks
meanRanks <- data.frame(model = unique(postMProb$model),
                        AICKlauer = NA,
                        BICKlauer = NA,
                        bridge_normal = NA,
                        bridge_warp3 = NA,
                        importance = NA)

# List of data frames
listMethods <- list(AICKlauer = AICKlauer, BICKlauer = BICKlauer, 
                    bridge_normal = pMPBridgeNormal, 
                    bridge_warp3 = pMPBridgeWarp3,
                    importance = pMPImportance)

# Calculate mean rank model for each method
for (i in 1:length(listMethods)) {
  if (names(listMethods)[i] %in% c("AICKlauer", "BICKlauer")) {
    df <- listMethods[[i]][, 3:8]
  } else {
    df <- -1 * listMethods[[i]][, 3:8]
  }
  rankDF <- apply(df, 1, rank)
  print(rankDF)
  meanRank <- apply(rankDF, 1, mean)
  meanRanks[, i + 1] <- meanRank
}



