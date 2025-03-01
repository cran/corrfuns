perm.elcortest <- function(y, x, tol = 1e-07, B = 999) {

  funa <- function(z, tol) {
    lam1 <- 0
    f <- mean(z)
    der <-  sum( z^2 / (1 + lam1 * z)^2 )
    lam2 <- lam1 + f/der
    i <- 2
    while (abs(lam1 - lam2) > tol) {
      i <- i + 1
      lam1 <- lam2
      frac <- z / (1 + lam1 * z)
      f <- sum( frac )
      der <-  sum( frac^2 )
      lam2 <- lam1 + f/der
    }

    list( p = 1 / ( 1 + lam2 * z ) )
  }

  x <- ( x - mean(x) ) / Rfast::Var(x, std = TRUE)
  y <- ( y - mean(y) ) / Rfast::Var(y, std = TRUE)
  z <- x * y
  n <- length(z)

  res <- try( funa(z, tol), silent = TRUE )
  if ( identical(class(res), "try-error") ) {
    stat <- 10^5
    pval <- 0
  } else {
    stat <-  -2 * sum( log(res$p) )
    tb <- numeric(B)
    for ( i in 1:B ) {
      x1 <- Rfast2::Sample(x, n)
      z <- x1 * y
      res <- try( funa(z, tol), silent = TRUE )
      if ( identical( class(res), "try-error") ) {
        tb[i] <- 10^5
      } else  tb[i] <-  -2 * sum( log(res$p) )
    }
    pval <- ( sum(tb > stat) + 1 ) / (B + 1)
  }

  res <- c(stat, pval)
  names(res) <- c("statistic", "p-value")
  res
}
