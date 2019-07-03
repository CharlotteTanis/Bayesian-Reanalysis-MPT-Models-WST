rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("MPTinR")

# Load functions, data, and results Klauer 2007
source("../functions.R")
source("../klauer2007/Klauer2007_data.R")
source("../klauer2007/Klauer2007_models.R")
source("../klauer2007/Klauer2007_results_parameters.R")

# Specifications of inference guessing models when combining groups
specCombinedGroups <- c(rep(modelsKlauer[["inferenceGuessingTwoGroups"]], 4),
                        rep(modelsKlauer[["inferenceGuessingFourGroups"]], 2))

# Copy data frame with Klauer's parameter results and set all values to NA
resultsParameters <- resultsParametersKlauer
resultsParameters[1:nrow(resultsParameters), 1:ncol(resultsParameters)] <- 1

# For each experiment
for (i in 1:nExp) {
  # Fit model
  mptFit <- fit.mpt(datCombinedGroups$freq[datCombinedGroups$expNo == i], 
                    textConnection(specCombinedGroups[i]), fia = 25000,
                    show.messages = FALSE)
  
  # Parameters
  for (j in 1:length(mptFit$parameters$estimates)) {
    paramName <- row.names(mptFit$parameters)[j]
    paramValue <- mptFit$parameters$estimates[j]
    resultsParameters[paramName, i] <- paramValue
  }
  
  # Goodness of fit
  resultsParameters["G2", i] <- mptFit$goodness.of.fit$G.Squared
  resultsParameters["df", i] <- mptFit$goodness.of.fit$df
  resultsParameters["pValue", i] <- mptFit$goodness.of.fit$p.value
}

# Do computed parameters correspond to Klauer's results
for (i in 1:nExp) {
  if (all(round2(resultsParameters[, i], 2) == resultsParametersKlauer[, i], 
          na.rm = TRUE)) {
    cat(paste("All results of experiment", i, "match with Klauer's results!\n"))
  } else {
    differencesParams <- !(round2(resultsParameters[, i], 2) == 
                             resultsParametersKlauer[, i])
    differencesParams[is.na(differencesParams)] <- FALSE
    
    warning(paste("Differences in Experiment ", i, ":", "\n", 
                  paste(row.names(resultsParameters)[differencesParams], 
                        collapse = ", "), sep = ""))
  }
}

# Write results to CSV
write.csv(resultsParameters, "../../csv/frequentist-stage/inferenceGuessing_parameters.csv", 
          row.names = FALSE)



