## Optional: convert bundled csv.gz to .rda for LazyData.
## Usage: source("data-raw/make_rda.R")
dir.create("data", showWarnings = FALSE)
for (name in c("delegations", "gouvernorats", "national")) {
  message("  ", name)
  path <- file.path("inst", "extdata", paste0(name, ".csv.gz"))
  df <- read.csv(gzfile(path), check.names = FALSE, stringsAsFactors = FALSE)
  assign(name, df)
  save(list = name, file = file.path("data", paste0(name, ".rda")), compress = "xz")
}
message("Done. Add LazyData: true to DESCRIPTION.")
