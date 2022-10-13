
#' Import reproducibility score notes
#'
#' Imports, formats data into proper types and calculates the final
#' reproducibility score. Also adds the 2 and 5 year impact factor values from
#' InCites Journal Citation Reports for 2018.
#'
#' @return A [tibble::tibble()] object of reproducibility score notes formatted
#' for use in analysis and manuscript preparation
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

  notes <- readODS::read_ods(
    system.file(
      "extdata",
      "Reproducibility_in_plant_pathology_notes.ods",
      package = "Reproducibility.in.Plant.Pathology"
    ),
    na = "NA",
    sheet = "article_evaluations"
  )

  notes$open <- gsub("1", "TRUE", x = notes$open)

  IF_5year <- readODS::read_ods(
    system.file(
      "extdata",
      "Reproducibility_in_plant_pathology_notes.ods",
      package = "Reproducibility.in.Plant.Pathology"
    ),
    na = "NA",
    sheet = "5yr IF"
  )


  notes <-
    notes %>%
    dplyr::left_join(x = notes,
                     y = IF_5year,
                     by = c("journal" = "journal")) %>%
    dplyr::mutate(IF_5year =
                    dplyr::if_else(
                      condition = is.na(IF_5year),
                      true = 0,
                      false = IF_5year
                    )) %>%
    dplyr::mutate(
      journal = as.factor(journal),
      art_class = as.factor(art_class),
      repro_inst = as.factor(repro_inst),
      open = as.factor(open),
      abbreviation = as.factor(abbreviation),
      assignee = as.factor(assignee),
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
      )
    )

  # add a unique identifier value to each article since not all have a DOI
  notes$uid <- seq_along(1:nrow(notes))

  return(notes)
}
