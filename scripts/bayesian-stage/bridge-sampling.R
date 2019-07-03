rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("rstan")
library("bridgesampling")
library("stringr")

# Load data Klauer 2007
source("../klauer2007/Klauer2007_data.R")

###############################################################################
## Choose model: independence, inferenceGuessing, inferenceGuessingRel,
##               heuristicAnalytic, heuristicAnalyticRel,
##               relevanceInferenceGuessing
###############################################################################
modelToUse <- "heuristicAnalytic"

# Choose method: normal or warp3
bridgeMethod <- "warp3"

# Number of cores for parallel computing
nCores <- 4

# Number of repetitions
nRep <- 20
repPad0 <- str_pad(1:nRep, 3, pad = "0")

# Filename of stan file 
stanFile <- paste("../../stan/", modelToUse, ".stan", sep = "")
rstan_options(auto_write = TRUE)

# Lists to save objects -------------------------------------------------------
# Bridge objects
bridgeObjects <- vector("list", nGroupsTot)
names(bridgeObjects) <- paste("exp", experiments, "_group", groups, sep = "")

bridgeObjectsRep <- vector("list", nRep)
names(bridgeObjectsRep) <- paste("rep_", 1:nRep, sep = "")
bridgeObjectsRep <- lapply(bridgeObjectsRep, function(x) {
  bridgeObjects
})

# Log marginal likelihoods
logMarginalLik <- vector("list", nGroupsTot)
names(logMarginalLik) <- paste("exp", experiments, "_group", groups, sep = "")
logMarginalLik <- lapply(logMarginalLik, function(x) {
  numeric(nRep)
})

# Bridge sampling for each group of each experiment ---------------------------
for (rep in 1:nRep) {
  # Load samples of repetition of all experiments and groups
  samples <- readRDS(paste("samples/", modelToUse, "/allsamples_", modelToUse, 
                           "_rep", repPad0[rep], ".rds", sep = ""))
  for (i in 1:nExp) {
    for (j in 1:nGroups[i]) {
      cat(paste("Repetition ", rep, ", experiment ", i, ", group ", j, "\n", 
                sep = ""))
      
      # Vector of frequencies
      k <- dat$freq[dat$expNo == i & dat$group == j]
      
      # Data to be passed on to Stan
      datStan <- list(k = k)
      
      # New model to avoid Error in .local(object, ...) : 
      #                    the model object is not created or not valid
      # Supposed to get: the number of chains is less than 1; sampling not done
      newModel <- stan(file = stanFile, data = datStan, chains = 0)
      
      # Combination of experiment and group
      expGroup <- paste("exp", i, "_group", j, sep = "")
      
      # Bridge sampling, use samples of experiment and group
      bridge <- bridge_sampler(samples = samples[[expGroup]], 
                               stanfit_model = newModel,
                               method = bridgeMethod,
                               cores = nCores)
      bridgeObjectsRep[[rep]][[expGroup]] <- bridge
      
      # Extract log marginal likelihood
      logMarginalLik[[expGroup]][rep] <- bridge$logml
    }
  }
  
  # Save bridge objects after each repetition ---------------------------------
  saveRDS(bridgeObjectsRep[[rep]], file = paste("bridge/", modelToUse, 
                                                "/bridgeobjects_", 
                                                bridgeMethod, "_", modelToUse, 
                                                "_rep", repPad0[rep], ".rds", 
                                                sep = ""))
}

# Save bridge objects and logml------------------------------------------------
saveRDS(bridgeObjectsRep, file = paste("bridge/", modelToUse, 
                                       "/bridgeobjects_", bridgeMethod, "_", 
                                       modelToUse, "_all-rep", repPad0[nRep], 
                                       ".rds", sep = ""))

saveRDS(logMarginalLik, file = paste("bridge/", modelToUse, "/logml_bridge_", 
                                     bridgeMethod, "_", modelToUse, "_all-rep", 
                                     repPad0[nRep], ".rds", sep = ""))



