
calcMyMC <- function(suc, fls, mc=50000, burn=1000, rdw=0.1){
  
  nextValue <- function(cval){
    mv <- rnorm(1, mean = 0, sd=sqrt(rdw))
    return((cval + mv) %% 1)
  }
  
  #
  sv <- array(NA_real_, dim=c((mc+burn)))
  sv[1] <- 0.5
  
  for(i in 2:(mc+burn)){
    cv <- sv[i-1]
    cdv <- nextValue(cv)
    
    cur.llk <- dbinom(suc, size=(suc+fls), prob = cv, log = TRUE)
    cand.llk <- dbinom(suc, size=(suc+fls), prob = cdv, log = TRUE)
    lky <- exp(cand.llk - cur.llk)
    d <- runif(1)
    
    if(cand.llk > cur.llk){
      sv[i] <- cdv
    } else if(lky > d){
      sv[i] <- cdv
    } else {
      sv[i] <- cv
    }
  }

  return(sv)  
}


smryMyMC <- function(sv, burn=1000, cred=0.95){
  dtv <- sv[-(1:burn)]
  ret <- list()
  ret$mean <- mean(dtv)
  ret$median <- median(dtv)
  ret$HDI <- HDIofMCMC(dtv, credMass = cred)
  
  ret
}

smryMyMC(calcMyMC(10,5, 50000, 1000, 0.1), burn=1000)
