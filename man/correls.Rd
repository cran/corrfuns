\name{Asymptotic p-value for many correlation coefficients}
\alias{correls}
\title{
Asymptotic p-value for many correlation coefficients
}

\description{
Asymptotic p-value for many correlation coefficients.
}

\usage{
correls(y, x, type = "pearson", rho = 0, alpha = 0.05)
}

\arguments{
\item{y}{
A numerical vector.
}
\item{x}{
A numerical vector.
}
\item{type}{
The type of correlation coefficient to compute, "pearson" or "spearman".
}
\item{rho}{
The hypothesized value of the true partial correlation.
}
\item{alpha}{
The significance level.
}
}

\details{
Suppose you have a (dependent) variable \eqn{Y} and a matrix of \eqn{p} variables \eqn{\bf X} and you want to get all the correlations between \eqn{Y} and \eqn{X_i} for \eqn{i=1,\ldots,p}. if you type cor(y, x) in you will get a vector of the correlations. What I offer here is confidence interval for each of the correlations, the test statistic and the p-values for the hypothesis that each of them is equal to some value \eqn{\rho}. The p-values and test statistics are useful for meta-analysis for example, combination of the p-values in one or even to see the false discovery rate (see the package \bold{fdrtool} by Korbinian Strimmer).
}

\value{
A matrix with 5 columns, the correlations, the test statistics, their associated p-values and the relevant \eqn{(1-\alpha)\%} confidence intervals.
}

%\references{
%
%}

\author{
Michail Tsagris

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{ \link{correl}, \link{permcorrels}
}
}

\examples{
y <- rnorm(40)
x <- matrix(rnorm(40 * 1000), ncol = 1000)
a <- correls(y, x )
}


