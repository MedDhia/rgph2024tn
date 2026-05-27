\name{list_indicators}
\alias{list_indicators}
\alias{search_indicator}
\title{Search and List Indicators}
\description{Discover indicator prefixes or search column names.}
\usage{
list_indicators(level = "delegations")
search_indicator(level = "delegations", pattern = "")
}
\arguments{
  \item{level}{Character. One of \code{"delegations"}, \code{"gouvernorats"},
    \code{"secteurs"}, \code{"national"}.}
  \item{pattern}{Character. Regex (case-insensitive).}
}
\value{Character vector.}
\examples{
list_indicators("delegations")
search_indicator("delegations", "chomage")
}
