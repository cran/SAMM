\name{SAMM}
\alias{SAMM}
\title{Some Algoritms for Mixed Models}
\description{
The LMM model of focus can be expressed as \deqn{Y=XB+\sum_{j=1}^k Z_j G_j+WE,} where \eqn{Y} is the \eqn{n \times d} response variable, \eqn{X} is the \eqn{n \times q} design matrix of \eqn{q \times d} the fixed effects \eqn{B}, \eqn{Z_j} for \eqn{j=1,2,\ldots,k}  (\eqn{k\geq 1}) are the \eqn{n \times q_j} design matrices of the \eqn{q_j \times d} random effects \eqn{G_j,}  and \eqn{W} is the \eqn{n \times t} design matrix of \eqn{t \times d} residual effecs \eqn{E}. The random effects and the residual are independently distributed, and have matrix variate distributions (\eqn{G_j\sim N_{q_j \times d}(0_{q_j \times d}, K_j,\Sigma_j)} for \eqn{j=1,2,\ldots,k} and \eqn{E\sim N_{t \times d}(0_{t \times d}, R,\Sigma_E)}). The matrices  \eqn{K_j, R, \Sigma_j, \Sigma_E} might be further parametrized.  When the response is univariate \eqn{(d=1)} there is no need to specify a structure for \eqn{\Sigma_j}'s and\eqn{\Sigma_E.}  On the other hand, the \eqn{K_j} and \eqn{R} are concordance matrices (covariance matrices with some standardization over the diagonals) and they need to be provided by the user. 

Please refer to the examples below and the other help files for more details about the concordance and covariance structures. 

!!IMPORTANT NOTE!!: USE SAMM WITH CAUTION, AND AT YOUR OWN RISK! NO GUARANTIES, NO CLAIMS.

PLEASE REPORT BUGS AND RECOMMENDATIONS TO THE MAINTAINER.
}

