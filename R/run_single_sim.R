source("sim.R")

a = commandArgs(T)

Nind = as.numeric(a[1])
Nsnp = as.numeric(a[2])
pi = as.numeric(a[3])
cutoff = as.numeric(a[4])
V1 = as.numeric(a[5])
V2 = as.numeric(a[6])
rho = as.numeric(a[7])
FF = as.numeric(a[8])
outfile = a[9]

a = simall(Nind = Nind, Nsnp = Nsnp, pi = pi, cutoff = cutoff, V1 = V1, V2 = V2, rho = rho, F = FF)

print(summary(a$lm))
d = data.frame(matrix(nrow = 5, ncol = 2))
d[1,1] = "logistic_beta"
d[1,2] = summary(a$lm)$coef[2,1]
d[2,1] = "logistic_se"
d[2,2] = summary(a$lm)$coef[2,2]
d[3,1] = "logistic_P"
d[3,2] = summary(a$lm)$coef[2,4]
d[4,1] = "sum_vexpl_1"
d[4,2] = sum(a$snps$vexpl1)
d[5,1] = "sum_vexpl_2"
d[5,2] = sum(a$snps$vexpl2)

print(d)
write.table(d, file = outfile, quote = F, row.names = F, col.names = F)

