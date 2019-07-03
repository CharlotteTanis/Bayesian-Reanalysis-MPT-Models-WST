rm(list = ls())

# Set working directory to source file location
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library("ggplot2")
library("RColorBrewer")
library("colorspace")

# Load posterior probabilities
source("posterior-model-probabilities.R")

# Add column to combine experiment and group to medianPMP
medianPMP["exp_group"] <- paste("E", medianPMP$experiment, 
                                " G", medianPMP$group, sep = "")

# Change order levels method
medianPMP$method <- factor(medianPMP$method, levels = c("importance",
                                                        "bridge_normal",
                                                        "bridge_warp3"))

# Pretty names
modelNames <- c("I", "IG", "IGR", "HA", "HAR", "RIG")
names(modelNames) <- unique(medianPMP$model)
methodNames <- c("IM", "BN", "BW")

# Plot
g <- ggplot(data = medianPMP, mapping = aes(x = method,
                                            y = exp_group,
                                            fill = median_pmp)) +
  # Add tiles
  geom_tile(colour = "white") +
  # Group columns by model
  facet_grid(~ model,
             labeller = labeller(model = modelNames)) +
  # Additional theme settings
  theme(plot.margin = unit(c(0, 0, 10, 0), "pt"),
        # Hide panel borders and remove grid lines
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # Make background transparent
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.background = element_rect(fill = "transparent", colour = NA),
        legend.background = element_rect(fill = "transparent", colour = NA),
        legend.box.background = element_rect(fill = "transparent", 
                                             colour = NA),
        # Facets
        strip.text.x = element_text(size = 13),
        # Axes
        axis.title.x = element_text(size = 13,
                                    margin = margin(5, 0, 0, 0)),
        axis.title.y = element_blank(),
        axis.text = element_text(size = 12),
        axis.ticks = element_blank(),
        # Legend
        legend.position = "bottom",
        legend.margin = margin(0, 0, 0, 0),
        legend.title = element_text(size = 11,
                                    vjust = .8),
        legend.text = element_text(size = 10),
        legend.key.width = unit(44, "points")) +
  # Axes settings
  scale_x_discrete(name = "Sampling method", 
                   labels = methodNames) + 
  scale_y_discrete(limits = rev(levels(as.factor(medianPMP$exp_group)))) +
  # Fill settings
  scale_fill_gradientn(colours = colorspace::sequential_hcl(n = 10, 
                                                            h = c(250, 90), 
                                                            c = c(40, NA, 55), 
                                                            l = c(33, 98), 
                                                            power = c(0.5, 1), 
                                                            rev = TRUE),
                       name = "Posterior model probability",
                       breaks = seq(0, 1, .1),
                       limits = c(0, 1))

g

# Aspect ratio page
aspect_ratio <- 3/4
width <- 6.00117

# Save plots
ggsave("plots/posterior-model-probabilities_heatmap.pdf", g, device = "pdf", 
       width = width, height = width * aspect_ratio , units = "in")