\usage{
SAMM(Y,X,Zlist,Klist, lambda, W,R,Siglist, corfunc, corfuncfixed,  sigfunc,
mmalg, tolparconv=1e-10, tolparinv=1e-10,maxiter=1000, geterrors=FALSE, Hinv = FALSE)
}
\arguments{
  \item{Y}{\eqn{Y} is the \eqn{n \times d} response variable}
  \item{X}{\eqn{n \times q} design matrix of \eqn{q \times d} the fixed effects \eqn{B}}
  \item{Zlist}{a list object containing \eqn{Z_j} for \eqn{j=1,2,\ldots,k}  (\eqn{k\geq 1}), the \eqn{n \times q_j} design matrices of the \eqn{q_j \times d} random effects \eqn{G_j,}}
  \item{Klist}{a list to specify the concordance matrices \eqn{K_j} for \eqn{j=1,2,\ldots,k.} For each \eqn{j}, the user needs to provide a constant matrix, or a list specifying the concordance structure}
  \item{lambda}{a scalar shrinkage parameter for shrinkage of variance components (only works with the choice mmalg=''mmmk_ml'').}
  \item{W}{\eqn{W} is the \eqn{n \times t} design matrix of \eqn{t \times d} residual effecs \eqn{E}}
  \item{R}{a list to specify the concordance matrix \eqn{R},the user needs to provide a constant matrix, or a list specifying the concordance structure}
  \item{Siglist}{a list to specify the covariance structures \eqn{\Sigma_j}'s and\eqn{\Sigma_E}}
  \item{corfunc}{a boolian vector specifying whether \eqn{K_j} for \eqn{j=1,2,\ldots,k}  and \eqn{R} are functions or given matrices (TRUE for functions)}
  \item{corfuncfixed}{a boolian vector specifying whether \eqn{K_j} for \eqn{j=1,2,\ldots,k} and \eqn{R} are fixed at the initial parameter values specified }
  \item{sigfunc}{a boolian vector specifying whether \eqn{\Sigma_j} for \eqn{j=1,2,\ldots,k, E} are functions or unstructured (TRUE for functions)}
  \item{mmalg}{The mixed model solving algorithm}
  \item{tolparconv}{convergence number}
  \item{tolparinv}{a small scalar to add to the diagonals of positive semidefinite matrices for inversion or for calculating the Cholesky decompositions}
  \item{maxiter}{Maximum number of iterations}
  \item{geterrors}{TRUE or FALSE, if true prediction error variances for the random effects are supplied in the output}
    \item{Hinv}{TRUE or FALSE, if true inverse of H matrix will be returned}

}
\value{
A named list object (the output will differ for different algorithms and model types!).
}
\details{
The algorithms in SAMM were mostly concieved based on the ideas in the referenced papers: 
1-emm_reml: reference 4.
2-emm_ml: reference 4.
3-dmm_ml: reference 1.
4-dmm_reml: reference 1.
5-dermm_reml1: reference 5 (Fisher-Scoring).
6-dermm_reml2: reference 5 (Average Information).
7-mm_ml: reference 2.
8-emmmk_reml: reference 4.
9-emmmk_ml: reference 4.
10-mmmk_ml: reference 2.
11-emmmv_ml: reference 4.
12-mmmv_ml: reference 3.
13-mmmkmv_ml: reference 2.
The table below shows which cases these algorithms can be used. The prefered algorithms are marked by paranthesis and the user still needs to specify it.

\tabular{rrrrrrrr}{
 No\tab Univariate \tab One K \tab corfunc \tab sigfunc \tab shrinkage  \tab WRWtIdent \tab ALGS \cr
 1- \tab + \tab + \tab - \tab 0 \tab -  \tab + \tab 1-12 (1)\cr
 2- \tab + \tab + \tab - \tab 0 \tab -  \tab - \tab 3-7, 10-12 (3) \cr
 3- \tab + \tab + \tab \eqn{1^*} \tab 0 \tab 0  \tab 0 \tab 3-6, 10-11 (3) \cr
 4- \tab + \tab + \tab + \tab 0 \tab 0  \tab 0 \tab 10, 13 (10)\cr
 5- \tab + \tab - \tab - \tab 0 \tab -  \tab + \tab 5, 6, 8, 9, 10, 13 (5) \cr
 6- \tab + \tab - \tab - \tab 0 \tab -  \tab - \tab 5, 6, 10, 13 (5) \cr
 7- \tab + \tab - \tab + \tab 0 \tab -  \tab - \tab 5, 6, 10, 13 (5) \cr
 8- \tab + \tab - \tab - \tab 0 \tab +  \tab 0 \tab 10 (10) \cr
 9- \tab + \tab - \tab + \tab 0 \tab +  \tab 0 \tab 10 (10)\cr
 10- \tab - \tab + \tab - \tab - \tab -  \tab - \tab 11, 12 (11)\cr
 11- \tab - \tab + \tab - \tab - \tab -  \tab - \tab 12 (12)\cr
 12- \tab - \tab - \tab - \tab - \tab -  \tab 0 \tab 13 (13)\cr
 13- \tab - \tab - \tab \eqn{2^*} \tab \eqn{2^*} \tab -  \tab 0 \tab 13 (13) \cr
 14- \tab - \tab + \tab  \eqn{2^*} \tab  \eqn{2^*} \tab -  \tab 0 \tab 13 (13)
     }
     \eqn{-}: No.
     \eqn{+}: Yes.
     \eqn{0}: Doesn't matter.
     \eqn{1^*}: Only K is a function not R.
     \eqn{2^*}: sigmafunc or corfunc.
}
\references{
1-Bates, Douglas M. "lme4: Mixed-effects modeling with R." URL http://lme4. r-forge. r-project. org/book (2010).

2-Zhou, Hua, et al. "MM Algorithms for Variance Components Models." arXiv preprint arXiv:1509.07426 (2015).

3-Zhou, Xiang, and Matthew Stephens. "Efficient algorithms for multivariate linear mixed models in genome-wide association studies." Nature methods 11.4 (2014): 407.

4-Kang, Hyun Min, et al. "Efficient control of population structure in model organism association mapping." Genetics 178.3 (2008): 1709-1723.

5-Gilmour, Arthur R., Robin Thompson, and Brian R. Cullis. "Average information REML: an efficient algorithm for variance parameter estimation in linear mixed models." Biometrics (1995): 1440-1450.

}

\examples{
\dontrun{
library(SAMM)
#set.seed(12345)

n=120
ntrain=100
M1<-matrix(rbinom(n*180,2,.3)-1, nrow=n)
K<-relmatcov_cppforR(c(0), M1)
K[1:5,1:5]
det(K)
K=K+1e-3*diag(n)
mean(diag(K))

covY<-2*K+1*diag(n)

Y<-10+crossprod(chol(covY),rnorm(n))


#training set
Trainset<-sample(1:n,ntrain,replace=(ntrain>n))
y=Y[Trainset]
X=matrix(rep(1, n)[Trainset], ncol=1)
Z=diag(n)[Trainset,]




########1
samout1<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), Klist=list(K),
lambda=0, W=diag(ntrain),R=list(diag(ntrain)),Siglist=list(),
corfunc=c(F,F), corfuncfixed=c(F,F), sigfunc=c(F),mmalg="emm_ml",
tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)

samout2<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), Klist=list(K),
lambda=0, W=diag(ntrain),R=list(diag(ntrain)),Siglist=list(),
corfunc=c(F,F), corfuncfixed=c(F,F), sigfunc=c(F),mmalg="emm_reml",
tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)

