rm(list = ls())

# install.packages("MPTinR")
library("MPTinR")

###############################################################################
## Choose version: normal or relaxed
###############################################################################
HAversion <- "normal"

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

# Specification Inference model
if (HAversion == "normal") {
  specInference <- c("0",                                                      # 0000
                     "c * (1 - d) * (1 - s) * i",                              # 0001       
                     "c * (1 - d) * s * i",                                    # 0010
                     "(1 - c) * (1 - x) * (1 - d) * i",                        # 0011
                     "c * d * (1 - s) * i",                                    # 0100
                     "(1 - c) * x * (1 - s) * i",                              # 0101
                     "c * d * (1 - s) * (1 - i) + c * (1 - d) * s * (1 - i)",  # 0110
                     "0",                                                      # 0111  
                     "c * d * s * i",                                          # 1000
                     "c * d * s * (1 - i) + c * (1 - d) * (1 - s) * (1 - i)",  # 1001
                     "(1 - c) * x * s * i",                                    # 1010
                     "0",                                                      # 1011
                     "(1 - c) * (1 - x) * d * i",                              # 1100
                     "0",                                                      # 1101
                     "0",                                                      # 1110
                     "(1 - c) * x * s * (1 - i) + (1 - c) * x * (1 - s) * (1 - i) + (1 - c) * (1 - x) * d * (1 - i) + (1 - c) * (1 - x) * (1 - d) * (1 - i)")  # 1111
} else {
  specInference <- c("0",                                                        # 0000
                     "c * (1 - d) * (1 - sb) * i",                               # 0001       
                     "c * (1 - d) * sb * i",                                     # 0010
                     "(1 - c) * (1 - x) * (1 - d) * i",                          # 0011
                     "c * d * (1 - sf) * i",                                     # 0100
                     "(1 - c) * x * (1 - sfb) * i",                              # 0101
                     "c * d * (1 - sf) * (1 - i) + c * (1 - d) * sb * (1 - i)",  # 0110
                     "0",                                                        # 0111  
                     "c * d * sf * i",                                           # 1000
                     "c * d * sf * (1 - i) + c * (1 - d) * (1 - sb) * (1 - i)",  # 1001
                     "(1 - c) * x * sfb * i",                                    # 1010
                     "0",                                                        # 1011
                     "(1 - c) * (1 - x) * d * i",                                # 1100
                     "0",                                                        # 1101
                     "0",                                                        # 1110
                     "(1 - c) * x * sfb * (1 - i) + (1 - c) * x * (1 - sfb) * (1 - i) + (1 - c) * (1 - x) * d * (1 - i) + (1 - c) * (1 - x) * (1 - d) * (1 - i)")  # 1111
}

