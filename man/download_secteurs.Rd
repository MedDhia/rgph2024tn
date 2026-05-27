\name{download_secteurs}
\alias{download_secteurs}
\title{Download Secteur-Level Data}
\description{Downloads secteur data (6.5 MB) to the package cache.
  Only needed once.}
\usage{
download_secteurs(
  url = "https://data.mohameddhiahammami.com/secteurs.csv.gz",
  force = FALSE, quiet = FALSE)
}
\arguments{
  \item{url}{Character. Download URL.}
  \item{force}{Logical. Re-download if cached.}
  \item{quiet}{Logical. Suppress progress.}
}
\value{File path (invisibly).}
\examples{
\dontrun{
download_secteurs()
sec <- load_secteurs()
}
}
