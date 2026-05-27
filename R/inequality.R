#' @export
gini <- function(x, na.rm = TRUE) {
  if (na.rm) x <- x[!is.na(x)]
  n <- length(x)
  if (n < 2L || sum(x) == 0) return(NA_real_)
  x <- sort(x)
  idx <- seq_len(n)
  (2 * sum(idx * x) - (n + 1L) * sum(x)) / (n * sum(x))
}

#' @export
theil_decompose <- function(x, group, na.rm = TRUE) {
  if (na.rm) { keep <- !is.na(x) & !is.na(group); x <- x[keep]; group <- group[keep] }
  pos <- x > 0; x <- x[pos]; group <- group[pos]
  n <- length(x)
  if (n < 2L) return(list(total = NA_real_, between = NA_real_,
    within = NA_real_, pct_between = NA_real_, group_detail = NULL))
  mu <- mean(x)
  T_total <- mean((x / mu) * log(x / mu))
  grps <- split(x, group)
  T_between <- 0; T_within <- 0
  detail <- vector("list", length(grps))
  for (i in seq_along(grps)) {
    g <- grps[[i]]; n_g <- length(g); mu_g <- mean(g)
    y_g <- (n_g * mu_g) / (n * mu)
    T_between <- T_between + y_g * log(mu_g / mu)
    T_g <- if (n_g >= 2L) mean((g / mu_g) * log(g / mu_g)) else 0
    T_within <- T_within + y_g * T_g
    detail[[i]] <- data.frame(group = names(grps)[i], n = n_g,
      mean = mu_g, theil = T_g, weight = y_g, stringsAsFactors = FALSE)
  }
  list(total = T_total, between = T_between, within = T_within,
    pct_between = if (T_total > 0) T_between / T_total * 100 else NA_real_,
    group_detail = do.call(rbind, detail))
}
