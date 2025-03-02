permcor <- function(x, B = 999, fast = TRUE) {

  if (fast) {
    res <- Rfast::permcor(x[, 1], x[, 2], R = B)
  } else {
    n <- dim(x)[1]
    x1 <- x[, 1]      ;   x2 <- x[, 2]
    m1 <- sum(x1)     ;   m2 <- sum(x2)
    up <-  m1 * m2 / n
    test <- sum(x1 * x2) - up   ## test statistic
    R <- round( sqrt(B) )
    xp <- Rfast::colShuffle( matrix(x1, nrow = n, ncol = R) )
    yp <- Rfast::colShuffle( matrix(x2, nrow = n, ncol = R) )
    sxy <- crossprod(xp, yp)
    tb <- sxy - up ## the test statistic
    pvalue <- ( sum( abs(tb) > abs(test) ) + 1 ) / (R^2 + 1)  ## permutation p-value
    res <- c( test, pvalue )
    names(res) <- c('stat', 'p-value')
  }
  res
}
