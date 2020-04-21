
#' Import Reproducibility Score Notes
#'
#' Imports, formats data into proper types and calculates the final
#'  reproducibility score
#'
#' @return A `tibble` object of reproducibility score notes formatted for use in
#'  analysis and manuscript preparation
#' @export import_rrpp
#'
#' @examples
#' import_rrpp()
#' pander::pander(head(rrpp))
import_rrpp <- function() {
  readr::read_csv(
    system.file("extdata",
                "article_notes.csv",
                package = "Reproducibility.in.Plant.Pathology"),
    na = "NA"
  ) %>%
    dplyr::mutate(
      reproducibility_score =
        dplyr::if_else(
          condition = data_avail > 0,
          true = as.integer(comp_mthds_avail) +
            as.integer(software_avail) +
            as.integer(software_cite) +
            as.integer(data_avail),
          false = as.integer(data_avail),
          missing = as.integer(0)
        )
    ) %>%
    dplyr::mutate(IF_5year =
                    dplyr::if_else(
                      condition = is.na(IF_5year),
                      true = 0,
                      false = IF_5year
                    )) %>%
    dplyr::mutate(art_class = as.factor(art_class)) %>%
    dplyr::mutate(repro_inst = as.factor(repro_inst)) %>%
    dplyr::mutate(open = as.factor(open)) %>%
    dplyr::mutate(abbreviation = as.factor(abbreviation)) %>%
    dplyr::mutate(assignee = as.factor(assignee)) %>%
    dplyr::filter(!is.na(reproducibility_score))
}
