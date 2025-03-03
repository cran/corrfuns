correl <- function(y, x, type = "pearson", rho = 0, alpha = 0.05) {

  n <- length(y)

  if ( type == "pearson" ) {
    r <- cor(y, x)  ## the correlation value
    zh0 <- 0.5 * log( (1 + rho) / (1 - rho) )  ## Fisher's transformation for Ho
    zh1 <- 0.5 * log( (1 + r) / (1 - r) )  ## Fisher's transformation for H1
    se <- 1/sqrt(n - 3)  ## standard error for Fisher's transformation of Ho
  } else if ( type == "spearman" ) {
    r <- cor(y, x, method = "spearman")  ## the correlation value
    zh0 <- 0.5 * log( (1 + rho) / (1 - rho) )  ## Fisher's transformation for Ho
    zh1 <- 0.5 * log( (1 + r) / (1 - r) )  ## Fisher's transformation for H1
    se <-  1.029563 / sqrt(n - 3)  ## standard error for Fisher's transformation of Ho
  }

  test <- (zh1 - zh0)/se  ## test statistic
  pvalue <- 2 * pt( abs(test), n - 3, lower.tail = FALSE )  ## p-value
  zL <- zh1 - qt(1 - alpha/2, n - 3) * se
  zH <- zh1 + qt(1 - alpha/2, n - 3) * se
  fishL <- ( expm1(2 * zL) ) / (exp(2 * zL) + 1)  ## lower confidence limit
  fishH <- ( expm1(2 * zH) ) / (exp(2 * zH) + 1)  ## upper confidence limit
  ci <- c(fishL, fishH)
  names(ci) <- paste(c( alpha/2 * 100, (1 - alpha/2) * 100 ), "%", sep = "")

  result <- c(r, pvalue)
  names(result) <- c('correlation', 'p-value')
  list(result = result, ci = ci)
}
