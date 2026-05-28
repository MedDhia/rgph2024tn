---
title: 'rgph2024tn: Tunisia 2024 Census Data for R'
tags:
  - R
  - census data
  - Tunisia
  - subnational data
  - spatial inequality
  - MENA
authors:
  - name: Mohamed Dhia Hammami
    orcid: 0000-0000-0000-0000
    affiliation: 1
affiliations:
  - name: Maxwell School of Citizenship and Public Affairs, Syracuse University
    index: 1
date: 28 May 2026
bibliography: paper.bib
---

# Summary

`rgph2024tn` is an R package that provides harmonized data from Tunisia's 2024 *Recensement Général de la Population et de l'Habitat* (RGPH), conducted by the Institut National de la Statistique (INS). The package merges 56 Excel workbooks published by INS into analysis-ready data at four nested administrative levels: national (1 unit), gouvernorat (24 provinces), délégation (279 districts), and secteur (2,082 census sectors, disaggregated into 5,544 sector-milieu rows). It covers 50 thematic indicators spanning education, employment, housing, infrastructure, health coverage, household assets, demography, and disability.

The package bundles three levels of data directly (national, gouvernorat, délégation; 1.4 MB compressed) and provides a download-and-cache function for the larger secteur dataset (6.5 MB), hosted on persistent cloud storage. It includes accessor functions for looking up geographic units by code or name, keyword search across indicator columns, a structured codebook mapping all 50 indicators to their thematic domains, and built-in tools for computing Gini coefficients and Theil index decompositions for spatial inequality analysis.

# Statement of Need

Subnational census data is essential for studying spatial inequality, service delivery, demographic change, and governance in the developing world. Yet while countries like the United States, Canada, and Brazil have dedicated R packages providing census data through clean interfaces [@walker2023tidycensus], most countries in the Middle East, sub-Saharan Africa, and South Asia lack equivalent infrastructure. The data often exists—published by national statistical institutes on government websites—but in formats that impose substantial harmonization costs on every downstream user [@jerven2013poor; @devarajan2013africa].

Tunisia's 2024 RGPH is a case in point. The INS published detailed census results across 56 Excel workbooks, each covering a different thematic domain at a different administrative level. The workbooks use French-language headers, contain byte-order mark encoding artifacts, employ inconsistent column naming conventions across levels (a milieu prefix appears at the délégation level but not at the secteur level), and include indicators that are available only at specific administrative scales. A researcher who wants to work with this data must spend considerable time harmonizing files before any analysis can begin.

`rgph2024tn` eliminates this friction. It provides a single interface to the entire census, with consistent column naming, geographic coordinates for every unit, and functions that handle the cross-level inconsistencies transparently. The package makes Tunisia's 2024 census immediately accessible to political scientists studying spatial inequality [@porteous2022research], demographers studying fertility transitions, health researchers studying coverage gaps, and development economists studying infrastructure access [@stacy2025datause].

Comparable packages exist for a handful of countries: `tidycensus` wraps the US Census Bureau API [@walker2023tidycensus], `cancensus` does the same for Canada, `censobr` provides Brazilian census data via Apache Arrow, and `ColOpenData` serves Colombian census data. For Kenya, `rKenyaCensus` bundles the 2019 census on GitHub. No equivalent exists for any country in the Middle East or North Africa. `rgph2024tn` fills this gap for Tunisia, and its architecture—bundling smaller datasets while hosting larger ones on persistent cloud storage—provides a template for packaging census data from other countries that lack APIs.

The package enables several research applications that were previously impractical without extensive data preparation: mapping spatial inequality in infrastructure access across 279 délégations, decomposing regional disparities using Theil indices, studying the coast-interior development divide at the sector level, analyzing the demographic transition through age-sex pyramids at fine geographic scales, and comparing disability prevalence patterns across urban and rural settlements using the Washington Group framework.

# Functionality

The package provides three groups of functions:

**Data loading.** `load_national()`, `load_gouvernorats()`, and `load_delegations()` load bundled data. `download_secteurs()` retrieves the secteur dataset from cloud storage on first use, caching it locally; `load_secteurs()` loads the cached data.

**Accessors and discovery.** `get_gouvernorat()` and `get_delegation()` look up geographic units by numeric code or French name. `get_secteur()` does the same at the finest level. `get_region()` retrieves all délégations in a planning region. `search_indicator()` searches column names by keyword (e.g., `search_indicator("delegations", "chomage")` returns all unemployment-related columns). `list_indicators()` shows available indicator domains at each level. `codebook()` returns a structured data frame mapping each of the 50 indicators to its thematic domain and description.

**Inequality analysis.** `gini()` computes the Gini coefficient for any numeric vector, handling missing values and edge cases. `theil_decompose()` computes the Theil-T index and decomposes it into between-group and within-group components, returning group-level detail. These functions allow researchers to measure spatial inequality across administrative units and decompose it by region—a common analytical need in subnational comparative research.

The package was validated with 97 programmatic checks covering data integrity, accessor correctness, inequality measure properties, geographic consistency, and value plausibility. It passed `R CMD check --as-cran` with zero errors and zero warnings.

# Acknowledgements

The data was produced by Tunisia's Institut National de la Statistique (INS) as part of the 2024 RGPH. I thank INS for making the census results publicly available.

# References
