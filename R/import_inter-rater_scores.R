
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
    reproducibility_score <- journal <- year <- doi <- molecular <- . <- NULL

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
      assignee = as.factor(assignee),
      software_cite = factor(
        software_cite,
        levels = c("0", "1", "2", "3"),
        ordered = TRUE
      ),
      software_avail = factor(
        software_avail,
        levels = c("0", "1", "2", "3"),
        ordered = TRUE
      ),
      comp_mthds_avail = factor(
        comp_mthds_avail,
        levels = c("0", "1", "2", "3"),
        ordered = TRUE
      ),
      data_avail = factor(
        data_avail,
        levels = c("0", "1", "2", "3"),
        ordered = TRUE
      ),
      software_avail_corrected = factor(
        software_avail_corrected,
        levels =  c("0", "1", "2", "3"),
        ordered = TRUE
      )
    )

  # add a unique identifier value to each article since not all have a DOI
  notes$uid <- seq_along(1:nrow(notes))

  return(notes)
}
