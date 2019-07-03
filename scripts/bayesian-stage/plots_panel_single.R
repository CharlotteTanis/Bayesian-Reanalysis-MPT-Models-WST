rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("ggplot2")
library("grid")
library("gtable")

# Load posterior probabilities
source("posterior-model-probabilities.R")

# List of plots ---------------------------------------------------------------
# Pretty model names
modelNames <- c("I", "IG", "IGR", "HA", "HAR", "RIG")

# Make sure that points do not overlap
dodge <- position_dodge(width = .9) 

i = 4
j = 2

g <- ggplot(postMProb[postMProb$experiment == i & 
                        postMProb$group == j, ], 
            aes(x = model, 
                y = post_model_prob, 
                shape = method)) + 
  # Grey points of all repetitions
  geom_point(size = 2, 
             fill = "#ffffff",
             color = "#bbbbbb", 
             position = dodge,
             stroke = 1) +
  # Blue points of median
  geom_point(data = medianPMP[medianPMP$experiment == i & 
                                medianPMP$group == j, ],
             mapping = aes(x = model,
                           y = median_pmp,
                           shape = method),
             size = 2,
             fill = "#000000",
             color = "#000000",
             position = dodge,
             stroke = 1) +
  # Title
  ggtitle(paste("Experiment ", i, ", group ", j, sep = "")) +

  theme_classic() +
  # Additional theme settings
  theme(plot.margin = unit(c(0, 0, 10, 0), "pt"),
        plot.title = element_text(margin = margin(0, 0, 10, 0)),
        axis.title.x = element_text(size = 13,
                                    margin = margin(10, 0, 0, 0)),
        axis.title.y = element_text(angle = 90, vjust = 0.5, size = 13, 
                                    margin = margin(0, 10, 0, 0)),
        axis.line.x = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.ticks.x = element_blank(),
        legend.title = element_text(size = 11),
        legend.text = element_text(size = 10,
                                   margin = margin(5, 0, 5, 0))) +
  # Axes settings
  scale_x_discrete(name = "Model", 
                   labels = modelNames) + 
  scale_y_continuous(name = "Posterior model probability", 
                     breaks = seq(0, 1, by = .2), 
                     limits = c(0, 1)) +
  # Legend settings, will be added in grid
  scale_shape_manual(values = c(21, 24, 22),
                     name = "Sampling method",
                     labels = c("Importance", "Bridge-normal", 
                                "Bridge-Warp-III"))

g

# Aspect ratio page
width = 6.00117
aspect_ratio <- 9/16

# Save plots
ggsave(paste("plots/posterior-model-probabilities_exp", i, "group", j, 
             "_single.pdf", sep = ""), g, device = "pdf", 
       width = width, height = width * aspect_ratio , units = "in")
