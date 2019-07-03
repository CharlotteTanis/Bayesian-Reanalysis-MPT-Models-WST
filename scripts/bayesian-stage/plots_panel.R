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

# List for plots
plots <- vector("list", nGroupsTot)

# Plot results for each experiment and group
counter <- 1
for (i in 1:nExp) {
  for (j in 1:nGroups[i]) {
    
    # Only show y axis title and labels on left plots
    if (counter %% 2 == 1) {
      yAxisTitle <- element_blank() # element_text(angle = 90, vjust = 0.5, size = 11, 
                                 # margin = margin(0, 10, 0, 0))
      # yAxisTitle <- element_blank()
      yAxisLabels <- element_text(size = 12)
    } else {
      yAxisTitle <- element_blank()
      yAxisLabels <- element_blank()
    }
    
    # Only show x axis labels on bottom plots
    if (counter %in% c(7, 8, 15, 16)) {
      xAxisLabels <- element_text(size = 12)
    } else {
      xAxisLabels <- element_blank()
    }
    
    # Fill list of plots, one plot per experiment and group
    plots[[counter]] <- ggplot(postMProb[postMProb$experiment == i & 
                                           postMProb$group == j, ], 
                               aes(x = model, 
                                   y = post_model_prob, 
                                   shape = method)) + 
      # Grey points of all repetitions
      geom_point(size = 2, 
                 fill = "#ffffff",
                 color = "#bbbbbb", 
                 position = dodge) +
      # Black points of median
      geom_point(data = medianPMP[medianPMP$experiment == i & 
                                    medianPMP$group == j, ],
                 mapping = aes(x = model,
                               y = median_pmp,
                               shape = method),
                 size = 2,
                 fill = "black",
                 position = dodge) +
      # Title
      ggtitle(paste("Experiment ", i, ", group ", j, sep = "")) +
      # Fix height/width ratio
      coord_fixed(ratio = 9/16 * nModels) + 
      # Remove background and grid
      theme_classic() +
      # Additional theme settings
      theme(plot.margin = unit(c(0, 0, 0, 0), "cm"),
            plot.title = element_text(margin = margin(10, 0, 5, 0)),
            axis.title.x = element_blank(),
            axis.title.y = yAxisTitle,
            axis.line.x = element_blank(),
            axis.text.x = xAxisLabels,
            axis.text.y = yAxisLabels,
            axis.ticks.x = element_blank(),
            legend.position = "none",
            legend.title = element_text(size = 11),
            legend.text = element_text(size = 10)) +
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
    # Update counter
    counter <- counter + 1
  }
}

# Legend ----------------------------------------------------------------------
legendG <- ggplotGrob(plots[[1]] + theme(legend.position = "bottom"))$grobs
legend <- legendG[[which(sapply(legendG, function(x) x$name) == "guide-box")]]
lheight <- sum(legend$height)

# Combine plots in gtable -----------------------------------------------------
# Empty gtable
g <- gtable(widths = unit(c(1, 1), 'null'), 
            heights = unit.c(unit(1, "npc") - lheight, lheight))

# Add legend to bottom row, spanning both columns
g <- gtable_add_grob(g, legend, t = 2, l = 1, r = 2)

# First page, first column of plots
g1 <- gtable_add_grob(g, rbind(ggplotGrob(plots[[1]]), 
                               ggplotGrob(plots[[3]]),
                               ggplotGrob(plots[[5]]), 
                               ggplotGrob(plots[[7]]),
                               size = "last"),
                      t = 1, l = 1)

# First page, second column of plots
g1 <- gtable_add_grob(g1, rbind(ggplotGrob(plots[[2]]), 
                                ggplotGrob(plots[[4]]),
                                ggplotGrob(plots[[6]]), 
                                ggplotGrob(plots[[8]]),
                                size = "last"),
                      t = 1, l = 2)

# Second page, first column of plots
g2 <- gtable_add_grob(g, rbind(ggplotGrob(plots[[9]]), 
                               ggplotGrob(plots[[11]]),
                               ggplotGrob(plots[[13]]), 
                               ggplotGrob(plots[[15]]),
                               size = "last"),
                      t = 1, l = 1)

# Second page, second column of plots
g2 <- gtable_add_grob(g2, rbind(ggplotGrob(plots[[10]]), 
                                ggplotGrob(plots[[12]]),
                                ggplotGrob(plots[[14]]), 
                                ggplotGrob(plots[[16]]),
                                size = "last"),
                      t = 1, l = 2)

# Aspect ratio page
width <- 5.79
aspect_ratio <- 4/3

# Save plots
ggsave("plots/posterior-model-probabilities_plot1-8.pdf", g1, device = "pdf", 
       width = width, height = width * aspect_ratio , units = "in")
ggsave("plots/posterior-model-probabilities_plot9-16.pdf", g2, device = "pdf", 
       width = width, height = width * aspect_ratio, units = "in")




