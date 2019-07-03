###############################################################################
## Data from all experiments in Klauer (2007)
###############################################################################

# Number of possible response patterns
nResponsePatterns <- 16
# Possible response patterns
responsePatterns <- c("0000", "0001", "0010", "0011", "0100", "0101", "0110",
                      "0111", "1000", "1001", "1010", "1011","1100", "1101",
                      "1110", "1111")
# Number of experiments
nExp <- 6

# Number of groups per experiment
nGroups <- c(2, 2, 2, 2, 4, 4)
nGroupsTot <- sum(nGroups)

# Vector of group numbers
groupNo <- numeric(0)
for (i in 1:length(nGroups)) {
  groupNo <- c(groupNo, rep(1:nGroups[i], each = nResponsePatterns))
}

# Vector of experiments
expNo <- rep(1:nExp, times = nGroups * nResponsePatterns)

# Frequency responses
freqExp1Group1 <- c(10, 6, 20, 3, 7, 11, 1, 1, 
                    96, 11, 106, 4, 5, 1, 1, 17)
freqExp1Group2 <- c(5, 4, 29, 4, 8, 18, 6, 0,
                    87, 22, 91, 11, 6, 1, 1, 28)
freqExp2Group1 <- c(13, 7, 20, 4, 11, 13, 4, 1, 
                    104, 12, 113, 1, 6, 2, 0, 11)
freqExp2Group2 <- c(5, 9, 11, 9, 13, 11, 7, 8, 
                    112, 36, 49, 6, 11, 1, 1, 11)
freqExp3Group1 <- c(9, 11, 28, 4, 10, 20, 4, 2,
                    95, 16, 109, 5, 4, 2, 1, 15)
freqExp3Group2 <- c(16, 21, 33, 4, 5, 2, 2, 0, 
                    134, 12, 49, 7, 7, 1, 3, 4)
freqExp4Group1 <- c(11, 8, 17, 4, 4, 17, 1, 2, 
                    92, 10, 111, 4, 5, 0, 2, 12)
freqExp4Group2 <- c(12, 9, 42, 5, 14, 4, 0, 0, 
                    126, 7, 59, 16, 1, 0, 1, 5)
freqExp5Group1 <- c(9, 7, 26, 2, 5, 16, 3, 2,
                    112, 11, 131, 1, 5, 1, 2, 12)
freqExp5Group2 <- c(9, 9, 24, 3, 5, 19, 0, 3,
                    132, 11, 101, 2, 3, 1, 5, 12)
freqExp5Group3 <- c(8, 7, 67, 11, 5, 10, 2, 1, 
                    54, 23, 99, 13, 5, 2, 1, 16)
freqExp5Group4 <- c(14, 8, 64, 13, 8, 29, 5, 2,
                    46, 16, 59, 10, 5, 3, 2, 16)
freqExp6Group1 <- c(19, 12, 31, 9, 16, 15, 9, 5, 
                    61, 19, 81, 7, 6, 0, 0, 19)
freqExp6Group2 <- c(15, 13, 24, 7, 9, 5, 5, 1, 
                    63, 30, 93, 15, 2, 0, 1, 17)
freqExp6Group3 <- c(13, 17, 16, 7, 11, 17, 5, 1,
                    85, 18, 70, 6, 19, 8, 4, 21)
freqExp6Group4 <- c(12, 7, 25, 5, 10, 10, 5, 0, 
                    67, 15, 95, 10, 11, 2, 9, 27)

freqAllExp <- c(freqExp1Group1, freqExp1Group2, 
                freqExp2Group1, freqExp2Group2,
                freqExp3Group1, freqExp3Group2,
                freqExp4Group1, freqExp4Group2,
                freqExp5Group1, freqExp5Group2, freqExp5Group3, freqExp5Group4,
                freqExp6Group1, freqExp6Group2, freqExp6Group3, freqExp6Group4)

# Data from Klauer, Stahl, & Erdfelder (2007)
dat <- data.frame(expNo = expNo,
                  group = groupNo,
                  resp = rep(responsePatterns, sum(nGroups[1:nExp])),
                  freq = freqAllExp,
                  stringsAsFactors = FALSE)

datCombinedGroups <- dat

# Add 1 to each frequency if there is a cell that has a unobserved frequency
# For dat this is done on a group level
# For datCombinedGroups this is done on an experiment level
for (exp in 1:nExp) {
  frequenciesCombined <- dat$freq[dat$expNo == exp]
  if (sum(frequenciesCombined == 0) > 0) {
    frequenciesCombined <- frequenciesCombined + 1
  }
  # Update datCombinedGroups
  datCombinedGroups$freq[dat$expNo == exp] <- frequenciesCombined
  
  for (group in 1:nGroups[exp]) {
    # Frequencies of dataset
    frequencies <- dat$freq[dat$expNo == exp & dat$group == group]
    # If there is a cell with 0
    if (sum(frequencies == 0) > 0) {
      # Add 1 to all frequencies
      frequencies <- frequencies + 1
      # Update dat
      dat$freq[dat$expNo == exp & dat$group == group] <- frequencies
    }
  }
}

# Vectors of groups and experiments for results at later stage
groups <- numeric(0)
for (i in 1:length(nGroups)) {
  groups <- c(groups, 1:nGroups[i])
}
experiments <- rep(1:nExp, times = nGroups[1:nExp])

# Remove seperate frequencies vectors and unneccary objects
rm("freqExp1Group1", "freqExp1Group2", "freqExp2Group1", "freqExp2Group2",
   "freqExp3Group1", "freqExp3Group2", "freqExp4Group1", "freqExp4Group2",
   "freqExp5Group1", "freqExp5Group2", "freqExp5Group3", "freqExp5Group4",
   "freqExp6Group1", "freqExp6Group2", "freqExp6Group3", "freqExp6Group4",
   "freqAllExp", "frequencies", "frequenciesCombined", "exp", "group", "i",
   "expNo", "groupNo")

