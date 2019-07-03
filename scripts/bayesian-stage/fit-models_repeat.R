rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("rstan")
library("stringr")

# Load data Klauer 2007
source("../klauer2007/Klauer2007_data.R")

###############################################################################
## Choose model: independence, inferenceGuessing, inferenceGuessingRel,
##               heuristicAnalytic, heuristicAnalyticRel,
##               relevanceInferenceGuessing
###############################################################################
modelToUse <- "relevanceInferenceGuessing"

# Number of repetitions
nRep <- 20
repPad0 <- str_pad(1:nRep, 3, pad = "0")

# Settings for Stan -----------------------------------------------------------
# Number of cores for parallel computing
nCores <- 4 
options(mc.cores = 4)

# Avoid recompilation of unchanged Stan programs
rstan_options(auto_write = TRUE)

# relevanceInferenceGuessing leads to divergent transitions after warmup when
# using default adapt_delta = 0.8, set to adapt_delta = 0.99
if (modelToUse == "relevanceInferenceGuessing") {
  adaptDelta <- .99
} else {
  adaptDelta <- .8
}

iter <- 6000
chains <- 4
thin <- 1
warmup <- 1000
inits <- seq(from = (1 / (chains + 1)),
             to = 1 - 1 / (chains + 1),
             by = 1 / (chains + 1))

# Filenames of stan file and results frequentist stage
stanFile <- paste("../../stan/", modelToUse, ".stan", sep = "")
resultsFreq <- read.csv(paste("../../csv/frequentist-stage/", modelToUse,
                              "_MPTinR-package_noptim100.csv", sep = ""),
                        stringsAsFactors = FALSE)

# Parameters model
parameters <- colnames(resultsFreq)[7:ncol(resultsFreq)]
nParameters <- length(parameters)

# Initial values parameters
myInits <- list()
for (i in 1:chains) {
  # Set value
  myInits[[i]] <- as.list(rep(inits[i], nParameters))
  # Set name
  names(myInits[[i]]) <- parameters
}

# List to save samples --------------------------------------------------------
allSamples <- vector("list", nrow(resultsFreq))
names(allSamples) <- paste("exp", resultsFreq$experiment, 
                           "_group", resultsFreq$group, sep = "")

# Obtain MCMC samples ---------------------------------------------------------
# Repeat nRep times for each group of each experiment
for (rep in 1:nRep) {
  for (i in 1:nExp) {
    for (j in 1:nGroups[i]) {
      cat(paste("Repetition ", rep, ", Experiment ", i, ", group ", j, "\n", 
                sep = ""))
      
      # Vector of frequencies
      k <- dat$freq[dat$expNo == i & dat$group == j]
      
      # Data to be passed on to Stan
      datStan <- list(k = k)
      
      # Combination of experiment and group
      expGroup <- paste("exp", i, "_group", j, sep = "")
      
      # Call Stan
      samples <- stan(file = stanFile,
                      data = datStan,
                      init = myInits,
                      pars = parameters,
                      iter = iter,
                      chains = chains,
                      thin = thin,
                      warmup = warmup,
                      control = list(max_treedepth = 14,
                                     adapt_delta = adaptDelta)
      )
      
      # Add samples to allSamples
      allSamples[[expGroup]] <- samples
      
      # Plots -----------------------------------------------------------------
      # Extract parameters from samples and plot
      pdf(paste("plots/", modelToUse, "/" , expGroup, "/", 
                "samples_parameters_", modelToUse, "_", expGroup, "_rep", 
                repPad0[rep],".pdf", sep = ""),
          height = 20, width = 10)
      
      par(mfrow = c(ceiling(nParameters / 2), 2))
      for (k in 1:nParameters) {
        paramName <- parameters[k]
        paramValue <- extract(samples)[paramName]
        
        plot(density(paramValue[[1]]),
             main = "",
             xlab = paramName,
             ylab = "Probability Density",
             xlim = c(0, 1),
             ylim = c(0, 20),
             lty = "dotted",
             bty = "n")
        
        # Vertical line at value found in frequentist stage
        abline(v = resultsFreq[resultsFreq$experiment == i &
                                 resultsFreq$group == j, paramName],
               lty = "dashed")
      }
      par(mfrow = c(1, 2))
      dev.off()
      
      # Traceplot
      pdf(paste("plots/", modelToUse, "/" , expGroup, "/", 
                "samples_traceplot_", modelToUse, "_", expGroup, "_rep", 
                repPad0[rep], ".pdf", sep = ""),
          width = 14, height = 7)
      
      print(traceplot(samples, pars = parameters))
      dev.off()
    }
  }
  # Save samples per repetition------------------------------------------------
  saveRDS(allSamples, file = paste("samples/", modelToUse, "/allsamples_", modelToUse, "_rep",
                                   repPad0[rep], ".rds", sep = ""))
  
  # Clear list
  allSamples <- vector("list", nrow(resultsFreq))
  names(allSamples) <- paste("exp", resultsFreq$experiment, 
                             "_group", resultsFreq$group, sep = "")
}
