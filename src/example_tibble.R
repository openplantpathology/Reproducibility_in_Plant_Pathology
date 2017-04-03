reproducibility <- tibble::tibble(
  Article = "The Area Under the Disease Progress Stairs: Calculation, Advantage, and Application",
  DOI = "PHYTO-07-11-0216",
  Journal = "Phytopathology",
  Authors =  "Ivan Simko and Hans-Peter Piepho",
  Year = 2012,
  Vol = 102,
  Iss = 4,
  pp = "381-389",
  IF = 3.011,
  Journal_class = "Fundamental",
  Page_charges = 130,
  Country =  "USA",
  Open_or_Restricted = "Optional",
  Reproducibility_instructions = FALSE,
  Iss_per_Year = 12,
  Supl_mats = TRUE,
  Comp_methods = 2,
  Raw_data = 0,
  Reproducibility_score = NA
)

reproducibility$Reproducibility_score <- reproducibility$Comp_methods + reproducibility$Raw_data

