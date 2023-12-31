\name{Permutation p-value for the correlation coefficient}
\alias{permcor}
\alias{permcor2}
\alias{permcor3}
\title{
Permutation p-value for the correlation coefficient
}

\description{
Permutation p-value for the correlation coefficient.
}

\usage{
permcor(x, B = 999, fast = TRUE)
permcor2(x, B = 999)
permcor3(x, B = 999)
}

\arguments{
\item{x}{
A numerical matrix with two columns.
}
\item{B}{
The number of bootstrap samples to generate.
}
\item{fast}{
If you want the C++ implementation leave this TRUE. It is about 2 times faster.
}
}

\details{
These are permutation based p-values for the test that the true correlation coefficient is zero. The function "permcor2()" is a vectorised version of "permcor3()", whereas the function "permcor() does the following.

Instead of transforming the data under the null hypothesis and re-sampling with replacement we can permute the observations. Te basic difference is that the data are assumed to be under the null hypothesis already. Secondly, what we have to do, is to destroy the pairs. For example, the pairs (a, b), (c, d) and (e, f) in one permutation they can be (c, b), (a, f) and (e, d). And this thing will happen many times, say \eqn{B=999}. Then we have \eqn{B} pseudo-samples again. Everything else is the same as in the bootstrap case. A trick is that we need not change the order of both variables, just the one is enough. This will sped up the process. And guess what, it is faster than bootstrap. It does not require the data to be transformed under the null hypothesis and you only need to permute one variable, in contrast to the bootstrap case, where you must resample from both variables. See Chatzipantsiou et al. (2019) for more details.
}

\value{
The correlation coefficient and the permutation based p-value for the test of zero correlation.
}

\references{
Chatzipantsiou C., Dimitriadis M., Papadakis M. and Tsagris M. (2019). Extremely efficient permutation and bootstrap hypothesis tests using R. Journal of Modern Applied Statistical Methods, 18(2): eP2898.
}

\author{
Michail Tsagris

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{ \link{bootcor}
}
}

\examples{
permcor( iris[, 1:2] )
}