# Specification Independence model
specIndependence <- c(
  "(1 - p) * (1 - np) * (1 - q) * (1 - nq)",  # 0000
  "(1 - p) * (1 - np) * (1 - q) * nq",        # 0001
  "(1 - p) * (1 - np) * q * (1 - nq)",        # 0010
  "(1 - p) * (1 - np) * q * nq",              # 0011
  "(1 - p) * np * (1 - q) * (1 - nq)",        # 0100
  "(1 - p) * np * (1 - q) * nq",              # 0101
  "(1 - p) * np * q * (1 - nq)",              # 0110
  "(1 - p) * np * q * nq",                    # 0111
  "p * (1 - np) * (1 - q) * (1 - nq)",        # 1000
  "p * (1 - np) * (1 - q) * nq",              # 1001
  "p * (1 - np) * q * (1 - nq)",              # 1010
  "p * (1 - np) * q * nq",                    # 1011
  "p * np * (1 - q) * (1 - nq)",              # 1100
  "p * np * (1 - q) * nq",                    # 1101
  "p * np * q * (1 - nq)",                    # 1110
  "p * np * q * nq"                           # 1111
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


# Initialize specification Heuristic Analytic model to 16 empty strings
specHeuristic = rep("", 16)

# For each row in combinations
for (i in 1:nrow(combinations)) {
  # For each column, except the first
  for (j in 2:ncol(combinations)) {
    # Skip if inference model has no branch leading to the original category
    if (specInference[j - 1] == "0") {
      next
    } else {
      # Index of output category
      indexCategory <- which(categories == combinations[i, j])
      
      # Split inference model equation at the "+" sign
      splitSpecInference <- strsplit(specInference[j - 1], split = " [+] ")
      
      # For each branch leading to the original category in the Inference model
      for (k in 1:length(splitSpecInference[[1]])) {
        # If the string corresponding to the output category is still empty
        if (specHeuristic[indexCategory] == "") {
          # Set string to formula Independence model * formula Inference model
          specHeuristic[indexCategory] <- paste(specIndependence[i], " * ", 
                                                splitSpecInference[[1]][k], 
                                                sep = "")
        } else {
          # Else, add: + formula Independence model * formula Inference model
          specHeuristic[indexCategory] <- paste(specHeuristic[indexCategory], 
                                                " + ", specIndependence[i], 
                                                " * ", 
                                                splitSpecInference[[1]][k], 
                                                sep = "")
        }
      }
    }      
  }
}

# Copy paste this output, and put into specHeuristicMPTinR using MPTinR format
# Delete all spaces, otherwise the input is too long and results in errors
specHeuristic

# Specification Heuristic Analytic model for the MPTinR package
specHeuristicMPTinR <- "
(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*s*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*d*s*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*s*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*(1-np)*q*(1-nq)*c*d*s*i+(1-p)*(1-np)*q*(1-nq)*c*d*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*nq*c*d*(1-s)*i+(1-p)*(1-np)*q*nq*c*d*s*i+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*s*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*(1-nq)*c*d*s*i+(1-p)*np*(1-q)*(1-nq)*c*d*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*s*i+(1-p)*np*(1-q)*nq*c*(1-d)*s*i+(1-p)*np*(1-q)*nq*c*d*s*i+(1-p)*np*(1-q)*nq*(1-c)*x*s*i+(1-p)*np*q*(1-nq)*c*(1-d)*(1-s)*i+(1-p)*np*q*(1-nq)*c*d*s*i+(1-p)*np*q*(1-nq)*c*d*s*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+(1-p)*np*q*nq*c*d*s*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*s*i+p*(1-np)*(1-q)*nq*c*d*(1-s)*i+p*(1-np)*(1-q)*nq*c*d*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*s*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*i+p*(1-np)*q*(1-nq)*c*d*(1-s)*i+p*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*i+p*(1-np)*q*nq*c*d*(1-s)*i+p*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*i+p*np*(1-q)*(1-nq)*c*(1-d)*s*i+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*(1-q)*nq*c*(1-d)*s*i+p*np*q*(1-nq)*c*(1-d)*(1-s)*i
(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*i+(1-p)*(1-np)*(1-q)*nq*c*d*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*s*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-s)*i+(1-p)*(1-np)*q*nq*(1-c)*x*(1-s)*i+(1-p)*(1-np)*q*nq*c*d*s*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-s)*i+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*nq*c*d*s*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-s)*i+(1-p)*np*q*nq*c*d*s*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*i+p*(1-np)*q*nq*c*(1-d)*(1-s)*i+p*(1-np)*q*nq*(1-c)*x*(1-s)*i+p*np*(1-q)*nq*c*(1-d)*(1-s)*i+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*(1-s)*i
(1-p)*(1-np)*q*(1-nq)*c*(1-d)*s*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*s*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*s*i+(1-p)*(1-np)*q*nq*c*d*(1-s)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*s*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*s*i+(1-p)*np*q*(1-nq)*c*(1-d)*s*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*q*(1-nq)*(1-c)*x*s*i+(1-p)*np*q*nq*c*(1-d)*s*i+(1-p)*np*q*nq*(1-c)*x*s*i+p*(1-np)*q*(1-nq)*c*(1-d)*s*i+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*(1-nq)*c*d*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*s*(1-i)+p*(1-np)*q*nq*c*(1-d)*s*i+p*(1-np)*q*nq*c*d*(1-s)*(1-i)+p*(1-np)*q*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*(1-d)*s*i+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*s*i
(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*nq*(1-c)*x*s*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*(1-c)*(1-x)*(1-d)*i
(1-p)*np*(1-q)*(1-nq)*c*d*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*np*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*(1-q)*nq*c*d*(1-s)*i+(1-p)*np*(1-q)*nq*c*d*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*s*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*np*q*(1-nq)*c*d*(1-s)*i+(1-p)*np*q*(1-nq)*(1-c)*x*(1-s)*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*q*nq*c*d*(1-s)*i+(1-p)*np*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*(1-s)*i+p*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*i+p*np*(1-q)*(1-nq)*c*d*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*s*(1-i)+p*np*(1-q)*nq*c*d*(1-s)*i+p*np*(1-q)*nq*c*d*(1-s)*(1-i)+p*np*(1-q)*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*d*(1-s)*i+p*np*q*(1-nq)*(1-c)*x*(1-s)*i+p*np*q*nq*c*d*(1-s)*i
(1-p)*np*(1-q)*nq*(1-c)*x*(1-s)*i+(1-p)*np*(1-q)*nq*(1-c)*x*s*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-s)*i+p*np*(1-q)*nq*(1-c)*x*(1-s)*i+p*np*q*nq*(1-c)*x*(1-s)*i
(1-p)*np*q*(1-nq)*c*d*(1-s)*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*s*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*s*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*c*d*(1-s)*(1-i)+(1-p)*np*q*nq*c*(1-d)*s*(1-i)+p*np*q*(1-nq)*c*d*(1-s)*(1-i)+p*np*q*(1-nq)*c*(1-d)*s*(1-i)+p*np*q*nq*c*d*(1-s)*(1-i)+p*np*q*nq*c*(1-d)*s*(1-i)
(1-p)*np*q*nq*(1-c)*x*s*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-s)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*(1-np)*(1-q)*(1-nq)*c*d*s*i+p*(1-np)*(1-q)*(1-nq)*c*d*s*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*(1-q)*nq*c*d*s*i+p*(1-np)*(1-q)*nq*(1-c)*x*s*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+p*(1-np)*q*(1-nq)*c*d*s*i+p*(1-np)*q*(1-nq)*c*d*s*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*q*nq*c*d*s*i+p*(1-np)*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*s*i+p*np*(1-q)*(1-nq)*c*d*s*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*s*i+p*np*(1-q)*nq*c*d*s*i+p*np*(1-q)*nq*(1-c)*x*s*i+p*np*q*(1-nq)*c*d*s*i+p*np*q*(1-nq)*c*d*s*(1-i)+p*np*q*(1-nq)*c*(1-d)*(1-s)*(1-i)+p*np*q*nq*c*d*s*i
p*(1-np)*(1-q)*nq*c*d*s*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*s*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*c*d*s*(1-i)+p*(1-np)*q*nq*c*(1-d)*(1-s)*(1-i)+p*np*(1-q)*nq*c*d*s*(1-i)+p*np*(1-q)*nq*c*(1-d)*(1-s)*(1-i)+p*np*q*nq*c*d*s*(1-i)+p*np*q*nq*c*(1-d)*(1-s)*(1-i)
p*(1-np)*q*(1-nq)*(1-c)*x*s*i+p*(1-np)*q*(1-nq)*(1-c)*x*s*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*(1-c)*x*s*i+p*np*q*(1-nq)*(1-c)*x*s*i+p*np*q*nq*(1-c)*x*s*i
p*(1-np)*q*nq*(1-c)*x*s*(1-i)+p*(1-np)*q*nq*(1-c)*x*(1-s)*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*(1-c)*x*s*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*i+p*np*q*(1-nq)*(1-c)*(1-x)*d*i+p*np*q*nq*(1-c)*(1-x)*d*i
p*np*(1-q)*nq*(1-c)*x*s*(1-i)+p*np*(1-q)*nq*(1-c)*x*(1-s)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*(1-nq)*(1-c)*x*s*(1-i)+p*np*q*(1-nq)*(1-c)*x*(1-s)*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*nq*(1-c)*x*s*(1-i)+p*np*q*nq*(1-c)*x*(1-s)*(1-i)+p*np*q*nq*(1-c)*(1-x)*d*(1-i)+p*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
"

