###############################################################################
## AIC and BIC results from all experiments in Klauer (2007)
## First run Klauer2007_data.R
###############################################################################

# Data frame for Klauer's AIC results
AICKlauer <- data.frame(experiment = experiments,
                        group = groups,
                        independence = numeric(nGroupsTot),
                        inferenceGuessing = numeric(nGroupsTot),
                        inferenceGuessingRel = numeric(nGroupsTot),
                        heuristicAnalytic = numeric(nGroupsTot),
                        heuristicAnalyticRel = numeric(nGroupsTot),
                        relevanceInferenceGuessing = numeric(nGroupsTot),
                        stringsAsFactors = FALSE
)

# Data frame for Klauer's BIC results
BICKlauer <- AICKlauer

# AIC results
AICKlauer$independence <- c(147.15, 176.28, 152.02, 131.13, 185.41, 71.40, 
                            160.49, 109.88, 183.92, 190.97, 118.27, 150.50, 
                            121.44, 85.70, 109.67, 97.42)

AICKlauer$inferenceGuessing <- c(25.28, 25.89, 21.29, 25.66, 22.85, 29.37, 
                                 29.74, 28.73, 27.97, 41.68, 29.46, 44.28, 
                                 25.26, 25.19, 26.92, 23.15)

AICKlauer$inferenceGuessingRel <- c(28.36, 25.72, 24.59, 29.51, 24.90, 25.48,
                                    26.66, 32.64, 25.24, 32.96, 30.50, 28.43,
                                    28.79, 25.94, 27.48, 26.51)

AICKlauer$heuristicAnalytic <- c(21.88, 25.75, 24.92, 59.03, 25.39, 38.35, 
                                 30.73, 48.67, 26.84, 50.00, 36.24, 46.86, 
                                 27.38, 28.12, 20.96, 23.50)

AICKlauer$heuristicAnalyticRel <- c(25.09, 24.35, 27.89, 56.47, 25.27, 29.50,
                                    28.16, 49.09, 24.01, 35.45, 37.19, 33.03, 
                                    27.75, 28.19, 22.25, 22.92)

AICKlauer$relevanceInferenceGuessing <- c(29.65, 29.12, 28.32, 29.81, 28.59,
                                          30.43, 29.56, 28.47, 31.77, 31.74,
                                          31.31, 31.45, 28.84, 30.52, 28.13, 
                                          28.22)

# BIC results
BICKlauer$independence <- c(161.97, 191.56, 167.32, 145.94, 200.67, 86.42, 
                            175.51, 124.91, 199.29, 206.46, 133.39, 165.32, 
                            136.58, 100.72, 124.72, 112.56)

BICKlauer$inferenceGuessing <- c(62.31, 64.09, 59.52, 62.69, 60.99, 66.93, 
                                 67.30, 66.32, 66.41, 80.40, 67.27, 81.32, 
                                 63.10, 62.75, 64.54, 61.01)

BICKlauer$inferenceGuessingRel <- c(72.81, 71.56, 70.46, 73.96, 70.67, 70.55, 
                                    71.73, 77.74, 71.36, 79.43, 75.86, 72.88,
                                    74.20, 71.01, 72.62, 71.95)

BICKlauer$heuristicAnalytic <- c(55.22, 60.13, 59.33, 92.37, 59.72, 72.16,
                                 64.53, 82.50, 61.43, 84.85, 70.27, 80.19,
                                 61.43, 61.92, 54.82, 57.58)

BICKlauer$heuristicAnalyticRel <- c(65.84, 66.37, 69.95, 97.21, 67.22, 70.81, 
                                    69.47, 90.44, 66.29, 78.05, 78.78, 73.77,
                                    69.37, 69.50, 63.63, 64.58)

BICKlauer$relevanceInferenceGuessing <- c(81.50, 82.60, 81.85, 81.67, 81.98,
                                          83.01, 82.14, 81.09, 85.58, 85.95,
                                          84.24, 83.30, 81.81, 83.10, 80.80,
                                          81.23)
