

pdf(file = "wcor.pdf")
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

plot(toplot[,1]/1000, toplot[,2], ylim = c(0, 1), type = "b", pch = 20, xlab = "Sample size (thousands)", ylab = "Prob. of false positive")
points(toplot[,1]/1000, toplot[,3], type = "b", col = "red", pch = 20)
points(toplot[,1]/1000, toplot[,4], type = "b", col = "blue", pch = 20)	


toplot = data.frame(matrix(nrow = 5, ncol = 4))
toplot[,1] = c("20000", "40000", "60000", "80000", "100000")


for (i in 1:nrow(toplot)){
        f = paste0("../allP.5percent.wcor.", toplot[i,1])
        d = read.table(f)
        m = mean(d[,2] < 0.05)
        toplot[i,2] = m
        f = paste0("../allP.wcor.", toplot[i,1])
        d = read.table(f)
        m = mean(d[,2] < 0.05)
        toplot[i,3] = m
        f = paste0("../allP.15percent.wcor.", toplot[i,1])
        d = read.table(f)
        m = mean(d[,2] < 0.05)
        toplot[i,4] = m
}
toplot[,1] = as.numeric(toplot[,1])
points(toplot[,1]/1000, toplot[,2], type = "b", lty = 2)
points(toplot[,1]/1000, toplot[,3], type = "b", col = "red", lty = 2)
points(toplot[,1]/1000, toplot[,4], type = "b", col = "blue",lty = 2)

legend("topleft", cex = 0.7, legend = c("p = 5% (uncorrelated)", "10% (uncorrelated)", "15% (uncorrelated)", "5% (correlated)", "10% (correlated)", "15% (correlated)" ), col = c("black", "red", "blue", "black", "red", "blue"), pch =  c(20, 20, 20, 1, 1, 1), bty = "n")
dev.off()

