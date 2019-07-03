rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# install.packages("MPTinR")
library("MPTinR")

# Possible categories
categories <- c("0000",
                "0001",
                "0010",
                "0011",
                "0100",
                "0101",
                "0110",
                "0111",
                "1000",
                "1001",
                "1010",
                "1011",
                "1100",
                "1101",
                "1110",
                "1111")

# Inference-guessing model
specInferenceGuessing <- c(
  "(1 - a) * (1 - p) * (1 - np) * (1 - q) * (1 - nq)",  # 0000
  "a * c * (1 - d) * (1 - s) * i + (1 - a) * (1 - p) * (1 - np) * (1 - q) * nq",        # 0001
  "a * c * (1 - d) * s * i + (1 - a) * (1 - p) * (1 - np) * q * (1 - nq)",        # 0010
  "a * (1 - c) * (1 - x) * (1 - d) * i + (1 - a) * (1 - p) * (1 - np) * q * nq",              # 0011
  "a * c * d * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * (1 - nq)",        # 0100
  "a * (1 - c) * x * (1 - s) * i + (1 - a) * (1 - p) * np * (1 - q) * nq",              # 0101
  "a * c * d * (1 - s) * (1 - i) + a * c * (1 - d) * s * (1 - i) + (1 - a) * (1 - p) * np * q * (1 - nq)",              # 0110
  "(1 - a) * (1 - p) * np * q * nq",                    # 0111
  "a * c * d * s * i + (1 - a) * p * (1 - np) * (1 - q) * (1 - nq)",        # 1000
  "a * c * d * s * (1 - i) + a * c * (1 - d) * (1 - s) * (1 - i) + (1 - a) * p * (1 - np) * (1 - q) * nq",              # 1001
  "a * (1 - c) * x * s * i + (1 - a) * p * (1 - np) * q * (1 - nq)",              # 1010
  "(1 - a) * p * (1 - np) * q * nq",                    # 1011
  "a * (1 - c) * (1 - x) * d * i + (1 - a) * p * np * (1 - q) * (1 - nq)",              # 1100
  "(1 - a) * p * np * (1 - q) * nq",                    # 1101
  "(1 - a) * p * np * q * (1 - nq)",                    # 1110
  "a * (1 - c) * x * s * (1 - i) + a * (1 - c) * x * (1 - s) * (1 - i) + a * (1 - c) * (1 - x) * d * (1 - i) + a * (1 - c) * (1 - x) * (1 - d) * (1 - i) + (1 - a) * p * np * q * nq"                          # 1111
)

# Specification Independence model
# p, np, q, and nq parameters different from above (f: filter)
specIndependence <- c(
  "(1 - pf) * (1 - npf) * (1 - qf) * (1 - nqf)",  # 0000
  "(1 - pf) * (1 - npf) * (1 - qf) * nqf",        # 0001
  "(1 - pf) * (1 - npf) * qf * (1 - nqf)",        # 0010
  "(1 - pf) * (1 - npf) * qf * nqf",              # 0011
  "(1 - pf) * npf * (1 - qf) * (1 - nqf)",        # 0100
  "(1 - pf) * npf * (1 - qf) * nqf",              # 0101
  "(1 - pf) * npf * qf * (1 - nqf)",              # 0110
  "(1 - pf) * npf * qf * nqf",                    # 0111
  "pf * (1 - npf) * (1 - qf) * (1 - nqf)",        # 1000
  "pf * (1 - npf) * (1 - qf) * nqf",              # 1001
  "pf * (1 - npf) * qf * (1 - nqf)",              # 1010
  "pf * (1 - npf) * qf * nqf",                    # 1011
  "pf * npf * (1 - qf) * (1 - nqf)",              # 1100
  "pf * npf * (1 - qf) * nqf",                    # 1101
  "pf * npf * qf * (1 - nqf)",                    # 1110
  "pf * npf * qf * nqf"                           # 1111
)

# Data frame to store which category results from the Independence model input 
combinations <- data.frame(input = categories,
                           "0000" = NA,
                           "0001" = NA,
                           "0010" = NA,
                           "0011" = NA,
                           "0100" = NA,
                           "0101" = NA,
                           "0110" = NA,
                           "0111" = NA,
                           "1000" = NA,
                           "1001" = NA,
                           "1010" = NA,
                           "1011" = NA,
                           "1100" = NA,
                           "1101" = NA,
                           "1110" = NA,
                           "1111" = NA,
                           stringsAsFactors = FALSE,
                           check.names = FALSE)

