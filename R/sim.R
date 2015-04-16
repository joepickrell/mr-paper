library(mvtnorm)


simall = function(Nind, Nsnp, pi, cutoff = 0.0003, V1 = 0.005, V2 = 0.005, rho = 0, F = 0.1){
	# Nind = number of individuals
	# Nsnp = number of SNPs
	# pi = proportion w/o effect on pheno 2
	# cutoff  = minimum variance explained for pheno 1
	# V1  = variance in beta_1
        # V2 = variance in beta_2
        # rho = correlation btw beta_1, beta_2

	snps = sim_snps(Nsnp, pi, cutoff, V1, V2, rho)
	inds = sim_inds(Nind, snps, F)
	lm = glm(inds$case ~ inds$score1, family = "binomial")
	return(list("snps" = snps, "inds" = inds, "lm" = lm))
}



sim_inds = function(Nind, snps, F){
	# Nind: number of individuals
	# snps: data frame with SNP info
	# F: proportion of population that are cases

	toreturn = data.frame(matrix(nrow = Nind, ncol = 4))
	names(toreturn) = c("score1", "score2", "score_wenv", "case")
	for (i in 1:Nind){
		toreturn[i,] = sim_ind(snps)
	}
	evar = 1 - sum(snps$beta2* snps$beta2 * snps$freq*2*(1-snps$freq))
	toreturn$score_wenv = sapply(toreturn$score2, FUN = function(x){ return(rnorm(1, mean = x, sd = sqrt(evar)))})
	q = quantile(toreturn$score_wenv, prob = 1-F)
	toreturn$case = 0
	toreturn[toreturn$score_wenv > q,]$case = 1
	return(toreturn)
}


sim_ind = function(snps){
	# snps: data frame with snp info

	genos = sapply(snps$f, FUN = function(x){ return( rbinom(1, 2, x))})
	score1 = sum( genos*snps$beta1 )
	score2 = sum(genos*snps$beta2 )
	return( c(score1, score2))
}

sim_snps = function(Nsnp, pi, cutoff, V1, V2, rho){
	# Nsnp: number of SNPs
	# pi = proportion w/o effect on pheno 2
	# cutoff = minimum variance explained for pheno 1
	# V1  = variance in beta_1
	# V2 = variance in beta_2
	# rho = correlation btw beta_1, beta_2

	Sigma = matrix(nrow = 2, ncol = 2)
	Sigma[1,1] = V1
	Sigma[1,2] = sqrt(V1)*sqrt(V2)*rho
	Sigma[2,1] = Sigma[1,2]
	Sigma[2,2] = V2
	toreturn = data.frame(matrix(nrow = Nsnp, ncol = 5))
	names(toreturn) = c("freq", "beta1", "beta2", "vexpl1", "vexpl2")
	for (i in 1:Nsnp){
		toreturn[i,1:3] = sim_snp(pi, cutoff, Sigma) 

	}	
	toreturn$vexpl1 = toreturn$beta1*toreturn$beta1*2*toreturn$freq*(1-toreturn$freq)
	toreturn$vexpl2 = toreturn$beta2*toreturn$beta2*2*toreturn$freq*(1-toreturn$freq)
	
	return(toreturn)

}

sim_snp = function(pi, cutoff, Sigma){
	# pi = proportion of SNPs that do not have an effect on pheno 2
	# cutoff = minimum variance explained for pheno 1
	# Sigma = covariance matrix of effect sizes for beta1, beta2

	done = F
	f = 0
	beta1 = 0
	beta2 = 0
	while (done == F){
		f = rbeta(1, 0.5, 0.5)
		betas = rmvnorm(1, mean = c(0, 0), sigma = Sigma)
		beta1 = betas[1]
		beta2 = betas[2]
		vexpl = beta1*beta1*2*f*(1-f)
		if (vexpl > cutoff){
			done = T
		}
	}
	ru = runif(1)
	if (ru < pi){
		beta2 = 0
	}
	return( c(f, beta1, beta2)) 
}
