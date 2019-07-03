rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("stringr")

# Load data Klauer 2007
source("../klauer2007/Klauer2007_data.R")

# General information ---------------------------------------------------------
nRep <- 20
repPad0 <- str_pad(1:nRep, 3, pad = "0")

samplingMethods <- c("importance", "bridge_normal", "bridge_warp3")
nMethods <- length(samplingMethods)
models <- c("independence", "inferenceGuessing", "inferenceGuessingRel",
            "heuristicAnalytic", "heuristicAnalyticRel", 
            "relevanceInferenceGuessing")
nModels <- length(models)

# Data frames to store posterior probabilities and variances ------------------
# Posterior model probability
postMProb <- data.frame(
  method = factor(rep(samplingMethods, each = nRep * nGroupsTot * nModels),
                  levels = samplingMethods),
  model = factor(rep(rep(models, each = nRep * nGroupsTot), times = nMethods),
                 levels = models),
  experiment = rep(rep(experiments, each = nRep), times = nModels * nMethods),
  group = rep(rep(groups, each = nRep), times = nModels * nMethods),
  repetition = rep(1:nRep, times = nGroupsTot * nModels * nMethods),
  post_model_prob = NA)

# Posterior model probability from median ml
medianPMP <- data.frame(
  method = factor(rep(samplingMethods, each = nGroupsTot * nModels),
                  levels = samplingMethods),
  model = factor(rep(rep(models, each = nGroupsTot), times = nMethods),
                 levels = models),
  experiment = rep(experiments, times = nModels * nMethods),
  group = rep(groups, times = nModels * nMethods),
  median_pmp = NA)

# Variance
varPMP <- medianPMP
colnames(varPMP)[colnames(medianPMP) == "median_pmp"] <- "variance"

# Compute posterior model probability and variance ----------------------------
for (i in 1:length(samplingMethods)) {
  # Sampling method
  samplingMethod <- samplingMethods[i]
  
  # Empty list for marginal likelihoods
  marginalLik <- vector("list", length(models))
  names(marginalLik) <- models
  
  for (j in 1:length(models)) {
    modelToUse <- models[j]
    
    # Read log marginal likelihood of bridge sampling
    if (samplingMethod %in% c("bridge_normal", "bridge_warp3")) {
      logMarginalLik <- readRDS(paste("bridge/", modelToUse, "/logml_",
                                      samplingMethod, "_", modelToUse, 
                                      "_all-rep", repPad0[nRep], ".rds", 
                                      sep = ""))
      
      # Calculate marginal likelihood
      marginalLik[[j]] <- lapply(logMarginalLik, exp)
      # Read marginal likelihood of importance sampling
    } else if (samplingMethod == "importance") {
      marginalLik[[j]] <- readRDS(paste("importance/", modelToUse, 
                                        "/ml_importance_", modelToUse, 
                                        "_all-rep", repPad0[nRep], ".rds", 
                                        sep = ""))
    }
  }
  
  # Compute posterior probability and variance
  for (expGroup in 1:nGroupsTot) {
    denominator <- rep(0, nRep)
    medianML <- rep(NA, nModels)
    
    # Denominator is sum of marginal likelihoods of models
    for (j in 1:length(models)) {
      denominator <- denominator + marginalLik[[j]][[expGroup]]
      medianML[j] <- median(marginalLik[[j]][[expGroup]])
    }
    
    # Posterior model probability = ml model / sum ml over all models
    for (j in 1:length(models)) {
      # Posterior model probability
      postModelProb <- marginalLik[[j]][[expGroup]] / denominator
      
      # Posterior model probability of median ml
      medianPostModelProb <- medianML[j] / sum(medianML)
      
      # Save values
      postMProb$post_model_prob[postMProb$method == samplingMethod & 
                                  postMProb$model == models[j] &
                                  postMProb$experiment == experiments[expGroup] &
                                  postMProb$group == groups[expGroup]] <- postModelProb
      
      varPMP$variance[varPMP$method == samplingMethod &
                        varPMP$model == models[j] &
                        varPMP$experiment == experiments[expGroup] &
                        varPMP$group == groups[expGroup]] <- var(postModelProb)
      
      medianPMP$median_pmp[medianPMP$method == samplingMethod &
                             medianPMP$model == models[j] &
                             medianPMP$experiment == experiments[expGroup] &
                             medianPMP$group == groups[expGroup]] <- medianPostModelProb
    }
  }
}

# Check if median posterior model probabilities sum to 1
check <- aggregate(medianPMP$median_pmp, 
                   by = list(method = medianPMP$method,
                             experiment = medianPMP$experiment,
                             group = medianPMP$group), sum)
all(round(check$x, 10) == 1)

# Save posterior model probabilities and variances
saveRDS(postMProb, 
        file = "posterior-model-prob/posterior-model-probabilities.rds")
saveRDS(varPMP, 
        file = "posterior-model-prob/posterior-model-probabilities_variance.rds")
saveRDS(medianPMP, 
        file = "posterior-model-prob/posterior-model-probabilities_median.rds")


# Median difference to 2nd highest
# Post prob model range from x to y with quantiles


