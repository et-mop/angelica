#MCMC of per256 simulation


#Statevector  have cyclic border
changeState <- function(cr.status, delta=10){
  dv <- rnorm(1, mean = 0, sd = sqrt(delta))
  round((cr.status + dv) %% 256)
}

#mcmc loop count
lp.count <- 51000

#n of prob denominator
prob.factor <- 256

#numerator of data, means success count
data.num <- 40

#denominator of data, means trial count
data.den <- 40

#state vector
state.vector <- array(NA_integer_, dim = c(lp.count + 1))

#initial status
state.vector[1] <- 128


#Simulation body

set.seed(2896)

for(mc in 1:lp.count){
  cs <- state.vector[mc]
  sc <- changeState(cs)

  cll <- dbinom(data.num, size=data.den, prob=cs/prob.factor, log = T)
  sll <- dbinom(data.num, size=data.den, prob=sc/prob.factor, log = T)
  pd <- exp(sll - cll)
  d <- runif(1)
  
  if(sll > cll) {
    state.vector[mc+1] <- sc
  } else if(pd > d){
    state.vector[mc+1] <- sc
  } else {
    state.vector[mc+1] <- cs
  }
}

hist(state.vector[-(1:1001)])

#save data to rds
#saveRDS(state.vector, "ffxi/data/mc256-3.rds")
