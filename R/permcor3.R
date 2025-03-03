permcor3 <- function(x, B = 999) {
  ## x is a 2 column matrix containing the data
  ## type can be either "pearson" or "spearman"
  ## R is the number of permutations
  x1 <- x[, 1]      ;   x2 <- x[, 2]
  m1 <- sum(x1)     ;   m2 <- sum(x2)
  n <- dim(x)[1]
  up <-  m1 * m2 / n
  test <- sum(x1 * x2) - up  ## test statistic
  sxy <- numeric(B)
  for (i in 1:B) {
    y1 <- sample(x1, n, replace = FALSE)
    sxy[i] <- sum(y1 * x2)
  }
  tb <- sxy - up  ## test statistic
  pvalue <- ( sum( abs(tb) > abs(test) ) + 1 ) / (B + 1)  ## permutation p-value
  res <- c( test, pvalue )
  names(res) <- c('stat', 'p-value')
  res
}
