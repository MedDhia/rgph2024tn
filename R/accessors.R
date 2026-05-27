#' @rdname accessors
#' @export
get_gouvernorat <- function(code = NULL, name = NULL) {
  df <- load_gouvernorats()
  if (!is.null(code)) df <- df[df$code_gouvernorat == as.integer(code), , drop = FALSE]
  if (!is.null(name)) df <- df[grepl(tolower(name), tolower(df$gouvernorat_fr), fixed = TRUE), , drop = FALSE]
  df
}

#' @rdname accessors
#' @export
get_delegation <- function(code = NULL, name = NULL) {
  df <- load_delegations()
  if (!is.null(code)) df <- df[df$code_delegation == as.integer(code), , drop = FALSE]
  if (!is.null(name)) df <- df[grepl(tolower(name), tolower(df$delegation_fr), fixed = TRUE), , drop = FALSE]
  df
}

#' @rdname accessors
#' @export
get_secteur <- function(code = NULL, name = NULL) {
  df <- load_secteurs()
  if (!is.null(code)) df <- df[df$code_secteur == as.integer(code), , drop = FALSE]
  if (!is.null(name)) df <- df[grepl(tolower(name), tolower(df$secteur_fr), fixed = TRUE), , drop = FALSE]
  df
}

#' @rdname accessors
#' @export
get_region <- function(region) {
  df <- load_delegations()
  df[df$region == region, , drop = FALSE]
}


.geo_cols <- c(
  "code_gouvernorat", "gouvernorat_fr", "gouvernorat_ar", "region",
  "district_fr", "code_departement", "code_delegation", "delegation_fr",
  "delegation_ar", "id_delegation_salb_un", "code_secteur", "secteur_fr",
  "secteur_ar", "milieu", "lat", "lon", "delegation_lat", "delegation_lon",
  "entity"
)

.get_loader <- function(level) {
  level <- match.arg(level, c("delegations", "gouvernorats", "secteurs", "national"))
  switch(level,
    delegations  = load_delegations,
    gouvernorats = load_gouvernorats,
    secteurs     = load_secteurs,
    national     = load_national
  )
}

#' @rdname search
#' @export
list_indicators <- function(level = "delegations") {
  df <- .get_loader(level)()
  sort(unique(sub("\\..*$", "", setdiff(names(df), .geo_cols))))
}

#' @rdname search
#' @export
search_indicator <- function(level = "delegations", pattern = "") {
  df <- .get_loader(level)()
  grep(pattern, names(df), value = TRUE, ignore.case = TRUE)
}

#' @export
codebook <- function(domain = NULL) {
  cb <- data.frame(
    indicator = c(
      "niveau_instruction", "analphabetisme", "frequentation_scolaire",
      "frequentation_scolaire_3_17", "scolarisation_6_14",
      "enfants_instruction_10_17", "etat_matrimonial", "enfants_age_sexe",
      "type_logement", "date_construction", "pieces_logement",
      "pieces_utilisees", "superficie", "salle_de_bain", "cuisine",
      "toilette_logement", "toilette_sache", "occupation_logement",
      "occupation_menage", "propriete_logement", "raccordement", "eclairage",
      "eau_potable", "eau_boisson", "distance_eau_potable", "eaux_usees",
      "dechets_menagers", "energie_chauffage_logement",
      "energie_chauffage_eau", "energie_cuisson", "biens_equipement",
      "acces_tic", "usage_internet_sexe", "usage_ordinateur_sexe",
      "usage_internet_sexe_instruction", "usage_ordinateur_sexe_instruction",
      "couverture_sanitaire_type", "couverture_sanitaire_enfants",
      "affiliation_couverture_sociale", "handicap", "difficulte",
      "degre_handicap", "degre_difficulte", "prevalence", "carte_handicap",
      "emploi", "emploi_districts", "migration_interne",
      "migration_externe", "personnes_agees"),
    domain = c(
      rep("education", 6), rep("demography", 2), rep("housing", 12),
      rep("infrastructure", 10), rep("assets", 6), rep("health", 3),
      rep("disability", 6), rep("employment", 5)),
    description = c(
      "Educational attainment (10+)", "Illiteracy rate (10+)",
      "School attendance (3-24)", "School attendance by sex (3-17)",
      "Net enrollment (6-14)", "Children education (10-17)",
      "Marital status by sex", "Children by age and sex",
      "Housing type", "Construction period", "Rooms (logement)",
      "Rooms used", "Surface area", "Bathroom availability", "Kitchen",
      "Toilet availability", "Toilet flush", "Housing occupancy",
      "Tenure type", "Property acquisition", "Utility connections",
      "Lighting source", "Water source", "Drinking water",
      "Distance to water", "Wastewater disposal", "Waste disposal",
      "Home heating energy", "Water heating energy", "Cooking energy",
      "Equipment ownership", "ICT access", "Internet by sex",
      "Computer by sex", "Internet by sex+education",
      "Computer by sex+education", "Health coverage by type",
      "Child health coverage (0-17)", "Social security (18+)",
      "Disability by type (WG)", "Difficulty by type (WG)",
      "Disability severity", "Difficulty severity", "Prevalence rates",
      "Disability card", "Employment rates", "Employment by district",
      "Internal migration", "External migration",
      "Elderly indicators (60+)"),
    deepest_level = c(
      rep("secteur", 6), rep("secteur", 2), rep("secteur", 12),
      rep("secteur", 10), "secteur", rep("gouvernorat", 5),
      rep("secteur", 3), rep("secteur", 6),
      "delegation", "national", "delegation", "delegation", "secteur"),
    stringsAsFactors = FALSE
  )
  if (!is.null(domain)) cb <- cb[cb$domain == domain, , drop = FALSE]
  # Use: cb <- codebook(); print(cb)
  invisible(cb)
}