# Fill data frame
# For each row
for (i in 1:nrow(combinations)) {
  # For each column except the first (input of the Independece model)
  for (j in 2:ncol(combinations)) {
    
    # Split input independence model in 4 seperate strings 
    input <- combinations$input[i]
    inputP <- substring(input, 1, 1)
    inputNp <- substring(input, 2, 2)
    inputQ <- substring(input, 3, 3)
    inputNq <- substring(input, 4, 4)
    
    # Split result if all cards are considered in 4 seperate strings
    origineel <- colnames(combinations[j])
    origineelP <- substring(origineel, 1, 1)
    origineelNp <- substring(origineel, 2, 2)
    origineelQ <- substring(origineel, 3, 3)
    origineelNq <- substring(origineel, 4, 4)
    
    # Initialize output to the values when all cards are considered
    outputP <- origineelP
    outputNp <- origineelNp
    outputQ <- origineelQ
    outputNq <- origineelNq
    
    # If a card is not considered (input = 0), set value to 0
    if (inputP == "0") {
      outputP <- "0"
    }
    
    if (inputNp == "0") {
      outputNp <- "0"
    }
    
    if (inputQ == "0") {
      outputQ <- "0"
    }
    
    if (inputNq == "0") {
      outputNq <- "0"
    }
    
    # Combine output p, np, q and n1
    output <- paste(outputP, outputNp, outputQ, outputNq, sep = "")
    
    # Set cell in combinations to correct output
    combinations[i, j] <- output
  }
}

# Initialize specification relevance-inf-guessing model to 16 empty strings
specRelevanceInferenceGuessing = rep("", 16)

# For each row in combinations
for (i in 1:nrow(combinations)) {
  # For each column, except the first
  for (j in 2:ncol(combinations)) {
    # Skip if inference model has no branch leading to the original category
    if (specInferenceGuessing[j - 1] == "0") {
      next
    } else {
      # Index of output category
      indexCategory <- which(categories == combinations[i, j])
      
      # Split inference-guessing model equation at the "+" sign
      splitSpecInferenceGuessing <- strsplit(specInferenceGuessing[j - 1], split = " [+] ")
      
      # For each branch leading to the original category in the inference-guessing model
      for (k in 1:length(splitSpecInferenceGuessing[[1]])) {
        # If the string corresponding to the output category is still empty
        if (specRelevanceInferenceGuessing[indexCategory] == "") {
          # Set string to formula Independence model * formula Inference model
          specRelevanceInferenceGuessing[indexCategory] <- paste(specIndependence[i], " * ", 
                                                splitSpecInferenceGuessing[[1]][k], 
                                                sep = "")
        } else {
          # Else, add: + formula Independence model * formula Inference model
          specRelevanceInferenceGuessing[indexCategory] <- paste(specRelevanceInferenceGuessing[indexCategory], 
                                                " + ", specIndependence[i], 
                                                " * ", 
                                                splitSpecInferenceGuessing[[1]][k], 
                                                sep = "")
        }
      }
    }      
  }
}

# Copy paste this output, and put into specRelevanceInferenceGuessingMPTinR using MPTinR format
# Delete all spaces, otherwise the input is too long and results in errors
specRelevanceInferenceGuessing

