\name{gini}
\alias{gini}
\title{Gini Coefficient}
\description{Gini coefficient for non-negative values.}
\usage{gini(x, na.rm = TRUE)}
\arguments{
  \item{x}{Numeric vector.}
  \item{na.rm}{Logical.}
}
\value{Scalar in [0, 1].}
\examples{
gini(rep(1, 100))
del <- load_delegations()
gini(del[["raccordement.total.Gaz naturel"]])
}