samout3<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(list("Const",c(0),K)), lambda=0, 
W=diag(ntrain),R=list(diag(ntrain)),Siglist=list(),
corfunc=c(F,F), corfuncfixed=c(F,F), sigfunc=c(F),
mmalg="dmm_ml", tolparconv=1e-10, tolparinv=1e-10,
maxiter=1000,geterrors=F)

samout4<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(list("Const",c(0),K)), lambda=0, 
W=diag(ntrain),R=list(diag(ntrain)),Siglist=list(), 
corfunc=c(F,F), corfuncfixed=c(F,F), sigfunc=c(F),
mmalg="dmm_reml", tolparconv=1e-10, tolparinv=1e-10,
maxiter=1000,geterrors=F)

samout5<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(K), lambda=0, W=diag(ntrain),
R=list(diag(ntrain)),Siglist=list(), corfunc=c(F,F), 
corfuncfixed=c(F,F), sigfunc=c(F),mmalg="mm_ml", 
tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)

samout6<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(diag(ntrain)),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="dermm_reml1", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout7<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(K), lambda=0, W=diag(ntrain),R=list(diag(ntrain)),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="dermm_reml2", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout8<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(K), lambda=0, W=diag(ntrain),R=list(diag(ntrain)),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="mmmk_ml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout9<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(diag(ntrain)),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="emmmk_reml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout10<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(diag(ntrain)),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="emmmk_ml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout11<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(K), lambda=0, W=diag(ntrain),R=list(diag(ntrain)),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), sigfunc=c(F),
mmalg="emmmv_ml", tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)

###########2
R<-diag(ntrain)
diag(R)<-diag(R)+.01*rnorm(nrow(R))

samout12<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(K), lambda=0, W=diag(ntrain),R=list(R),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F),
sigfunc=c(F),mmalg="mmmk_ml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout13<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(R),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="mm_ml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout14<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(K), lambda=0, W=diag(ntrain),R=list(R),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="mmmv_ml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout15<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(R),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="mmmkmv_ml", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout16<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(R),Siglist=list(),
corfunc=c(F,F), corfuncfixed=c(F,F), sigfunc=c(F),
mmalg="dermm_reml1", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout17<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(K), lambda=0, W=diag(ntrain),R=list(R),
Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F),
sigfunc=c(F),mmalg="dermm_reml2", tolparconv=1e-10, 
tolparinv=1e-10,maxiter=1000,geterrors=F)

samout18<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z),
Klist=list(list("Const",c(0),K)), lambda=0, W=diag(ntrain),
R=list(R),Siglist=list(), corfunc=c(F,F), 
corfuncfixed=c(F,F), sigfunc=c(F),mmalg="dmm_ml",
tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)

samout19<-SAMM(Y=matrix(y,ncol=1),X=X, Zlist=list(Z), 
Klist=list(list("Const",c(0),K)), lambda=0, W=diag(ntrain),
R=list(R),Siglist=list(), corfunc=c(F,F), corfuncfixed=c(F,F), 
sigfunc=c(F),mmalg="dmm_reml", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)



samout1$Vu
samout2$Vu
samout3$Vu
samout4$Vu
samout5$Vu
samout6$Vu
samout7$Vu
samout8$Vu
samout9$Vu
samout10$Vu
samout11$Vgt

