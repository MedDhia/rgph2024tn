# rgph2024tn <img src="https://img.shields.io/badge/Tunisia-2024_Census-blue" align="right" />

<!-- badges -->
[![CRAN status](https://www.r-pkg.org/badges/version/rgph2024tn)](https://CRAN.R-project.org/package=rgph2024tn)
[![R-CMD-check](https://img.shields.io/badge/R--CMD--check-passing-brightgreen)](https://github.com/MedDhia/rgph2024tn)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Harmonized data from Tunisia's 2024 General Census of Population and Housing** (*Recensement Général de la Population et de l'Habitat*), published by the [Institut National de la Statistique](https://ins.tn) (INS).

50 thematic indicators · 4 administrative levels · 279 délégations · 5,544 sector-milieu units

---

## What's in the data?

The 2024 RGPH is Tunisia's most comprehensive census. This package harmonizes the 56 Excel workbooks released by INS into analysis-ready R data frames:

| Level | Units | Columns | Bundled? |
|---|---|---|---|
| National | 1 | 1,069 | ✓ |
| Gouvernorat | 24 | 1,059 | ✓ |
| Délégation | 279 | 959 | ✓ |
| Secteur | 5,544 | 430 | download once |

**Thematic domains:** education · employment · migration · housing · infrastructure · health coverage · household assets & ICT · demography · disability

Every unit includes geographic coordinates (latitude/longitude) and a planning region classification.

## Installation

```r
# From CRAN (when available):
install.packages("rgph2024tn")

# From GitHub:
# install.packages("remotes")
remotes::install_github("MedDhia/rgph2024tn")
```

## Quick start

```r
library(rgph2024tn)

# Load bundled data
del <- load_delegations()   # 279 rows × 959 columns
gov <- load_gouvernorats()  # 24  rows × 1,059 columns
nat <- load_national()      # 1   row  × 1,069 columns

# Secteur data (6.5 MB, downloaded once and cached locally)
download_secteurs()
sec <- load_secteurs()      # 5,544 rows × 430 columns
```

## Exploring the data

```r
# What indicators are available?
codebook()
codebook("education")

# Search for columns by keyword
search_indicator("delegations", "chomage")
#> "emploi.taux_chomage.Masculin" "emploi.taux_chomage.Feminin" "emploi.taux_chomage.Total"

search_indicator("delegations", "CNAM")

# What's available at each level?
list_indicators("gouvernorats")
list_indicators("secteurs")
```

## Looking up geographic units

```r
# By code
get_gouvernorat(11)
#>   gouvernorat_fr  region   lat    lon  ...
#>   Tunis           Nord Est 36.80  10.17

# By name
get_delegation(name = "Kasserine")

# All délégations in a region
get_region("Centre Ouest")
```

## Measuring spatial inequality

```r
# Gini coefficient across 279 délégations
gini(del[["raccordement.total.Gaz naturel"]])
#> [1] 0.713

gini(del[["raccordement.total.STEG"]])
#> [1] 0.006

# Theil decomposition: between vs. within regions
r <- theil_decompose(del[["raccordement.total.SONEDE"]], del[["region"]])
r$pct_between
#> [1] 46.3   # 46% of water access inequality is between regions
r$group_detail
#>   group          n   mean  theil  weight
#>   Centre Est    58  0.934  0.002  0.136
#>   Centre Ouest  40  0.741  0.013  0.184
#>   ...
```

## Mapping

```r
library(ggplot2)

ggplot(del, aes(lon, lat, color = `emploi.taux_chomage.Total`)) +
  geom_point(size = 2) +
  scale_color_viridis_c(option = "inferno", labels = scales::percent) +
  labs(title = "Unemployment across 279 délégations") +
  coord_fixed(1.2)
```

## Data details

**Column naming convention:** Dot-separated hierarchical paths preserving the INS indicator structure. At the délégation level, columns carry a milieu prefix (`raccordement.total.SONEDE` for total, `raccordement.urbain.SONEDE` for urban). At the secteur level, where each row is already a single milieu, the prefix is dropped (`raccordement.SONEDE`).

**Gouvernorat-only indicators:** `acces_tic`, `usage_internet_sexe`, `usage_internet_sexe_instruction`, `usage_ordinateur_sexe`, `usage_ordinateur_sexe_instruction` — ICT and internet data available only at the gouvernorat level.

**National-only indicators:** `emploi_districts` — employment by planning district.

**Dependencies:** `utils` only. The package works with base R. `dplyr`, `ggplot2`, and `sf` are suggested but not required.

## Citation

If you use this package in your research, please cite:

```
Hammami, M. D. (2026). rgph2024tn: Tunisia 2024 General Census of
  Population and Housing. R package version 0.1.0.
  https://github.com/MedDhia/rgph2024tn
```

And the original data source:

```
Institut National de la Statistique (2024). Recensement Général de la
  Population et de l'Habitat 2024. Republic of Tunisia. https://ins.tn
```

In R:
```r
citation("rgph2024tn")
```

## License

MIT © Mohamed Dhia Hammami

## Data source

All data is from the [Institut National de la Statistique](https://ins.tn) (INS), Republic of Tunisia. The secteur dataset is hosted at [data.mohameddhiahammami.com](https://data.mohameddhiahammami.com/secteurs.csv.gz).
