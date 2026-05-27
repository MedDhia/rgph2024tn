\name{codebook}
\alias{codebook}
\title{Codebook of Census Indicators}
\description{Summary table of all 50 thematic indicators.}
\usage{codebook(domain = NULL)}
\arguments{
  \item{domain}{Character or \code{NULL}. Filter by domain.}
}
\value{A \code{data.frame} (printed and returned invisibly).}
\examples{
codebook()
codebook("education")
}
