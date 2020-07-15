
#' Import Reproducibility Score Notes
#'
#' Imports, formats data into proper types and calculates the final
#'  reproducibility score. Also adds the 2 and 5 year impact factor values from
#'  InCites Journal Citation Reports for 2018.
#'
#' @return A `tibble` object of reproducibility score notes formatted for use in
#'  analysis and manuscript preparation
#' @export import_notes
#'
#' @examples
#' notes <- import_notes()
#' pander::pander(head(notes))
#'
#' @importFrom magrittr "%>%"
#'

import_notes <- function() {
  # CRAN Note Avoidance
  data_avail <-
    comp_mthds_avail <- software_avail <- software_cite <-
    IF_5year <-
    art_class <- repro_inst <- abbreviation <- assignee <-
    reproducibility_score <- journal <- year <- . <- NULL

  notes <- readr::read_csv(
    system.file("extdata",
                "article_notes.csv",
                package = "Reproducibility.in.Plant.Pathology"),
    na = "NA"
  )

  IF_5year <- readr::read_csv(
    system.file("extdata",
                "2018_5-year_IF.csv",
                package = "Reproducibility.in.Plant.Pathology"),
    na = "NA"
  )

  notes <-
    notes %>%
    dplyr::left_join(x = notes, y = IF_5year, by = c("journal" = "journal")) %>%
    dplyr::mutate(IF_5year =
                    dplyr::if_else(
                      condition = is.na(IF_5year),
                      true = 0,
                      false = IF_5year
                    )) %>%
    dplyr::mutate(journal = as.factor(journal)) %>%
    dplyr::mutate(year = as.factor(year)) %>%
    dplyr::mutate(art_class = as.factor(art_class)) %>%
    dplyr::mutate(repro_inst = as.factor(repro_inst)) %>%
    dplyr::mutate(open = as.factor(open)) %>%
    dplyr::mutate(abbreviation = as.factor(abbreviation)) %>%
    dplyr::mutate(assignee = as.factor(assignee))

  # add reproducibility score as a percent of total possible
  #
  # calculate total possible score for a paper
  total_possible <-
    notes %>%
    dplyr::select(comp_mthds_avail, software_avail, software_cite, data_avail) %>%
    dplyr::mutate(total_possible = rowSums(!is.na(.)) * 3) %>%
    dplyr::select(total_possible)

  # calculate reproducibility score
  notes <-
    notes %>%
    tibble::add_column(total_possible) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(reproducibility_score =
                    (
                      sum(
                        comp_mthds_avail,
                        software_avail,
                        software_cite,
                        data_avail,
                        na.rm = TRUE
                      ) / total_possible
                    ) * 100)

  return(notes)
}
