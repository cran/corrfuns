\name{Bootstrap p-value for the correlation coefficient}
\alias{bootcor}
\alias{bootcor2}
\title{
Bootstrap p-value for the correlation coefficient
}

\description{
Bootstrap p-value for the correlation coefficient.
}

\usage{
bootcor(x, B = 999)
bootcor2(x, B = 999)
}

\arguments{
\item{x}{
A numerical matrix with two columns.
}
\item{B}{
The number of bootstrap samples to generate.
}
}

\details{
The functions perform non-parametric bootstrap hypothesis testing that the correlation coefficient is zero. A good pivotal statistic is the Fisher's transformation (see \code{\link{correl}}). Then the data have to be transformed under the null hypothesis (\eqn{\rho=0}). This is doable via the eigen-analysis of the covariance matrix. We transform the bivariate data such that the covariance (and thus the correlation) matrix equals the identity matrix. remind that the correlation matrix is independent of measurements and is location free. The next step is easy, we draw bootstrap samples (from the transformed data) and every time we calculate the Fisher's transformation. The bootstrap p-value is calculated in the usual way (Davison and Hinkley, 1997).

If you want to perform a non-parametric bootstrap hypothesis for a value of the correlation other than zero the procedure is similar. The data have already been transformed such that their correlation is zero. Now instead of the zeroes in the off-diagonal values of the identity matrix you will have the value of the correlation matrix you want to test. Eigen analysis of the matrix is performed and the square root of the matrix is used to multiply the transformed data. I could write a more general function to include all case, but I will leave this task to you. If you do write it please send it to me and I will put it with your name of course.

The function "bootcor()" is a vectorised version of "bootcor2()". Instead of using a \bold{for} loop you can do things vectorised. This idea cam when I found the vectorised bootstrap correlation by Neto (2015). I cannot say I understood fully what he did, so I decided to write my own code based on the direction he pointed.

Pearson's correlation coefficient of \eqn{x} and \eqn{y} for a sample size \eqn{n} is given by
\deqn{
r = \frac{\sum_{i=1}^nx_iy_i-n\bar{x}\bar{y}}
{ \sqrt{\left(\sum_{i=1}^nx_i^2-n\bar{x}^2\right) \left(\sum_{i=1}^ny_i^2-n\bar{y}^2\right)} }
}

So, we can see that need 5 terms to calculate, \eqn{\sum_{i=1}^nx_iy_i, \bar{x}, \bar{y}, \sum_{i=1}^nx_i^2} and \eqn{\sum_{i=1}^ny_i^2}. After transforming the data under the null hypothesis using the spectral decomposition we proceed as follows with \eqn{B} number of resamples.

\bold{Algorithm for vectorised bootstrap}

1. Set a seed number in R. This is to make sure that the pairs of \eqn{\left(x_i, y_i\right)} are still the same.

2. Sample with replacement \eqn{B \times n} values of \eqn{x} and put them in a matrix with \eqn{n} rows and \eqn{B} columns, named \eqn{X_B}.

3. Sample with replacement \eqn{B \times n} values of \eqn{y} and put them in a matrix with \eqn{n} rows and \eqn{B} columns, names \eqn{Y_B}.

4. Calculate the mean vectors of \eqn{X_B} and \eqn{Y_B}.

5. Calculate the sum vector of \eqn{X_B^2} and \eqn{Y_B^2}.

6. Finally calculate the sum vector of \eqn{X_B * Y_B}. This is the term \eqn{\sum_{i=1}^nx_iy_i} for all resamples.

So we now have 5 vectors containing the 5 terms we want. We calculate the correlation coefficient and then the Fisher's transformation (see \code{\link{correl}}) and so we have \eqn{B} bootstrap test statistics. In order to see the time gain I tested both of these functions with \eqn{B=9999} resamples and 1000 repetitions. The gain is not super wow, I would like it if it was 1/10, but even saw, it is still good. Parallelised versions reduce time to 1/3, so from this perspective, I did better. If we now put parallel inside this vectorised version, computations will be even faster. I leave this with you.

But, I noticed one thing, the same thing Neto (2015) mentions. For big sample sizes, for example 1000 pairs, the time difference is not that big and perhaps a \bold{for} loop is faster. The big difference is in the small to moderate sample sizes. At least for this example. What I mean by this is that you should not be afraid and say, then why? If I have big sample, I do not need vectorization. Maybe yes, but even then I still recommend it. Maybe someone else will have a better alternative for vectorization which is better even in the big samples, for the correlation of course. In the contour plots though, vectorised versions are always faster no matter what.

}

\value{
The correlation coefficient and the bootstrap based p-value for the test of zero correlation.
}

\references{
Davison A.C. and Hinkley D.V. (1997). Bootstrap methods and their application. Cambridge
university Press.

Neto E.C. (2015). Speeding up non-parametric bootstrap computations for statistics based
on sample moments in small/moderate sample size applications. PloS ONE, 10(6): e0131333.
}

\author{
Michail Tsagris

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{ \link{permcor}
}
}

\examples{
bootcor( iris[, 1:2] )
}