samout12$Vu
samout13$Vu
samout14$sigmahatlist[[1]]
samout15$sigmahatlist[[1]]
samout16$Vu
samout17$Vu
samout18$Vu
samout19$Vu





###############################

library(SAMM)
n=100
nsample=80
rhotrans=5
ar1cov_cppforR(c(rhotrans),matrix(5))
rho=(2/pi)*atan(rhotrans)
rho
tan((pi/2)*(rho))

M1<-matrix(rbinom(n*300, 2, .2)-1, nrow=n)
K1<-relmatcov_cppforR(c(.01), M1)

M2<-matrix(rbinom(n*300, 2, .2)-1, nrow=n)
K2<-relmatcov_cppforR(c(0.03), M2)
W=(diag(5)[sample(1:5,n, replace=TRUE),])
covY<-3*K1+5*K2+10*(W\%*\%ar1cov_cppforR(c(rhotrans),matrix(5))\%*\%t(W))
K1[1:5,1:5]
dim(W)
dim(ar1cov_cppforR(c(6),matrix(5)))
Y<-10+crossprod(chol(covY),rnorm(n))


#training set
Trainset<-sample(1:n,nsample)
ytrain=Y[Trainset]
Xtrain=matrix(rep(1, n)[Trainset], ncol=1)
Ztrain=diag(n)[Trainset,]
Wtrain=W[Trainset,]


samout27<-SAMM(Y=matrix(ytrain,ncol=1),X=Xtrain,
Zlist=list(Ztrain, Ztrain), Klist=list(K1,K2), 
lambda=0, W=Wtrain,R=list(list("ar1",c(0),matrix(5,1,1))),
Siglist=list("","",""), corfunc=c(F,F,T), 
corfuncfixed=c(F,F,F), sigfunc=c(F,F,F),mmalg="mmmk_ml",
tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout27)

samout28<-SAMM(Y=matrix(ytrain,ncol=1),X=Xtrain,
Zlist=list(Ztrain, Ztrain), Klist=list(K1,K2), lambda=0, 
W=Wtrain,R=list(list("ar1",c(0),matrix(5,1,1))),Siglist=list("","",""),
corfunc=c(F,F,T), corfuncfixed=c(F,F,F), sigfunc=c(F,F,F),
mmalg="mmmkmv_ml", tolparconv=1e-10, tolparinv=1e-10,
maxiter=1000,geterrors=F)
str(samout28)

samout29<-SAMM(Y=matrix(ytrain,ncol=1),X=Xtrain,
Zlist=list(Ztrain, Ztrain), Klist=list(K1,K2),
lambda=0, W=Wtrain,R=list("ar1",c(0),matrix(5,1,1)),
Siglist=list("","",""), corfunc=c(F,F,T),
corfuncfixed=c(F,F,F), sigfunc=c(F,F,F),
mmalg="dermm_reml1", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)

str(samout29)

samout30<-SAMM(Y=matrix(ytrain,ncol=1),X=Xtrain,
Zlist=list(Ztrain, Ztrain), Klist=list(K1,K2),
lambda=0, W=Wtrain,R=list("ar1",c(0),matrix(5,1,1)),
Siglist=list("","",""), corfunc=c(F,F,T), corfuncfixed=c(F,F,F),
sigfunc=c(F,F,F),mmalg="dermm_reml2", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout30)


###########################

###Data:



n=100
nsample=90

M1<-matrix(rbinom(n*300, 2, .2)-1, nrow=n)
K1<-relmatcov_cppforR(c(.1), M1)
Sigma1=ar1cov_cppforR(c(5),matrix(3))
Sigma2=ar1cov_cppforR(c(-2),matrix(3))
W=(diag(5)[sample(1:5,n, replace=T),])
K2=(W\%*\%ar1cov_cppforR(c(-3),matrix(5))\%*\%t(W))

covY<-5*kronecker(Sigma1,K1)+10*kronecker(Sigma2,K2)

Y<-10+crossprod(chol(covY),rnorm(n*3))
Y<-matrix(Y, ncol=3)


samout31<-SAMM(Y=Y,X=matrix(1,n,1), Zlist=list(diag(n)),
Klist=list(K1), lambda=0, W=W,R=list(list("ar1",c(0),matrix(5,1,1))),
Siglist=list("",""), corfunc=c(F,T), corfuncfixed=c(F,F), sigfunc=c(F,F),
mmalg="mmmkmv_ml", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout31)

