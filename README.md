# rgph2024tn

Tunisia 2024 Census (RGPH) — R data package.

```r
install.packages("rgph2024tn", repos = "...")
# or: remotes::install_github("MedDhia/rgph2024tn")

library(rgph2024tn)
del <- load_delegations()   # 279 × 959
gov <- load_gouvernorats()  # 24 × 1059

# Secteur data (6.5 MB download, cached locally):
download_secteurs()
sec <- load_secteurs()      # 5544 × 430

codebook()
gini(del[["raccordement.total.Gaz naturel"]])
theil_decompose(del[["raccordement.total.SONEDE"]], del$region)
```

Source: Institut National de la Statistique (INS), Republic of Tunisia.
