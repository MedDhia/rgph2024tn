#' Load Tunisia Census Data
#'
#' Load data at one of four administrative levels. Delegation,
#' gouvernorat, and national data are bundled with the package.
#' Secteur data must be downloaded once via
#' \code{\link{download_secteurs}}.
#'
#' @return A \code{data.frame}. Column names use dot-separated
#'   indicator paths (e.g., \code{"raccordement.total.SONEDE"}).
#'
#' @examples
#' del <- load_delegations()
#' nrow(del)
#' head(names(del), 10)
#'
#' @name load_data
NULL

.pkg_env <- new.env(parent = emptyenv())

.load_bundled <- function(name) {
  path <- system.file("extdata", paste0(name, ".csv.gz"),
                      package = "rgph2024tn", mustWork = TRUE)
  con <- gzfile(path, open = "rt")
  on.exit(close(con))
  read.csv(con, check.names = FALSE, stringsAsFactors = FALSE)
}

#' @rdname load_data
#' @export
load_delegations <- function() {
  if (is.null(.pkg_env$delegations))
    .pkg_env$delegations <- .load_bundled("delegations")
  .pkg_env$delegations
}

#' @rdname load_data
#' @export
load_gouvernorats <- function() {
  if (is.null(.pkg_env$gouvernorats))
    .pkg_env$gouvernorats <- .load_bundled("gouvernorats")
  .pkg_env$gouvernorats
}

#' @rdname load_data
#' @export
load_national <- function() {
  if (is.null(.pkg_env$national))
    .pkg_env$national <- .load_bundled("national")
  .pkg_env$national
}

#' @rdname load_data
#' @export
load_secteurs <- function() {
  if (is.null(.pkg_env$secteurs)) {
    cache_dir <- tools::R_user_dir("rgph2024tn", which = "cache")
    path <- file.path(cache_dir, "secteurs.csv.gz")
    if (!file.exists(path)) {
      stop("Secteur data not found. Run download_secteurs() first.",
           call. = FALSE)
    }
    con <- gzfile(path, open = "rt")
    on.exit(close(con))
    .pkg_env$secteurs <- read.csv(
      con, check.names = FALSE, stringsAsFactors = FALSE
    )
  }
  .pkg_env$secteurs
}

#' Download Secteur-Level Data
#'
#' Downloads the secteur dataset (6.5 MB compressed) to the package
#' cache directory. Only needed once; subsequent calls to
#' \code{\link{load_secteurs}} use the cached file.
#'
#' @param url Character. URL to download from.
#' @param force Logical. Re-download even if already cached.
#' @param quiet Logical. Suppress progress output.
#'
#' @return The local file path (invisibly).
#'
#' @examples
#' \dontrun{
#' download_secteurs()
#' sec <- load_secteurs()
#' nrow(sec)
#' }
#'
#' @export
download_secteurs <- function(
    url = "https://data.mohameddhiahammami.com/secteurs.csv.gz",
    force = FALSE,
    quiet = FALSE
) {
  cache_dir <- tools::R_user_dir("rgph2024tn", which = "cache")
  if (!dir.exists(cache_dir)) dir.create(cache_dir, recursive = TRUE)
  dest <- file.path(cache_dir, "secteurs.csv.gz")
  if (file.exists(dest) && !force) {
    message("Already downloaded: ", dest)
    return(invisible(dest))
  }
  message("Downloading secteur data (6.5 MB)...")
  download.file(url, dest, mode = "wb", quiet = quiet)
  message("Saved to: ", dest)
  .pkg_env$secteurs <- NULL
  invisible(dest)
}
