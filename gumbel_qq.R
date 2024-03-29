library(extRemes)
library(ordinal)
load('pY_ro.gzip')
load('pY_mcmc_ro.gzip')
load('gumbel_pY_ro.gzip')
load('gumbel_pY_mcmc_ro.gzip')
pY             <- pY_ro
pY_mcmc        <- pY_mcmc_ro
gumbel_pY      <- gumbel_pY_ro
gumbel_pY_mcmc <- gumbel_pY_mcmc_ro
set.seed(2345)
Ns <- dim(pY_ro)[1]

# Single Site Gumbel QQPlot ---------------------------------------------------------------------------

## with GEV-fit marginal parameters
s <- floor(runif(1, min = 1, max = Ns+1)) # note that in R index starts from 1
gumbel_s = sort(gumbel_pY[s,])
nquants = length(gumbel_s)
emp_p = seq(1/nquants, 1-1/nquants, length=nquants)
emp_q = qgumbel(emp_p)
# plot(gumbel_s, emp_q)
# abline(a = 0, b = 1)
qq_gumbel_s <- extRemes::qqplot(gumbel_s, emp_q, regress=FALSE, legend=NULL,
                                xlab="Observed", ylab="Gumbel", main=paste("GEVfit-QQPlot of Site:",s),
                                lwd=3)
pdf(file=paste("R_GEVfit-QQPlot_Site_",s,".pdf", sep=""), width = 6, height = 5)
par(mgp=c(1.5,0.5,0), mar=c(3,3,1,1))
plot(type="n",qq_gumbel_s$qdata$x, qq_gumbel_s$qdata$y, pch = 20, xlab="Observed", ylab="Gumbel")
points(qq_gumbel_s$qdata$x, qq_gumbel_s$qdata$y, pch=20)
lines(qq_gumbel_s$qdata$x, qq_gumbel_s$qdata$lower, lty=2, col="blue", lwd=3)
lines(qq_gumbel_s$qdata$x, qq_gumbel_s$qdata$upper, lty=2, col="blue", lwd=3)
abline(a=0, b=1, lty=3, col="gray80", lwd=3)
legend("topleft", lty=c(2, 3), lwd=3, legend=c("95% confidence bands", "1:1 line"), col=c("blue", "gray80"), bty="n")
dev.off()

## with Copula Model fit marginal parameters
# s <- floor(runif(1, min = 1, max = Ns+1)) # note that in R index starts from 1
gumbel_s_mcmc = sort(apply(gumbel_pY_mcmc[,s,],2, mean))
nquants = length(gumbel_s_mcmc)
emp_p = seq(1/nquants, 1-1/nquants, length=nquants)
emp_q = qgumbel(emp_p)
# plot(gumbel_s_mcmc, emp_q)
# abline(a = 0, b = 1)
qq_gumbel_s_mcmc <- extRemes::qqplot(gumbel_s_mcmc, emp_q, regress=FALSE, legend=NULL,
                                xlab="Observed", ylab="Gumbel", main=paste("Modelfit-QQPlot of Site:",s),
                                lwd=3)
pdf(file=paste("R_Modelfit-QQPlot_Site_",s,".pdf", sep=""), width = 6, height = 5)
par(mgp=c(1.5,0.5,0), mar=c(3,3,1,1))
plot(type="n",qq_gumbel_s_mcmc$qdata$x, qq_gumbel_s_mcmc$qdata$y, pch = 20, xlab="Observed", ylab="Gumbel")
points(qq_gumbel_s_mcmc$qdata$x, qq_gumbel_s_mcmc$qdata$y, pch=20)
lines(qq_gumbel_s_mcmc$qdata$x, qq_gumbel_s_mcmc$qdata$lower, lty=2, col="blue", lwd=3)
lines(qq_gumbel_s_mcmc$qdata$x, qq_gumbel_s_mcmc$qdata$upper, lty=2, col="blue", lwd=3)
abline(a=0, b=1, lty=3, col="gray80", lwd=3)
legend("topleft", lty=c(2, 3), lwd=3, legend=c("95% confidence bands", "1:1 line"), col=c("blue", "gray80"), bty="n")
dev.off()


# Overall (site time) Gumbel QQPlot  ------------------------------------------------------------------

## with GEV-fit marginal parameters
gumbel_overall = sort(as.vector(gumbel_pY))
nquants = length(gumbel_overall)
emp_p = seq(1/nquants, 1-1/nquants, length=nquants)
emp_q = qgumbel(emp_p)
qq_gumbel_overall <- extRemes::qqplot(gumbel_overall, emp_q, regress=FALSE, legend=NULL,
                                xlab="Observed", ylab="Gumbel", main="GEVfit-QQPlot Overall",
                                lwd=3)
pdf(file="R_GEVfit-QQPlot_Overall.pdf", width = 6, height = 5)
par(mgp=c(1.5,0.5,0), mar=c(3,3,1,1))
plot(type="n",qq_gumbel_overall$qdata$x, qq_gumbel_overall$qdata$y, pch = 20, xlab="Observed", ylab="Gumbel")
points(qq_gumbel_overall$qdata$x, qq_gumbel_overall$qdata$y, pch=20)
lines(qq_gumbel_overall$qdata$x, qq_gumbel_overall$qdata$lower, lty=2, col="blue", lwd=3)
lines(qq_gumbel_overall$qdata$x, qq_gumbel_overall$qdata$upper, lty=2, col="blue", lwd=3)
abline(a=0, b=1, lty=3, col="gray80", lwd=3)
legend("topleft", lty=c(2, 3), lwd=3, legend=c("95% confidence bands", "1:1 line"), col=c("blue", "gray80"), bty="n")
dev.off()

## with Copula Model-fit marginal parameters
gumbel_mcmc_overall = sort(as.vector(apply(gumbel_pY_mcmc, c(2,3), mean)))
nquants = length(gumbel_mcmc_overall)
emp_p = seq(1/nquants, 1-1/nquants, length=nquants)
emp_q = qgumbel(emp_p)
qq_gumbel_mcmc_overall <- extRemes::qqplot(gumbel_mcmc_overall, emp_q, regress=FALSE, legend=NULL,
                                xlab="Observed", ylab="Gumbel", main="Modelfit-QQPlot Overall",
                                lwd=3)
pdf(file="R_Modelfit-QQPlot_Overall.pdf", width = 6, height = 5)
par(mgp=c(1.5,0.5,0), mar=c(3,3,1,1))
plot(type="n",qq_gumbel_mcmc_overall$qdata$x, qq_gumbel_mcmc_overall$qdata$y, pch = 20, xlab="Observed", ylab="Gumbel")
points(qq_gumbel_mcmc_overall$qdata$x, qq_gumbel_mcmc_overall$qdata$y, pch=20)
lines(qq_gumbel_mcmc_overall$qdata$x, qq_gumbel_mcmc_overall$qdata$lower, lty=2, col="blue", lwd=3)
lines(qq_gumbel_mcmc_overall$qdata$x, qq_gumbel_mcmc_overall$qdata$upper, lty=2, col="blue", lwd=3)
abline(a=0, b=1, lty=3, col="gray80", lwd=3)
legend("topleft", lty=c(2, 3), lwd=3, legend=c("95% confidence bands", "1:1 line"), col=c("blue", "gray80"), bty="n")
dev.off()


