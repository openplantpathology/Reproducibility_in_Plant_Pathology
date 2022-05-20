
#' Import scoring notes checking inter-rater repeatability
#'
#' Imports, formats data into proper types and calculates the final
#' reproducibility score.
#'
#' @return A [tibble::tibble()] object of reproducibility score notes formatted
#' for use in analysis and manuscript preparation
#' @export import_interrater_scores
#'
#' @examples
#' notes <- import_notes()
#' pander::pander(head(notes))
#'
#' @importFrom magrittr "%>%"
#'

import_interrater_scores <- function() {
  # CRAN Note Avoidance
  data_avail <-
    comp_mthds_avail <-
    software_avail <- software_avail_corrected <-
    software_cite <-
    IF_5year <- art_class <- repro_inst <- abbreviation <-
    assignee <-
    reproducibility_score <- journal <- year <- . <- NULL

  notes <- readODS::read_ods(
    system.file(
      "extdata",
      "Reproducibility_in_plant_pathology_notes.ods",
      package = "Reproducibility.in.Plant.Pathology"
    ),
    na = "NA",
    sheet = "inter-rater_score_check"
  )

  notes <-
    notes %>%
    dplyr::mutate(doi = as.factor(doi)) %>%
    dplyr::mutate(art_class = as.factor(art_class)) %>%
    dplyr::mutate(molecular = as.factor(molecular)) %>%
    dplyr::mutate(assignee = as.factor(assignee))

  # add reproducibility score as a percent of total possible
  #
  # calculate total possible score for a paper
  total_possible <-
    notes %>%
    dplyr::select(
      comp_mthds_avail,
      software_avail,
      software_avail_corrected,
      software_cite,
      data_avail
    ) %>%
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
                        software_avail_corrected,
                        software_cite,
                        data_avail,
                        na.rm = TRUE
                      ) / total_possible
                    ) * 100)

  # create mean assignee rating value
  notes <-
    notes %>%
    dplyr::group_by(assignee) %>%
    dplyr::summarise(mean_assignee = mean(reproducibility_score)) %>%
    dplyr::full_join(notes, by = "assignee")

  # add a unique identifier value to each article since not all have a DOI
  notes$uid <- seq_along(1:nrow(notes))

  return(notes)
}
