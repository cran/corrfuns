\name{Partial correlation matrix}
\alias{pcormat}
\title{
Partial correlation matrix
}

\description{
Partial correlation matrix.
}

\usage{
pcormat(x, type = "pearson")
}

\arguments{
\item{x}{
A numerical matrix with two columns.
}
\item{type}{
The type of the partial correlation matrix to compute, "pearson" or "spearman".
}
}

\details{
The function computes the partial correlation matrix. Given a correlation matrix, it will return the partial correlation matrix. Each entry in the final matrix, is the partial correlation matrix between a pair of variables given all the rest variables.
}

\value{
The partial correlation matrix.
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
\code{ \link{partialcor}, \link{partialcor2}
}
}

\examples{
pcormat( iris[, 1:4] )
}


