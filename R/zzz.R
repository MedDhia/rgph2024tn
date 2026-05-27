#' @keywords internal
"_PACKAGE"

.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "rgph2024tn ", utils::packageVersion("rgph2024tn"), "\n",
    "Tunisia 2024 Census | 24 gov | 279 del | 2082 sec | 46 indicators\n",
    "Bundled: delegations, gouvernorats, national. Run download_secteurs() for secteurs.")
}
