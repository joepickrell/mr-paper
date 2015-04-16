

pdf(file = "ff.pdf", width = 3.5)
par(mfrow = c(2,1), mar = c(0, 4, 4, 2))

plot(NA, xlim = c(0, 1), ylim = c(0, 1), axes = F, xlab = "", ylab = "")
symbols( c(0.25, 0.5, 0.75), c(0.33, 0.66, 0.33), circles = c(0.15, 0.15, 0.15), add = T, inches = F)
text(0.25, 0.33, lab = "trait", cex = 0.65)
text(0.5, 0.66, lab = "confounders", cex = 0.65)
text(0.75, 0.33, lab = "disease", cex = 0.65)
text(0.18, 0.66, lab = "G", cex = 0.65)
text(0.28, 0.7, lab = "p", cex = 0.5)
text(0.15, 0.55, lab = "1-p", cex = 0.5)

# from G->T
arrows(0.19, 0.61, 0.23, 0.49, length = 0.1)

# from G->C
arrows(0.23, 0.66, 0.33, 0.66, length = 0.1)

#from C->T
arrows(0.39, 0.54, 0.34, 0.46, length = 0.1)

#from C->D
arrows(0.6, 0.54, 0.66, 0.46, length = 0.1)
mtext("A. Simulated relationships", adj =0)


par(mar = c(5,4,2,2))
toplot = data.frame(matrix(nrow = 5, ncol = 4))
toplot[,1] = c("20000", "40000", "60000", "80000", "100000")


for (i in 1:nrow(toplot)){
	f = paste0("../allP.5percent.", toplot[i,1])
	d = read.table(f)
	m = mean(d[,2] < 0.05)
	toplot[i,2] = m
	f = paste0("../allP.", toplot[i,1])
	d = read.table(f)
	m = mean(d[,2] < 0.05)
	toplot[i,3] = m
	f = paste0("../allP.15percent.", toplot[i,1])
	d = read.table(f)
	m = mean(d[,2] < 0.05)
	toplot[i,4] = m
}


toplot[,1] = as.numeric(toplot[,1])

plot(toplot[,1]/1000, toplot[,2], ylim = c(0, 0.6), type = "b", pch = 20, xlab = "Sample size (thousands)", ylab = "Prob. of false positive")
points(toplot[,1]/1000, toplot[,3], type = "b", col = "red", pch = 20)
points(toplot[,1]/1000, toplot[,4], type = "b", col = "blue", pch = 20)	
mtext("B. Probability of false positives", adj = 0)
legend("topleft", cex = 0.7, legend = c("p = 5%", "10%", "15%"), col = c("black", "red", "blue"), pch = 20, bty = "n")
dev.off()

