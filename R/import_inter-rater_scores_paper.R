
#' Import scoring notes checking inter-rater repeatability for paper publication
#'
#' Imports, formats data into proper types and calculates the final
#' reproducibility score.
#'
#' @return A [tibble::tibble()] object of reproducibility score notes formatted
#' for use in analysis and manuscript preparation
#' @export import_interrater_scores_paper
#'
#' @examples
#' notes <- import_notes()
#' pander::pander(head(notes))
#'
#' @importFrom magrittr "%>%"
#'

import_interrater_scores_paper <- function() {
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
    dplyr::mutate(
      doi = as.factor(doi),
      art_class = as.factor(art_class),
      molecular = as.factor(molecular),
      assignee = as.factor(assignee)
    )

  # add a unique identifier value to each article since not all have a DOI
  notes$uid <- seq_along(1:nrow(notes))

  return(notes)
}
