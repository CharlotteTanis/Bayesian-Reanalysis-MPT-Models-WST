###############################################################################
## Parameter results inference guessing from all experiments in Klauer (2007)
###############################################################################

library("MPTinR")

# Parameters
allParameters <- check.mpt(textConnection(
  modelsKlauer[["inferenceGuessingFourGroups"]]))$parameters

# All variables to compare with Klauer's results
goodnessFit <- c("G2", "df", "pValue")
allVariables <- c(allParameters, goodnessFit)
nVar <- length(allVariables)

# Data frame for parameter, and G2 results
resultsParametersKlauer <- data.frame(Exp1 = rep(NA, nVar),
                                      Exp2 = rep(NA, nVar),
                                      Exp3 = rep(NA, nVar),
                                      Exp4 = rep(NA, nVar),
                                      Exp5 = rep(NA, nVar),
                                      Exp6 = rep(NA, nVar),
                                      stringsAsFactors = FALSE)

row.names(resultsParametersKlauer) <- allVariables

# Parameters per group
paramsGr1 <- c("p", "np", "q", "nq", "a", "c", "x", "d", "s", "i")
paramsGr2 <- paste(paramsGr1, 2, sep = "")
paramsGr3 <- paste(paramsGr1, 3, sep = "")
paramsGr4 <- paste(paramsGr1, 4, sep = "")

# Results experiment 1
resultsParametersKlauer[paramsGr1, "Exp1"] <- c(.50, .22, .42, .38, 
                                                .78, .47, .97, .87, .92, .90)

resultsParametersKlauer[paramsGr2, "Exp1"] <- c(.73, .15, .53, .41,
                                                .76, .50, .94, .76, .86, .81)

resultsParametersKlauer[goodnessFit, "Exp1"] <- c(10.85, 10, .37)

# Results experiment 2
resultsParametersKlauer[paramsGr1, "Exp2"] <- c(.35, .34, .31, .40, 
                                                .79, .49, .97, .87, .93, .92)

resultsParametersKlauer[paramsGr2, "Exp2"] <- c(.33, .39, .54, .62, 
                                                .73, .69, .83, .96, .92, .81)

resultsParametersKlauer[goodnessFit, "Exp2"] <- c(5.87, 10, .83)

# Results experiment 3
resultsParametersKlauer[paramsGr1, "Exp3"] <- c(.49, .28, .38, .51,
                                                .77, .49, .99, .79, .89, .91)

resultsParametersKlauer[paramsGr2, "Exp3"] <- c(.47, .19, .34, .44, 
                                                .62, .75, .91, .83, .99, .97)

resultsParametersKlauer[goodnessFit, "Exp3"] <- c(11.96, 10, .29)

# Results experiment 4 - relaxed assumptions
resultsParametersKlauer[goodnessFit, "Exp4"] <- c(18.48, 10, .047)

# Results experiment 5 - relaxed assumptions
resultsParametersKlauer[goodnessFit, "Exp5"] <- c(60.46, 20, NA)

# Results experiment 6
resultsParametersKlauer[paramsGr1, "Exp6"] <- c(.32, .23, .51, .39,
                                                .63, .47, .95, .84, .84, .82)

resultsParametersKlauer[paramsGr2, "Exp6"] <- c(.61, .10, .46, .43, 
                                                .54, .45, 1, .78, .9, .81)

resultsParametersKlauer[paramsGr3, "Exp6"] <- c(.50, .37, .31, .51, 
                                                .61, .49, .84, .86, .91, .86)

resultsParametersKlauer[paramsGr4, "Exp6"] <- c(.69, .22, .51, .24, 
                                                .52, .39, .94, .76, .86, .79)

resultsParametersKlauer[goodnessFit, "Exp6"] <- c(19.62, 20, .48)