specHeuristicRelaxedMPTinR <- "
(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*sf*i+(1-p)*(1-np)*(1-q)*(1-nq)*c*d*sf*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*sb*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-sf)*i+(1-p)*(1-np)*(1-q)*nq*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*d*sf*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*sfb*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-sf)*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*q*(1-nq)*c*d*sf*i+(1-p)*(1-np)*q*(1-nq)*c*d*sf*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*(1-np)*q*nq*c*d*(1-sf)*i+(1-p)*(1-np)*q*nq*c*d*sf*i+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*sb*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*(1-nq)*c*d*sf*i+(1-p)*np*(1-q)*(1-nq)*c*d*sf*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*sfb*i+(1-p)*np*(1-q)*nq*c*(1-d)*sb*i+(1-p)*np*(1-q)*nq*c*d*sf*i+(1-p)*np*(1-q)*nq*(1-c)*x*sfb*i+(1-p)*np*q*(1-nq)*c*(1-d)*(1-sb)*i+(1-p)*np*q*(1-nq)*c*d*sf*i+(1-p)*np*q*(1-nq)*c*d*sf*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*q*nq*c*d*sf*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+p*(1-np)*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*sb*i+p*(1-np)*(1-q)*nq*c*d*(1-sf)*i+p*(1-np)*(1-q)*nq*c*d*(1-sf)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*sb*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*i+p*(1-np)*q*(1-nq)*c*d*(1-sf)*i+p*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*i+p*(1-np)*q*nq*c*d*(1-sf)*i+p*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*i+p*np*(1-q)*(1-nq)*c*(1-d)*sb*i+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*(1-q)*nq*c*(1-d)*sb*i+p*np*q*(1-nq)*c*(1-d)*(1-sb)*i
(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*(1-q)*nq*c*d*sf*(1-i)+(1-p)*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-sb)*i+(1-p)*(1-np)*q*nq*(1-c)*x*(1-sfb)*i+(1-p)*(1-np)*q*nq*c*d*sf*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-sb)*i+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*np*(1-q)*nq*c*d*sf*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-sb)*i+(1-p)*np*q*nq*c*d*sf*(1-i)+(1-p)*np*q*nq*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*i+p*(1-np)*q*nq*c*(1-d)*(1-sb)*i+p*(1-np)*q*nq*(1-c)*x*(1-sfb)*i+p*np*(1-q)*nq*c*(1-d)*(1-sb)*i+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*(1-sb)*i
(1-p)*(1-np)*q*(1-nq)*c*(1-d)*sb*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*q*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*sfb*i+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*sb*i+(1-p)*(1-np)*q*nq*c*d*(1-sf)*(1-i)+(1-p)*(1-np)*q*nq*c*(1-d)*sb*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*sfb*i+(1-p)*np*q*(1-nq)*c*(1-d)*sb*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+(1-p)*np*q*(1-nq)*(1-c)*x*sfb*i+(1-p)*np*q*nq*c*(1-d)*sb*i+(1-p)*np*q*nq*(1-c)*x*sfb*i+p*(1-np)*q*(1-nq)*c*(1-d)*sb*i+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*(1-nq)*c*d*(1-sf)*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*sb*(1-i)+p*(1-np)*q*nq*c*(1-d)*sb*i+p*(1-np)*q*nq*c*d*(1-sf)*(1-i)+p*(1-np)*q*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*(1-d)*sb*i+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*c*(1-d)*sb*i
(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+(1-p)*(1-np)*q*nq*(1-c)*x*sfb*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*i+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*i+p*np*q*nq*(1-c)*(1-x)*(1-d)*i
(1-p)*np*(1-q)*(1-nq)*c*d*(1-sf)*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*np*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*np*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*(1-q)*nq*c*d*(1-sf)*i+(1-p)*np*(1-q)*nq*c*d*(1-sf)*(1-i)+(1-p)*np*(1-q)*nq*c*(1-d)*sb*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*i+(1-p)*np*q*(1-nq)*c*d*(1-sf)*i+(1-p)*np*q*(1-nq)*(1-c)*x*(1-sfb)*i+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*i+(1-p)*np*q*nq*c*d*(1-sf)*i+(1-p)*np*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*(1-sf)*i+p*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*i+p*np*(1-q)*(1-nq)*c*d*(1-sf)*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*sb*(1-i)+p*np*(1-q)*nq*c*d*(1-sf)*i+p*np*(1-q)*nq*c*d*(1-sf)*(1-i)+p*np*(1-q)*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*d*(1-sf)*i+p*np*q*(1-nq)*(1-c)*x*(1-sfb)*i+p*np*q*nq*c*d*(1-sf)*i
(1-p)*np*(1-q)*nq*(1-c)*x*(1-sfb)*i+(1-p)*np*(1-q)*nq*(1-c)*x*sfb*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-sfb)*i+p*np*(1-q)*nq*(1-c)*x*(1-sfb)*i+p*np*q*nq*(1-c)*x*(1-sfb)*i
(1-p)*np*q*(1-nq)*c*d*(1-sf)*(1-i)+(1-p)*np*q*(1-nq)*c*(1-d)*sb*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*sfb*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+(1-p)*np*q*nq*c*d*(1-sf)*(1-i)+(1-p)*np*q*nq*c*(1-d)*sb*(1-i)+p*np*q*(1-nq)*c*d*(1-sf)*(1-i)+p*np*q*(1-nq)*c*(1-d)*sb*(1-i)+p*np*q*nq*c*d*(1-sf)*(1-i)+p*np*q*nq*c*(1-d)*sb*(1-i)
(1-p)*np*q*nq*(1-c)*x*sfb*(1-i)+(1-p)*np*q*nq*(1-c)*x*(1-sfb)*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*d*(1-i)+(1-p)*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*(1-np)*(1-q)*(1-nq)*c*d*sf*i+p*(1-np)*(1-q)*(1-nq)*c*d*sf*(1-i)+p*(1-np)*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*(1-q)*nq*c*d*sf*i+p*(1-np)*(1-q)*nq*(1-c)*x*sfb*i+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*i+p*(1-np)*q*(1-nq)*c*d*sf*i+p*(1-np)*q*(1-nq)*c*d*sf*(1-i)+p*(1-np)*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*i+p*(1-np)*q*nq*c*d*sf*i+p*(1-np)*q*nq*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*c*d*sf*i+p*np*(1-q)*(1-nq)*c*d*sf*(1-i)+p*np*(1-q)*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*sfb*i+p*np*(1-q)*nq*c*d*sf*i+p*np*(1-q)*nq*(1-c)*x*sfb*i+p*np*q*(1-nq)*c*d*sf*i+p*np*q*(1-nq)*c*d*sf*(1-i)+p*np*q*(1-nq)*c*(1-d)*(1-sb)*(1-i)+p*np*q*nq*c*d*sf*i
p*(1-np)*(1-q)*nq*c*d*sf*(1-i)+p*(1-np)*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*sfb*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*c*d*sf*(1-i)+p*(1-np)*q*nq*c*(1-d)*(1-sb)*(1-i)+p*np*(1-q)*nq*c*d*sf*(1-i)+p*np*(1-q)*nq*c*(1-d)*(1-sb)*(1-i)+p*np*q*nq*c*d*sf*(1-i)+p*np*q*nq*c*(1-d)*(1-sb)*(1-i)
p*(1-np)*q*(1-nq)*(1-c)*x*sfb*i+p*(1-np)*q*(1-nq)*(1-c)*x*sfb*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*(1-np)*q*nq*(1-c)*x*sfb*i+p*np*q*(1-nq)*(1-c)*x*sfb*i+p*np*q*nq*(1-c)*x*sfb*i
p*(1-np)*q*nq*(1-c)*x*sfb*(1-i)+p*(1-np)*q*nq*(1-c)*x*(1-sfb)*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*d*(1-i)+p*(1-np)*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*i+p*np*(1-q)*(1-nq)*(1-c)*x*sfb*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*i+p*np*q*(1-nq)*(1-c)*(1-x)*d*i+p*np*q*nq*(1-c)*(1-x)*d*i
p*np*(1-q)*nq*(1-c)*x*sfb*(1-i)+p*np*(1-q)*nq*(1-c)*x*(1-sfb)*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*d*(1-i)+p*np*(1-q)*nq*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*(1-nq)*(1-c)*x*sfb*(1-i)+p*np*q*(1-nq)*(1-c)*x*(1-sfb)*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*d*(1-i)+p*np*q*(1-nq)*(1-c)*(1-x)*(1-d)*(1-i)
p*np*q*nq*(1-c)*x*sfb*(1-i)+p*np*q*nq*(1-c)*x*(1-sfb)*(1-i)+p*np*q*nq*(1-c)*(1-x)*d*(1-i)+p*np*q*nq*(1-c)*(1-x)*(1-d)*(1-i)
"

# Check specification
check.mpt(textConnection(specHeuristicMPTinR))
check.mpt(textConnection(specHeuristicRelaxedMPTinR))
