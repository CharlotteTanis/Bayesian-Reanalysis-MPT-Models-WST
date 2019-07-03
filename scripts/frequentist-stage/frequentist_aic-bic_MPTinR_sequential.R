rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# install.packages("MPTinR")
library("MPTinR")

# Load functions, data, model specifications and results Klauer 2007
source("../functions.R")
source("../klauer2007/Klauer2007_data.R")
source("../klauer2007/Klauer2007_models.R")
source("../klauer2007/Klauer2007_results.R")

###############################################################################
## Choose model: independence, inferenceGuessing, inferenceGuessingRel,
##               heuristicAnalytic, heuristicAnalyticRel,
##               relevanceInferenceGuessing
###############################################################################
modelToUse <- "relevanceInferenceGuessing"

# Number of optimization runs
nOptim <- 100

# Specification chosen model
modelSpecification <- modelsKlauer[[modelToUse]]

# General information model
if (modelToUse == "relevanceInferenceGuessing") {
  modelSpecification <- paste("../../txt/", modelSpecification, sep = "")
  checkModel <- check.mpt(modelSpecification)
} else {
  checkModel <- check.mpt(textConnection(modelSpecification))
}
checkModel

# Parameters
parametersModel <- checkModel$parameters
nParameter <- length(parametersModel)

# Data frame for AIC and BIC results
results <- data.frame(experiment = rep(1:nExp, times = nGroups[1:nExp]),
                      group = groups,
                      AIC = numeric(sum(nGroups[1:nExp])),
                      AICKlauer = AICKlauer[, modelToUse],
                      BIC = numeric(sum(nGroups[1:nExp])),
                      BICKlauer = BICKlauer[, modelToUse],
                      stringsAsFactors = FALSE)

# Add parameters to results
for (i in 1:length(parametersModel)) {
  results[parametersModel[i]] <- NA
}

# For every combination of experiment and group
for (i in 1:nrow(results)) {
  # Experiment and group numbers
  expNo <- results$experiment[i]
  group <- results$group[i]
  
  # Fit model
  if (modelToUse == "relevanceInferenceGuessing") {
    mptFit <- fit.mpt(dat$freq[(dat$expNo == expNo & dat$group == group)],
                      modelSpecification, fia = 25000,
                      show.messages = FALSE, n.optim = nOptim)
  } else {
    mptFit <- fit.mpt(dat$freq[(dat$expNo == expNo & dat$group == group)],
                      textConnection(modelSpecification), fia = 25000,
                      show.messages = FALSE, n.optim = nOptim)
  }
  
  # AIC and BIC
  aic <- mptFit$information.criteria$AIC
  bic <- mptFit$information.criteria$BIC
  
  # Add AIC and BIC to results
  results$AIC[i] <- aic
  results$BIC[i] <- bic
  
  # Add parameter estimates to results
  for (j in 1:nParameter) {
    paramName <- row.names(mptFit$parameters)[j]
    paramValue <- mptFit$parameters$estimates[j]
    results[i, paramName] <- paramValue
  }
}

# Do computed responses correspond to Klauer's results
# AIC
if (!all(round2(results$AIC, 2) == results$AICKlauer)) {
  differencesAIC <- !round2(results$AIC, 2) == results$AICKlauer
  warning(paste("Differences between computed and Klauer's AIC results for:",
                "\n", paste("Experiment ",
                            results$experiment[differencesAIC],
                            ", group ", results$group[differencesAIC],
                            collapse = "\n", sep = ""), sep = ""))
} else {
  cat("All computed AIC results are equivalent to Klauer's AIC results!")
}

# BIC
if (!all(round2(results$BIC, 2) == results$BICKlauer)) {
  differencesBIC <- !round2(results$BIC, 2) == results$BICKlauer
  warning(paste("Differences between computed and Klauer's BIC results for:",
                "\n", paste("Experiment ",
                            results$experiment[differencesAIC],
                            ", group ", results$group[differencesAIC],
                            collapse = "\n", sep = ""), sep = ""))
} else {
  cat("All computed BIC results are equivalent to Klauer's BIC results!")
}

# Write results to CSV
write.csv(results, paste("../../csv/frequentist-stage/", modelToUse, 
                         "_MPTinR-package_noptim",  nOptim, ".csv", sep = ""), 
          row.names = FALSE)
