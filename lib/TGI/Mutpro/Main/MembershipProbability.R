#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

d <- read.table(args[1], header=TRUE)

library(ggplot2)

d$Variant <- factor(d$Variant, levels = d$Variant)

sp <- ggplot(d, aes(x=Variant,y=ClusterID)) + geom_point(aes(colour = Probability), size=3) + scale_colour_gradient(low = "red", high = "blue")
sp <- sp+ facet_grid(SuperClusterID ~ .,as.table = FALSE,scales="free_y",space="free_y")
#sp <- ggplot(d, aes(x=Variant,y=ClusterID)) + geom_point(aes(size=Probability))

sp+theme_bw() + theme(axis.text.x=element_text(angle=90, size=6)) + ggtitle(paste("Cluster Membership Probabilities for",args[2],"runs (",args[3],")"))
ggsave(paste(args[3],"ProbabilityPlot.pdf", sep = "."), width = 23.6, height = 13.3)

#args 1=ProbabilityData, 2=Number of runs, 3=Gene 