# Specification Heuristic Analytic model for the MPTinR package
specRelevanceInferenceGuessingMPTinR <- "
(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*s*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*d*(1-s)*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*d*(1-s)*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*s*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*d*s*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*d*s*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*s*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*i+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*s*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*q*nq+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*(1-d)*s*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*d*(1-s)*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*d*(1-s)*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*(1-d)*s*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*d*s*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*x*s*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*d*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*np*q*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*(1-d)*(1-s)*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*d*(1-s)*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*x*(1-s)*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*d*s*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*d*s*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*d*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*np*(1-q)*nq+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*nqf*a*c*d*(1-s)*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*nqf*a*c*d*s*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*(1-x)*d*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*(1-d)*s*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*d*s*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*d*s*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*x*s*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*nq+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*nqf*a*c*(1-d)*s*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*npf*(1-qf)*nqf*a*c*d*s*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*x*s*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*c*(1-d)*(1-s)*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*npf*qf*(1-nqf)*a*c*d*s*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*c*d*s*(1-i)+(1-pf)*npf*qf*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+(1-pf)*npf*qf*nqf*a*c*d*s*i+(1-pf)*npf*qf*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*s*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*d*(1-s)*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*d*(1-s)*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*s*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*nq+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*nqf*a*c*(1-d)*s*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*(1-npf)*(1-qf)*nqf*a*c*d*(1-s)*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*nqf*a*c*d*(1-s)*(1-i)+pf*(1-npf)*(1-qf)*nqf*a*c*(1-d)*s*(1-i)+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*c*(1-d)*(1-s)*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*(1-npf)*qf*(1-nqf)*a*c*d*(1-s)*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*x*(1-s)*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*qf*nqf*a*c*d*(1-s)*i+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*npf*(1-qf)*(1-nqf)*a*c*(1-d)*s*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*npf*(1-qf)*nqf*a*c*(1-d)*s*i+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)+pf*npf*qf*(1-nqf)*a*c*(1-d)*(1-s)*i+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*npf*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*(1-nq)
(1-pf)*(1-npf)*(1-qf)*nqf*a*c*(1-d)*(1-s)*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*x*(1-s)*i+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*q*nq+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*d*s*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*q*nq+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*np*(1-q)*nq+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*x*s*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*(1-npf)*(1-qf)*nqf*(1-a)*p*np*q*nq+(1-pf)*(1-npf)*qf*nqf*a*c*(1-d)*(1-s)*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*x*(1-s)*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*(1-npf)*qf*nqf*a*c*d*s*(1-i)+(1-pf)*(1-npf)*qf*nqf*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*np*(1-q)*nq+(1-pf)*npf*(1-qf)*nqf*a*c*(1-d)*(1-s)*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*npf*(1-qf)*nqf*a*c*d*s*(1-i)+(1-pf)*npf*(1-qf)*nqf*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*nq+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*(1-np)*q*nq+(1-pf)*npf*qf*nqf*a*c*(1-d)*(1-s)*i+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+(1-pf)*npf*qf*nqf*a*c*d*s*(1-i)+(1-pf)*npf*qf*nqf*a*c*(1-d)*(1-s)*(1-i)+(1-pf)*npf*qf*nqf*(1-a)*p*(1-np)*(1-q)*nq+pf*(1-npf)*(1-qf)*nqf*a*c*(1-d)*(1-s)*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*nq+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*x*(1-s)*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*nq+pf*(1-npf)*(1-qf)*nqf*(1-a)*(1-p)*np*q*nq+pf*(1-npf)*qf*nqf*a*c*(1-d)*(1-s)*i+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*(1-npf)*qf*nqf*a*(1-c)*x*(1-s)*i+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*np*(1-q)*nq+pf*npf*(1-qf)*nqf*a*c*(1-d)*(1-s)*i+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq+pf*npf*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*i+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*(1-np)*q*nq+pf*npf*qf*nqf*a*c*(1-d)*(1-s)*i+pf*npf*qf*nqf*(1-a)*(1-p)*(1-np)*(1-q)*nq
(1-pf)*(1-npf)*qf*(1-nqf)*a*c*(1-d)*s*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*d*(1-s)*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*a*c*(1-d)*s*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*q*nq+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*x*s*i+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*q*nq+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*np*q*(1-nq)+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*x*s*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*(1-npf)*qf*(1-nqf)*(1-a)*p*np*q*nq+(1-pf)*(1-npf)*qf*nqf*a*c*(1-d)*s*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*qf*nqf*a*c*d*(1-s)*(1-i)+(1-pf)*(1-npf)*qf*nqf*a*c*(1-d)*s*(1-i)+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*x*s*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*np*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*c*(1-d)*s*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*x*s*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*(1-np)*q*nq+(1-pf)*npf*qf*nqf*a*c*(1-d)*s*i+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+(1-pf)*npf*qf*nqf*a*(1-c)*x*s*i+(1-pf)*npf*qf*nqf*(1-a)*p*(1-np)*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*c*(1-d)*s*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+pf*(1-npf)*qf*(1-nqf)*a*c*d*(1-s)*(1-i)+pf*(1-npf)*qf*(1-nqf)*a*c*(1-d)*s*(1-i)+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*(1-a)*(1-p)*np*q*nq+pf*(1-npf)*qf*nqf*a*c*(1-d)*s*i+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*(1-npf)*qf*nqf*a*c*d*(1-s)*(1-i)+pf*(1-npf)*qf*nqf*a*c*(1-d)*s*(1-i)+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*np*q*(1-nq)+pf*npf*qf*(1-nqf)*a*c*(1-d)*s*i+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*(1-nq)+pf*npf*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*i+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*(1-np)*q*nq+pf*npf*qf*nqf*a*c*(1-d)*s*i+pf*npf*qf*nqf*(1-a)*(1-p)*(1-np)*q*(1-nq)
(1-pf)*(1-npf)*qf*nqf*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*(1-npf)*qf*nqf*(1-a)*(1-p)*np*q*nq+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*(1-np)*q*nq+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*x*s*(1-i)+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*(1-npf)*qf*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*(1-npf)*qf*nqf*(1-a)*p*np*q*nq+(1-pf)*npf*qf*nqf*a*(1-c)*(1-x)*(1-d)*i+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*(1-np)*q*nq+(1-pf)*npf*qf*nqf*(1-a)*p*(1-np)*q*nq+pf*(1-npf)*qf*nqf*a*(1-c)*(1-x)*(1-d)*i+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*(1-np)*q*nq+pf*(1-npf)*qf*nqf*(1-a)*(1-p)*np*q*nq+pf*npf*qf*nqf*a*(1-c)*(1-x)*(1-d)*i+pf*npf*qf*nqf*(1-a)*(1-p)*(1-np)*q*nq
(1-pf)*npf*(1-qf)*(1-nqf)*a*c*d*(1-s)*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*d*(1-s)*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*a*c*(1-d)*s*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*nq+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*i+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*nq+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*np*q*(1-nq)+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*x*s*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*npf*(1-qf)*(1-nqf)*(1-a)*p*np*q*nq+(1-pf)*npf*(1-qf)*nqf*a*c*d*(1-s)*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*nqf*a*c*d*(1-s)*(1-i)+(1-pf)*npf*(1-qf)*nqf*a*c*(1-d)*s*(1-i)+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*(1-x)*d*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*np*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*c*d*(1-s)*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*x*(1-s)*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*(1-x)*d*i+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*np*(1-q)*nq+(1-pf)*npf*qf*nqf*a*c*d*(1-s)*i+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+(1-pf)*npf*qf*nqf*a*(1-c)*(1-x)*d*i+(1-pf)*npf*qf*nqf*(1-a)*p*np*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*c*d*(1-s)*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+pf*npf*(1-qf)*(1-nqf)*a*c*d*(1-s)*(1-i)+pf*npf*(1-qf)*(1-nqf)*a*c*(1-d)*s*(1-i)+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+pf*npf*(1-qf)*(1-nqf)*(1-a)*(1-p)*np*q*nq+pf*npf*(1-qf)*nqf*a*c*d*(1-s)*i+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*npf*(1-qf)*nqf*a*c*d*(1-s)*(1-i)+pf*npf*(1-qf)*nqf*a*c*(1-d)*s*(1-i)+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*np*q*(1-nq)+pf*npf*qf*(1-nqf)*a*c*d*(1-s)*i+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*(1-nq)+pf*npf*qf*(1-nqf)*a*(1-c)*x*(1-s)*i+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*np*(1-q)*nq+pf*npf*qf*nqf*a*c*d*(1-s)*i+pf*npf*qf*nqf*(1-a)*(1-p)*np*(1-q)*(1-nq)
(1-pf)*npf*(1-qf)*nqf*a*(1-c)*x*(1-s)*i+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*npf*(1-qf)*nqf*(1-a)*(1-p)*np*q*nq+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*np*(1-q)*nq+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*x*s*(1-i)+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*npf*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*npf*(1-qf)*nqf*(1-a)*p*np*q*nq+(1-pf)*npf*qf*nqf*a*(1-c)*x*(1-s)*i+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*np*(1-q)*nq+(1-pf)*npf*qf*nqf*(1-a)*p*np*(1-q)*nq+pf*npf*(1-qf)*nqf*a*(1-c)*x*(1-s)*i+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*np*(1-q)*nq+pf*npf*(1-qf)*nqf*(1-a)*(1-p)*np*q*nq+pf*npf*qf*nqf*a*(1-c)*x*(1-s)*i+pf*npf*qf*nqf*(1-a)*(1-p)*np*(1-q)*nq
(1-pf)*npf*qf*(1-nqf)*a*c*d*(1-s)*(1-i)+(1-pf)*npf*qf*(1-nqf)*a*c*(1-d)*s*(1-i)+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*(1-a)*(1-p)*np*q*nq+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*np*q*(1-nq)+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*x*s*(1-i)+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*npf*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*npf*qf*(1-nqf)*(1-a)*p*np*q*nq+(1-pf)*npf*qf*nqf*a*c*d*(1-s)*(1-i)+(1-pf)*npf*qf*nqf*a*c*(1-d)*s*(1-i)+(1-pf)*npf*qf*nqf*(1-a)*(1-p)*np*q*(1-nq)+(1-pf)*npf*qf*nqf*(1-a)*p*np*q*(1-nq)+pf*npf*qf*(1-nqf)*a*c*d*(1-s)*(1-i)+pf*npf*qf*(1-nqf)*a*c*(1-d)*s*(1-i)+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*np*q*(1-nq)+pf*npf*qf*(1-nqf)*(1-a)*(1-p)*np*q*nq+pf*npf*qf*nqf*a*c*d*(1-s)*(1-i)+pf*npf*qf*nqf*a*c*(1-d)*s*(1-i)+pf*npf*qf*nqf*(1-a)*(1-p)*np*q*(1-nq)
(1-pf)*npf*qf*nqf*(1-a)*(1-p)*np*q*nq+(1-pf)*npf*qf*nqf*a*(1-c)*x*s*(1-i)+(1-pf)*npf*qf*nqf*a*(1-c)*x*(1-s)*(1-i)+(1-pf)*npf*qf*nqf*a*(1-c)*(1-x)*d*(1-i)+(1-pf)*npf*qf*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+(1-pf)*npf*qf*nqf*(1-a)*p*np*q*nq+pf*npf*qf*nqf*(1-a)*(1-p)*np*q*nq
pf*(1-npf)*(1-qf)*(1-nqf)*a*c*d*s*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*d*s*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*s*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*nq+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*i+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*nq+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*q*(1-nq)+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*s*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*(1-npf)*(1-qf)*(1-nqf)*(1-a)*p*np*q*nq+pf*(1-npf)*(1-qf)*nqf*a*c*d*s*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*x*s*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*q*(1-nq)+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*d*i+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*np*(1-q)*(1-nq)+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*np*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*c*d*s*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*c*d*s*(1-i)+pf*(1-npf)*qf*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*d*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*np*(1-q)*nq+pf*(1-npf)*qf*nqf*a*c*d*s*i+pf*(1-npf)*qf*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*(1-npf)*qf*nqf*a*(1-c)*(1-x)*d*i+pf*(1-npf)*qf*nqf*(1-a)*p*np*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*c*d*s*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*c*d*s*(1-i)+pf*npf*(1-qf)*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*x*s*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*(1-np)*q*nq+pf*npf*(1-qf)*nqf*a*c*d*s*i+pf*npf*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*npf*(1-qf)*nqf*a*(1-c)*x*s*i+pf*npf*(1-qf)*nqf*(1-a)*p*(1-np)*q*(1-nq)+pf*npf*qf*(1-nqf)*a*c*d*s*i+pf*npf*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*(1-nq)+pf*npf*qf*(1-nqf)*a*c*d*s*(1-i)+pf*npf*qf*(1-nqf)*a*c*(1-d)*(1-s)*(1-i)+pf*npf*qf*(1-nqf)*(1-a)*p*(1-np)*(1-q)*nq+pf*npf*qf*nqf*a*c*d*s*i+pf*npf*qf*nqf*(1-a)*p*(1-np)*(1-q)*(1-nq)
pf*(1-npf)*(1-qf)*nqf*a*c*d*s*(1-i)+pf*(1-npf)*(1-qf)*nqf*a*c*(1-d)*(1-s)*(1-i)+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*nq+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*(1-np)*q*nq+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*np*(1-q)*nq+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*x*s*(1-i)+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*x*(1-s)*(1-i)+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*d*(1-i)+pf*(1-npf)*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*(1-npf)*(1-qf)*nqf*(1-a)*p*np*q*nq+pf*(1-npf)*qf*nqf*a*c*d*s*(1-i)+pf*(1-npf)*qf*nqf*a*c*(1-d)*(1-s)*(1-i)+pf*(1-npf)*qf*nqf*(1-a)*p*(1-np)*(1-q)*nq+pf*(1-npf)*qf*nqf*(1-a)*p*np*(1-q)*nq+pf*npf*(1-qf)*nqf*a*c*d*s*(1-i)+pf*npf*(1-qf)*nqf*a*c*(1-d)*(1-s)*(1-i)+pf*npf*(1-qf)*nqf*(1-a)*p*(1-np)*(1-q)*nq+pf*npf*(1-qf)*nqf*(1-a)*p*(1-np)*q*nq+pf*npf*qf*nqf*a*c*d*s*(1-i)+pf*npf*qf*nqf*a*c*(1-d)*(1-s)*(1-i)+pf*npf*qf*nqf*(1-a)*p*(1-np)*(1-q)*nq
pf*(1-npf)*qf*(1-nqf)*a*(1-c)*x*s*i+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*(1-np)*q*nq+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*np*q*(1-nq)+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*x*s*(1-i)+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+pf*(1-npf)*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*(1-npf)*qf*(1-nqf)*(1-a)*p*np*q*nq+pf*(1-npf)*qf*nqf*a*(1-c)*x*s*i+pf*(1-npf)*qf*nqf*(1-a)*p*(1-np)*q*(1-nq)+pf*(1-npf)*qf*nqf*(1-a)*p*np*q*(1-nq)+pf*npf*qf*(1-nqf)*a*(1-c)*x*s*i+pf*npf*qf*(1-nqf)*(1-a)*p*(1-np)*q*(1-nq)+pf*npf*qf*(1-nqf)*(1-a)*p*(1-np)*q*nq+pf*npf*qf*nqf*a*(1-c)*x*s*i+pf*npf*qf*nqf*(1-a)*p*(1-np)*q*(1-nq)
pf*(1-npf)*qf*nqf*(1-a)*p*(1-np)*q*nq+pf*(1-npf)*qf*nqf*a*(1-c)*x*s*(1-i)+pf*(1-npf)*qf*nqf*a*(1-c)*x*(1-s)*(1-i)+pf*(1-npf)*qf*nqf*a*(1-c)*(1-x)*d*(1-i)+pf*(1-npf)*qf*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*(1-npf)*qf*nqf*(1-a)*p*np*q*nq+pf*npf*qf*nqf*(1-a)*p*(1-np)*q*nq
pf*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*i+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*np*(1-q)*nq+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*np*q*(1-nq)+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*x*s*(1-i)+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+pf*npf*(1-qf)*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*npf*(1-qf)*(1-nqf)*(1-a)*p*np*q*nq+pf*npf*(1-qf)*nqf*a*(1-c)*(1-x)*d*i+pf*npf*(1-qf)*nqf*(1-a)*p*np*(1-q)*(1-nq)+pf*npf*(1-qf)*nqf*(1-a)*p*np*q*(1-nq)+pf*npf*qf*(1-nqf)*a*(1-c)*(1-x)*d*i+pf*npf*qf*(1-nqf)*(1-a)*p*np*(1-q)*(1-nq)+pf*npf*qf*(1-nqf)*(1-a)*p*np*(1-q)*nq+pf*npf*qf*nqf*a*(1-c)*(1-x)*d*i+pf*npf*qf*nqf*(1-a)*p*np*(1-q)*(1-nq)
pf*npf*(1-qf)*nqf*(1-a)*p*np*(1-q)*nq+pf*npf*(1-qf)*nqf*a*(1-c)*x*s*(1-i)+pf*npf*(1-qf)*nqf*a*(1-c)*x*(1-s)*(1-i)+pf*npf*(1-qf)*nqf*a*(1-c)*(1-x)*d*(1-i)+pf*npf*(1-qf)*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*npf*(1-qf)*nqf*(1-a)*p*np*q*nq+pf*npf*qf*nqf*(1-a)*p*np*(1-q)*nq
pf*npf*qf*(1-nqf)*(1-a)*p*np*q*(1-nq)+pf*npf*qf*(1-nqf)*a*(1-c)*x*s*(1-i)+pf*npf*qf*(1-nqf)*a*(1-c)*x*(1-s)*(1-i)+pf*npf*qf*(1-nqf)*a*(1-c)*(1-x)*d*(1-i)+pf*npf*qf*(1-nqf)*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*npf*qf*(1-nqf)*(1-a)*p*np*q*nq+pf*npf*qf*nqf*(1-a)*p*np*q*(1-nq)
pf*npf*qf*nqf*a*(1-c)*x*s*(1-i)+pf*npf*qf*nqf*a*(1-c)*x*(1-s)*(1-i)+pf*npf*qf*nqf*a*(1-c)*(1-x)*d*(1-i)+pf*npf*qf*nqf*a*(1-c)*(1-x)*(1-d)*(1-i)+pf*npf*qf*nqf*(1-a)*p*np*q*nq
"

# Check specification - lines too long
check.mpt(textConnection(specRelevanceInferenceGuessingMPTinR))

# Save specification in relevance-inference-guessing-model.txt
check.mpt("../../txt/relevance-inference-guessing-model.txt")

