\name{load_delegations}
\alias{load_delegations}
\alias{load_gouvernorats}
\alias{load_national}
\alias{load_secteurs}
\title{Load Tunisia Census Data}
\description{Load data at one of four administrative levels.
  Delegation, gouvernorat, and national data are bundled.
  Secteur data requires \code{\link{download_secteurs}} first.}
\usage{
load_delegations()
load_gouvernorats()
load_national()
load_secteurs()
}
\value{A \code{data.frame}. Cached after first load.}
\examples{
del <- load_delegations()
nrow(del)
head(names(del), 10)

gov <- load_gouvernorats()
nrow(gov)

\dontrun{
# Requires download_secteurs() first
sec <- load_secteurs()
table(sec$milieu)
}
}
