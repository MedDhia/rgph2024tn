test_that("delegations: 279 rows, clean columns", {
  del <- load_delegations()
  expect_equal(nrow(del), 279)
  expect_true("delegation_fr" %in% names(del))
  expect_equal(names(del)[1], "code_gouvernorat")
  expect_true(ncol(del) >= 900)
})
test_that("gouvernorats: 24 rows", {
  expect_equal(nrow(load_gouvernorats()), 24)
})
test_that("national: 1 row", {
  expect_equal(nrow(load_national()), 1)
})
test_that("secteurs: errors without download", {
  expect_error(load_secteurs(), "download_secteurs")
})
test_that("caching", {
  expect_identical(load_delegations(), load_delegations())
})
test_that("get_gouvernorat by code", {
  expect_equal(get_gouvernorat(11)$gouvernorat_fr, "Tunis")
})
test_that("get_gouvernorat by name", {
  expect_equal(nrow(get_gouvernorat(name = "Sfax")), 1)
})
test_that("get_delegation by code", {
  expect_equal(nrow(get_delegation(1151)), 1)
})
test_that("get_region", {
  co <- get_region("Centre Ouest")
  expect_true(nrow(co) > 0)
  expect_true(all(co$region == "Centre Ouest"))
})
test_that("coordinates in Tunisia", {
  del <- load_delegations()
  expect_true(all(del$lat > 30 & del$lat < 38))
  expect_true(all(del$lon > 7 & del$lon < 12))
  expect_true(!any(is.na(del$lat)))
})
test_that("list_indicators", {
  expect_true("emploi" %in% list_indicators())
})
test_that("search_indicator", {
  expect_true(length(search_indicator("delegations", "chomage")) > 0)
})
test_that("codebook", {
  cb <- codebook()
  expect_true(is.data.frame(cb))
  expect_true(nrow(cb) >= 46)
  expect_true(all(codebook("education")$domain == "education"))
})
test_that("gini known cases", {
  expect_equal(gini(rep(1, 100)), 0)
  expect_true(gini(c(rep(0, 99), 100)) > 0.98)
  expect_true(is.na(gini(c(NA, NA))))
})
test_that("gini real data", {
  del <- load_delegations()
  expect_true(gini(del[["raccordement.total.Gaz naturel"]]) > 0.5)
  expect_true(gini(del[["raccordement.total.STEG"]]) < 0.05)
})
test_that("theil additivity", {
  del <- load_delegations()
  r <- theil_decompose(del[["raccordement.total.SONEDE"]], del[["region"]])
  expect_true(abs(r$total - r$between - r$within) < 0.01)
  expect_true(nrow(r$group_detail) == 6)
})
test_that("hierarchy consistency", {
  gov_codes <- unique(load_gouvernorats()$code_gouvernorat)
  del_gov <- unique(load_delegations()$code_gouvernorat)
  expect_true(all(del_gov %in% gov_codes))
})
test_that("all 6 regions present", {
  regions <- unique(load_delegations()$region)
  expected <- c("Nord Est", "Nord Ouest", "Centre Est",
                "Centre Ouest", "Sud Est", "Sud Ouest")
  expect_true(all(expected %in% regions))
})
