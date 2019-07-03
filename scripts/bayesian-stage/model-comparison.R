rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("bridgesampling")

# Load data and results Klauer 2007
source("../frequentist-stage/Klauer2007_data.R")
source("../frequentist-stage/Klauer2007_results.R")

###############################################################################
## Model comparison based on bridge sampling
###############################################################################

# Load bridge objects for all models
independenceBridge <- readRDS("bridge/bridgeobjects_independence.rds")
inferenceGuessingBridge <- readRDS("bridge/bridgeobjects_inferenceGuessing.rds")
inferenceGuessingRelBridge <- readRDS("bridge/bridgeobjects_inferenceGuessingRel.rds")
heuristicAnalyticBridge <- readRDS("bridge/bridgeobjects_heuristicAnalytic.rds")
heuristicAnalyticRelBridge <- readRDS("bridge/bridgeobjects_heuristicAnalyticRel.rds")
relevanceInferenceGuessingBridge <- readRDS("bridge/bridgeobjects_relevanceInferenceGuessing.rds")

# List for posterior model probabilities
posteriorProb <- vector("list", length(independenceBridge))
names(posteriorProb) <- names(independenceBridge)

# Calculate posterior model probabilities for each experiment and group
for (i in 1:nExp) {
  for (j in 1:nGroups[i]) {
    indexList <- paste("exp", i, "_group", j, sep = "")
    posteriorProb[[indexList]] <- post_prob(independenceBridge[[indexList]],
                                            inferenceGuessingBridge[[indexList]],
                                            inferenceGuessingRelBridge[[indexList]],
                                            heuristicAnalyticBridge[[indexList]],
                                            heuristicAnalyticRelBridge[[indexList]],
                                            relevanceInferenceGuessingBridge[[indexList]])
  }
}

# Model with highest posterior 
lapply(posteriorProb, which.max)

# post_prob(independenceBridge, inferenceGuessingBridge, 
#           inferenceGuessingRelBridge, heuristicAnalyticBridge,
#           heuristicAnalyticRelBridge, relevanceInferenceGuessingBridge)

###############################################################################
## Winning models
###############################################################################

winningModels <- data.frame(experiment = AICKlauer$experiment,
                            group = AICKlauer$group,
                            win_AIC = colnames(AICKlauer[3:ncol(AICKlauer)])[apply(AICKlauer[, 3:ncol(AICKlauer)], 1, which.min)],
                            win_BIC = colnames(AICKlauer[3:ncol(BICKlauer)])[apply(BICKlauer[, 3:ncol(BICKlauer)], 1, which.min)],
                            win_Bridge = colnames(AICKlauer[3:ncol(AICKlauer)])[sapply(posteriorProb, which.max)])

# Check optimization results
# Look at Warp 3
# Variability of bridge sampling estimates -> repeat estimation and bridge sampling 10-20 times
## Look at median of posterior model probabilities so they sum up to one - min/max or credible interval depends on variability and how you want to make it look
# Mean rank both Klauer as posterior probability
# Some kind of heat map for visualization
# Paper Joachim, Dora and EJ for importance sampling
## Code available on EJ's website
## Write function to evaluate likelihood times prior
## Keep in mind proposal is fitted for parameter at the time and then take product
## Could be problem when parameters are highly correlated
# Solve posterior independence model analytically (Bernouilli's), for general Beta prior
# Compare exponential of logml in bridgesampling package


# DONE Replace tilde priors stan code to target
# DONE Make script run parallel






