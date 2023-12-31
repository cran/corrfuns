bootcor <- function(x, B = 999) {
  x <- as.matrix(x)
  s <- cov(x)
  n <- dim(x)[1]
  eig <- eigen(s, symmetric = TRUE)
  lam <- eig$values
  vec <- eig$vectors
  ## The next row makes the correlation matrix equal to
  ## the identity matrix, thus rho = 0
  z <- x %*% vec %*% ( t(vec) / sqrt(lam) )
  r <- s[2] / sqrt( s[1] * s[3] )
  stat <- 0.5 * log( (1 + r)/(1 - r) )  ## the test statistic
  u <- runif(1)
  set.seed(u)  ## this is so that the pairs are the same
  x1 <- matrix(sample(z[, 1], B * n, replace = TRUE), nrow = n)
  set.seed(u)  ## this is so that the pairs are the same
  x2 <- matrix(sample(z[, 2], B * n, replace = TRUE), nrow = n)
  yb1 <- Rfast::colmeans(x1)   ;    yb2 <- Rfast::colmeans(x2)
  y1 <- Rfast::colsums(x1^2)   ;    y2 <- Rfast::colsums(x2^2)
  sxy <- Rfast::colsums(x1 * x2)
  rb <- (sxy - n * yb1 * yb2) / sqrt( (y1 - n * yb1^2) * (y2 - n * yb2^2) )
  tb <- 0.5 * log( (1 + rb)/(1 - rb) )  ## the test statistic
  pvalue <- (sum( abs(tb) > abs(stat) ) + 1)/(B + 1)  ## bootstrap p-value
  result <- c(r, pvalue)
  names(result) <- c('correlation', 'p-value')
  result
}
