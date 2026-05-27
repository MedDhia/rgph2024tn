\name{theil_decompose}
\alias{theil_decompose}
\title{Theil Index Decomposition}
\description{Decompose Theil T into between-group and within-group.}
\usage{theil_decompose(x, group, na.rm = TRUE)}
\arguments{
  \item{x}{Numeric vector (positive values).}
  \item{group}{Character or factor.}
  \item{na.rm}{Logical.}
}
\value{List: total, between, within, pct_between, group_detail.}
\examples{
del <- load_delegations()
theil_decompose(del[["raccordement.total.SONEDE"]], del[["region"]])
}
