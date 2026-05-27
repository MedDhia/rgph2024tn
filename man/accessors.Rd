\name{get_gouvernorat}
\alias{get_gouvernorat}
\alias{get_delegation}
\alias{get_secteur}
\alias{get_region}
\title{Access Geographic Units}
\description{Subset by administrative code, name, or planning region.}
\usage{
get_gouvernorat(code = NULL, name = NULL)
get_delegation(code = NULL, name = NULL)
get_secteur(code = NULL, name = NULL)
get_region(region)
}
\arguments{
  \item{code}{Integer. Administrative code.}
  \item{name}{Character. Partial name (case-insensitive).}
  \item{region}{Character. Planning region.}
}
\value{A \code{data.frame} subset.}
\examples{
get_gouvernorat(11)
get_delegation(name = "Kasserine")
\donttest{get_region("Centre Ouest")}
}