samout32<-SAMM(Y=Y,X=matrix(1,n,1), Zlist=list(diag(n)),
Klist=list(K1), lambda=0, W=W,R=list(list("ar1",c(0),matrix(5,1,1))),
Siglist=list("",list("diag",c(0,0,0),matrix(3,1,1))),
corfunc=c(F,T), corfuncfixed=c(F,F), 
sigfunc=c(F,T),mmalg="mmmkmv_ml", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout32)

samout33<-SAMM(Y=Y,X=matrix(1,n,1), Zlist=list(diag(n)),
Klist=list(K1), lambda=0, W=W,R=list(list("ar1",c(0),matrix(5,1,1))),
Siglist=list("",list("Ident",c(0),matrix(3,1,1))), corfunc=c(F,T),
corfuncfixed=c(F,F), sigfunc=c(F,T),mmalg="mmmkmv_ml",
tolparconv=1e-10, tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout33)



###########################


n=100
M1<-matrix(rbinom(n*150, 2, .2)-1, nrow=n)
K1<-relmatcov_cppforR(c(0), M1)
M2<-matrix(rbinom(n*150, 2, .2)-1, nrow=n)
K2<-relmatcov_cppforR(c(0), M2)
M3<-matrix(rbinom(n*100, 2, .2)-1, nrow=n)
K3<-relmatcov_cppforR(c(0), M3)
M4<-matrix(rbinom(n*100, 2, .2)-1, nrow=n)
K4<-relmatcov_cppforR(c(0), M4)


covY<-2*K1+3*K2+1*K3+2*K4+3*diag(n)

Y<-10+crossprod(chol(covY),rnorm(n))


#training set
Trainset<-sample(1:n,80)
y=Y[Trainset]
X=matrix(rep(1, n)[Trainset], ncol=1)
Z=diag(n)[Trainset,]

X=X
y=y

samout35<-SAMM(Y=matrix(y,ncol=1),X=X,Zlist=list(Z,Z,Z,Z),
lambda=0,Klist=list(K1,K2,K3,K4), W=Z,R=list(diag(n)),
Siglist=list("","","","",""), corfunc=c(F,F,F,F,F), 
corfuncfixed=c(T,T,T,T,T),sigfunc=c(F,F,F,F,F),
mmalg="mmmk_ml", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout35)

samout36<-SAMM(Y=matrix(y,ncol=1),X=X,Zlist=list(Z,Z,Z,Z),
lambda=0.99999,Klist=list(K1,K2,K3,K4), W=Z,
R=list(diag(n)),Siglist=list("","","","",""),
corfunc=c(F,F,F,F,F), corfuncfixed=c(T,T,T,T,T),
sigfunc=c(F,F,F,F,F),mmalg="mmmk_ml", tolparconv=1e-10,
tolparinv=1e-10,maxiter=1000,geterrors=F)
str(samout36)


outmat<-c()
for (lambda in seq(0,.999999, length=30)){
  samout37<-SAMM(Y=matrix(y,ncol=1),X=X,
  Zlist=list(Z,Z,Z,Z),lambda=lambda,Klist=list(K1,K2,K3,K4),
  W=Z,R=list(diag(n)),Siglist=list("","","","",""),
  corfunc=c(F,F,F,F,F), corfuncfixed=c(T,T,T,T,T), 
  sigfunc=c(F,F,F,F,F),mmalg="mmmk_ml",
  tolparconv=1e-10, tolparinv=1e-10,
  maxiter=1000,geterrors=F)
  outmat<-cbind(outmat,c(samout37$Vu*samout37$weights, samout37$Ve))
}
str(samout37)
colnames(outmat)<-seq(0,.999999, length=30)

maxmat<-max(c(outmat))
minmat<-min(c(outmat))

plot(seq(0,.999999, length=30),outmat[1,],
ylim=c(minmat-1, maxmat+1), col=2, type="b")
for (i in 2:5){
  par(new=T)
  plot(seq(0,.999999, length=30), outmat[i,],
  axes=F, ylim=c(minmat-1, maxmat+1), col=i+1, type="b", xlab="", ylab="")
}
} 
}
\author{Deniz Akdemir}

