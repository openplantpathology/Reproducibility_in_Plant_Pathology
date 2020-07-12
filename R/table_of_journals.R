
#' Create Table of Journals Surveyed
#' @param rrpp `data.frame` of article evaluations
#' @return \pkg{pander} table of journals surveyed
#' @export table_of_journals
#'
#' @examples
#' \donttest{
#' rrpp <- googlesheets4::read_sheet(
#'"https://docs.google.com/spreadsheets/d/19gXobV4oPZeWZiQJAPNIrmqpfGQtpapXWcSxaXRw1-M"
#')
#' table_of_journals(rrpp)
#' }
#'
table_of_journals <- function(rrpp) {

rrpp_journals <- as.data.frame(table(rrpp[, 1]))
names(rrpp_journals) <- c("Journal", "Count")
return(pander::pander(rrpp_journals))
}
