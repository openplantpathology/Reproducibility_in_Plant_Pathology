
#' Create Table of Journals Surveyed
#'
#' @return pander table of journals surveyed
#' @export table_of_journals
#'
#' @examples
#'
#' table_of_journals()
#'
table_of_journals <- function() {
  rrpp <- gsheet::gsheet2tbl(
  "https://docs.google.com/spreadsheets/d/19gXobV4oPZeWZiQJAPNIrmqpfGQtpapXWcSxaXRw1-M/edit#gid=1699540381"
)

rrpp_journals <- as.data.frame(table(rrpp[, 1]))
names(rrpp_journals) <- c("Journal", "Count")
return(pander::pander(rrpp_journals))
}
