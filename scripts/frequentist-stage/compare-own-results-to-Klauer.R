rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("xtable")

# Functions, data and results
source("../functions.R")
source("../klauer2007/Klauer2007_data.R")
source("../klauer2007/Klauer2007_results.R")

# Models
models <- c("independence", "inferenceGuessing", "inferenceGuessingRel",
            "heuristicAnalytic", "heuristicAnalyticRel",
            "relevanceInferenceGuessing")


# For each model
for (i in 1:length(models)) {
  # Read results
  results <- read.csv(paste("../../csv/frequentist-stage/", models[i], 
                            "_MPTinR-package_noptim100.csv", sep = ""), 
                      stringsAsFactors = FALSE)

  # Print model name
  cat(paste(models[i], "\n", sep = ""))
  
  # Compare AIC results
  if (all(round2(results$AIC, 2) == results$AICKlauer)) {
    cat("All our AIC results are equal to Klauer's. \n")
  } else if (all(round2(results$AIC, 2) <= results$AICKlauer)) {
    cat("All our AIC results are smaller or equal than Klauer's. \n")
  } else {
    cat("Some of our AIC results are bigger than Klauer's. \n")
  }
  
  # Compare BIC results
  if (all(round2(results$BIC, 2) == results$BICKlauer)) {
    cat("All our BIC results are equal to Klauer's. \n")
  } else if (all(round2(results$BIC, 2) <= results$BICKlauer)) {
    cat("All our BIC results are smaller or equal than Klauer's. \n")
  } else {
    cat("Some of our BIC results are bigger than Klauer's.\n")
  }
  cat("\n")
}

# Create frequentist results table --------------------------------------------
# Klauer's results
AICresults <- AICKlauer
BICresults <- BICKlauer

# Differences for HA and RIG models, load those results
resultsHA <- read.csv(paste("../../csv/frequentist-stage/heuristicAnalytic_MPTinR-package_noptim100.csv", sep = ""), 
                      stringsAsFactors = FALSE)
resulsRIG <- read.csv(paste("../../csv/frequentist-stage/relevanceInferenceGuessing_MPTinR-package_noptim100.csv", sep = ""), 
                      stringsAsFactors = FALSE)

# Differences for HA and RIG models, so add column for those
AICresults["HA"] <- round2(resultsHA$AIC, 2)
AICresults["RIG"] <- round2(resulsRIG$AIC, 2)
BICresults["HA"] <- round2(resultsHA$BIC, 2)
BICresults["RIG"] <- round2(resulsRIG$BIC, 2)

# Ranks
ranksAICKlauer <- apply(AICresults[, 3:8], 1, rank)
ranksBICKlauer <- apply(BICresults[, 3:8], 1, rank)

ranksAICComputed <- apply(AICresults[, c(3:5, 9, 7, 10)], 1, rank)
ranksBICComputed <- apply(BICresults[, c(3:5, 9, 7, 10)], 1, rank)

# Some ranks are changed
all(ranksAICComputed == ranksAICKlauer)
all(ranksBICComputed == ranksBICKlauer)

which(ranksAICComputed != ranksAICKlauer)

# Mean rank
modelsShort <- c("I", "IG", "IGR", "HA", "HAR", "RIG")
meanRankAIC <- data.frame(model = modelsShort,
                          Klauer_paper = c(6.00, 2.22, 2.39, 3.61, 3.06, 3.72),
                          stringsAsFactors = FALSE)

meanRankBIC <- data.frame(model = modelsShort,
                          Klauer_paper = c(6.00, 1.94, 3.22, 1.94, 3.11, 4.78),
                          stringsAsFactors = FALSE)


meanRankAIC["Klauer_6exp"] <- apply(ranksAICKlauer, 1, mean)
meanRankAIC["Computed"] <- apply(ranksAICComputed, 1, mean)

meanRankBIC["Klauer_6exp"] <- apply(ranksBICKlauer, 1, mean)
meanRankBIC["Computed"] <- apply(ranksBICComputed, 1, mean)

colnames(meanRankAIC) <- colnames(meanRankBIC) <- paste("\\multicolumn{1}{c}{", 
                                                        colnames(meanRankAIC), 
                                                        "}", sep = "")

# Remove Klauer's values if they are the same as ours
AICresults$heuristicAnalytic[AICresults$heuristicAnalytic == AICresults$HA] <- NA
AICresults$relevanceInferenceGuessing[AICresults$relevanceInferenceGuessing == AICresults$RIG] <- NA
BICresults$heuristicAnalytic[BICresults$heuristicAnalytic == BICresults$HA] <- NA
BICresults$relevanceInferenceGuessing[BICresults$relevanceInferenceGuessing == BICresults$RIG] <- NA

# Reorder columns
orderColumns <- c(1:5, 9, 6, 7, 10, 8)
AICresults <- AICresults[, orderColumns]
BICresults <- BICresults[, orderColumns]
nCols <- ncol(AICresults)

# Change column names
colnames(AICresults)
colnamesResults <- c("Exp", "Gr", "I", "IG", "IGR", "HA", 
                     "HA\\textsubscript{K}", "HAR", "RIG", 
                     "RIG\\textsubscript{K}")
colnamesResults <- paste("\\multicolumn{1}{c}{", colnamesResults, "}", sep = "")
colnames(AICresults) <- colnames(BICresults) <- colnamesResults

# Make sure all numbers have 2 decimals, also when they are 0
AICresults[, 3:nCols] <- round2(AICresults[, 3:nCols], 2)
BICresults[, 3:nCols] <- round2(BICresults[, 3:nCols], 2)

# Create Latex tables
print(xtable(AICresults, display = c(rep("d", 3), rep("f", nCols - 2)), 
             align = rep("r", nCols + 1), caption = "AIC results", 
             label = "tab:aic-results"), 
      include.rownames = FALSE, sanitize.text.function = identity)

print(xtable(BICresults, display = c(rep("d", 3), rep("f", nCols - 2)), 
             align = rep("r", nCols + 1), caption = "BIC results", 
             label = "tab:bic-results"), 
      include.rownames = FALSE, sanitize.text.function = identity)

print(xtable(meanRankAIC, align = rep("r", ncol(meanRankAIC) + 1), 
             caption = "Mean rank AIC", label = "tab:mean-rank-aic"), 
      include.rownames = FALSE, sanitize.text.function = identity)

print(xtable(meanRankBIC, align = rep("r", ncol(meanRankBIC) + 1), 
             caption = "Mean rank BIC", label = "tab:mean-rank-bic"), 
      include.rownames = FALSE, sanitize.text.function = identity)








