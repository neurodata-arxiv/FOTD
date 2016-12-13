Here we select a random half of the synaptome data, different from the half we have been using.

The data are then z-scored and principal components are computed to the 3rd elbow by Z-G.

``` r
require(meda)
source("~/neurodata/synaptome-stats/Code/doidt.r")
load('~/neurodata/synaptome-stats/Code/cleanDataWithAttributes.RData')
```

``` r
### Setting a seed and creating an index vector
### to select half of the data
#set.seed(2^10)
set.seed(317)
half1 <- sample(dim(data01)[1],dim(data01)[1]/2)
half2 <- setdiff(1:dim(data01)[1],half1)

feat <- data01[half1,]
feat2 <- data01[half2,]

#set.seed(2^10)
set.seed(317)
ss <- sample(dim(data01)[1],1000)
small <- data01[ss, 1:24, with = FALSE]
```

``` r
dat <- small
zfeat <- 
  dat[, lapply(.SD, scale, center = TRUE, scale=TRUE)]

pr2 <- prcomp(zfeat)
cur <- rCUR::CUR(as.matrix(zfeat), k = 3)@C

(elb <- getElbows(pr2$x, 3, plot = FALSE))
```

    ## [1]  3 18 21

``` r
X <- pr2$x[, 1:elb[3]]

out <- doIDT(as.matrix(X),
             FUN="mclust",
             Dmax=ncol(X), ## max dim for clustering
             Kmax=9,  ## max K for clustering 
             maxsamp=nrow(X), ## max n for clustering
             samp=1, # 1: no sampling, else n/sample sampling
             maxdepth=3, # termination, maximum depth for idt
             minnum=100, # termination, minimum observations per branch
             verbose=FALSE)  
```

    ## number of leaves (clusters) =  22

``` r
idtlab <- out$class
pairs(X[,1:3], pch=19,col=idtlab)
title("FOTD 20161212: IDT on Synaptome Data")
```

<img src="../figures/fotd20161212.png" width="768" />
