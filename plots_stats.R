#!/usr/bin/env RScript

args <- commandArgs(trailingOnly = FALSE)
myargument <- args[length(args)]
myargument <- sub("-","", myargument)
print(myargument)

#Install, load all libraries
install.packages("RcppCNPy", repos = "http://cloud.r-project.org/")
install.packages("dbscan", repos = "http://cloud.r-project.org/")
install.packages("lattice", repos = "http://cloud.r-project.org/")
library(RcppCNPy)
library(dbscan)
library(lattice)

#Load distance matrix, cluster
filepath <- paste('/home/achitturi/Desktop/', myargument, "-structures/", sep="")
string1 <- paste(filepath, "dist_mat_.npy", sep="")
dist_mat <- npyLoad(string1)
res <- dbscan(dist_mat, eps = .7, minPts = 5)

#Load scores and RMSD values
string2 <- paste(filepath, "revised_scores.txt", sep="")
revised_scores <- read.table(string2)
string3 <- paste(filepath, myargument, ".native.sc", sep="")
test_native <- read.csv(string3, sep="")

#Score vs. RMSD
test_data <- cbind.data.frame(test_native$rms, revised_scores$V2)
colnames(test_data) <- cbind("RMS", "score")
string4 <- paste(filepath, "score_vs_RMSD.jpg", sep="")
jpeg(string4, width = 640, height = 480, units = "px", pointsize = 15)
plot(test_data, col=res$cluster, main="RMSD vs. score", xlim=c(.1, 1), ylim=c(-98, -40))
points(test_data[res$cluster==0,], pch=3, col="grey")
dev.off()

#MDS
string5 <- paste(filepath, "MDSclustering.jpg", sep="")
jpeg(string5, width = 640, height = 640, units = "px", pointsize = 15)
mds <- cmdscale(dist_mat, k=2, eig=FALSE)
plot(mds[,1], mds[,2], col=res$cluster, main="MDS clustering", xlim=c(-.6, .6), ylim=c(-.6, .6))
dev.off()

#Hullplot
string6 <- paste(filepath, "Hullplot.jpg", sep="")
jpeg(string6, width = 640, height = 480, units = "px", pointsize = 15)
hullplot(test_data, res, xlim=c(.1, 1), ylim=c(-98, -40))
dev.off()

#Separate cluster plots (noise = 0)
test_cl <- cbind.data.frame(test_data, res$cluster)
colnames(test_cl) <- cbind("RMS", "score", "cluster")
string7 <- paste(filepath, "Clusterplot.jpg", sep="")
jpeg(string7, width = 640, height = 480, units = "px", pointsize = 15)
xyplot(score ~ RMS | cluster, test_cl, group=cluster, grid=TRUE, main = "Cluster plot", ylim=c(-98, -40), xlim=c(.1, 1))
dev.off()