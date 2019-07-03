rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load data Klauer 2007 and functions
source("../klauer2007/Klauer2007_data.R")
source("../functions.R")

library("stringr")

###############################################################################
## Choose model: independence, inferenceGuessing, inferenceGuessingRel,
##               heuristicAnalytic, heuristicAnalyticRel,
##               relevanceInferenceGuessing
###############################################################################
modelToUse <- "heuristicAnalyticRel"

# Number of repetitions
nRep <- 20
repPad0 <- str_pad(1:nRep, 3, pad = "0")

# Choose mixture weight and number of draws
w <- 0.1
nDraws <- 20000

# List for marginal likelihoods
marginalLik <- vector("list", nGroupsTot)
names(marginalLik) <- paste("exp", experiments, "_group", groups, sep = "")
marginalLik <- lapply(marginalLik, function(x) {
  numeric(nRep)
})

# Importance sampling for each group of each experiment -----------------------
for (rep in 1:nRep) {
  # Obtain MCMC samples -------------------------------------------------------
  # Load samples of repetition of all experiments and groups
  samples <- readRDS(paste("samples/", modelToUse, "/allsamples_", modelToUse, 
                           "_rep", repPad0[rep], ".rds", sep = ""))
  for (i in 1:nExp) {
    for (j in 1:nGroups[i]) {
      cat(paste("Repetition ", rep, ", experiment ", i, ", group ", j, "\n", 
                sep = ""))
      
      # Combination of experiment and group
      expGroup <- paste("exp", i, "_group", j, sep = "")
      
      # Samples of group
      samplesGroup <- samples[[expGroup]]
      
      # Extract sample values for each parameter
      samplesDf <- as.data.frame(samplesGroup)
      nParam <- ncol(samplesDf) - 1
      paramNames <- colnames(samplesDf)[1:nParam]
      
      # Fit Beta mixture ------------------------------------------------------
      # List of lists to save alpha and beta of beta mixture for each param
      betaMixParam <- vector("list", nParam)
      names(betaMixParam) <- paramNames
      betaMixParam <- lapply(betaMixParam, function(x) {
        list(alpha = NA, beta = NA)
      })
      
      # Fit beta for each parameter and confirm fit
      pdf(paste("plots/", modelToUse, "/", expGroup, "/importance_betafit_", 
                modelToUse, "_", expGroup, "_rep", repPad0[rep], ".pdf", 
                sep = ""),
          width = 20, height = 10)
      
      par(mfrow = c(ceiling(nParam / 2), 2))
      
      for (k in 1:nParam) {
        # Save alpha and beta parameters
        fitBeta <- fitbeta(samplesDf[, k])
        betaMixParam[[k]]$alpha <- fitBeta[1]
        betaMixParam[[k]]$beta <- fitBeta[2]
        
        # Plot
        plot.fit(theta = samplesDf[, k], alpha = betaMixParam[[k]]$alpha, 
                 beta = betaMixParam[[k]]$beta, name = colnames(samplesDf)[k])
        
      }
      
      par(mfrow = c(1, 1))
      dev.off()
      
      # Draw from Beta mixture ------------------------------------------------
      # Empty list to save draws
      importanceSamples <- vector("list", nParam)
      names(importanceSamples) <- paramNames
      
      # Draw for each parameter
      for (k in 1:nParam) {
        # Save importance draws in list
        importanceSamples[[k]] <- rbetamix(N = nDraws, 
                                           alpha = betaMixParam[[k]]$alpha, 
                                           beta = betaMixParam[[k]]$beta, 
                                           w = w)
      }
      
      # Compute probabilites for samples from importance distribution ---------
      categoryProb <- CategoryProb(samples = importanceSamples, 
                                   model = modelToUse)
      
      # Calculate marginal likelihood -----------------------------------------
      # Compute likelihoods: p(y | theta, M)
      logMultinomLik <- numeric(nDraws)
      
      for (k in 1:nDraws) {
        logMultinomLik[k] <- dmultinom(x = dat$freq[dat$expNo == i & 
                                                   dat$group == j], 
                                    prob = categoryProb[k, ],
                                    log = TRUE)
      }
      
      # Compute probability importance density: g(theta)
      logPImportance <- 0
      
      for (k in 1:nParam) {
        logPImportance <- logPImportance + log(dbetamix(importanceSamples[[k]],
                                              alpha = betaMixParam[[k]]$alpha,
                                              beta = betaMixParam[[k]]$beta,
                                              w = w))
      }
      
      # Compute marginal likelihood
      marginalLik[[expGroup]][rep] <- mean(exp(logMultinomLik - logPImportance))
    }
  }
}

# Save marginal likelihoods
saveRDS(marginalLik, file = paste("importance/", modelToUse, 
                                  "/ml_importance_", modelToUse, "_all-rep", 
                                  repPad0[nRep], ".rds", sep = ""))
