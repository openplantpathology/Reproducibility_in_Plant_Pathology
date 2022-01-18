#' Convert DOI to Bibtex
#'
#' Convert a digital object identifier (\acronym{DOI}) string into a bibtex
#' entry using the web service \url{http://www.doi2bib.org}.
#'
#' @param ... One or more \acronym{DOI}s, as \code{character} strings. If
#'   arguments are named, names will replace default citekeys.
#' @param file an optional \code{character} string. If used, the bibtex
#'   references are sent to \code{file} rather than being returned.
#' @param append \code{logical}. Append results to file?
#' @param quiet \code{logical}. By default, bibtex references are printed to the
#'   console. By setting \code{quiet} to \code{TRUE}, this behaviour will be
#'   prevented.
#'
#' @note This function is take from the unrelased (on CRAN) \R package,
#'  \pkg{doi2bib} by William Keith Morris available from GitHub under the MIT
#'  Licence.  The full package has been forked to Open Plant Pathology's
#'  GitHub account \url{https://github.com/openplantpathology/doi2bib}.
#'
#' @return a \code{list}, returned invisibly, of bibtex references as
#'   \code{character} strings, as well as writing to file if \code{file} is
#'   specified.
#'
#' @importFrom httr accept content GET
#' @importFrom methods setGeneric setMethod signature
#' @importFrom xml2 xml_text xml_find_all
#' @importFrom stats setNames
#'
#' @examples
#' doi2bib(Margules2000 = "10.1038/35012251")
#' doi2bib(Margules2000 = "10.1038/35012251",
#'         Myers2000    = "10.1038/35002501",
#'         Moilanen     = "978-0199547777")
#' @author William Keith Morris, \email{wkmor1@@gmail.com}
#' @references \url{https://github.com/wkmor1/doi2bib}
#' @export

setGeneric("doi2bib",
           function(...,
                    file,
                    append = TRUE,
                    quiet = FALSE) {
             standardGeneric("doi2bib")
           },
           signature = signature("..."))

replace_citekeys <-
  function(refs, nms) {
    setNames(mapply(function(ref, nm) {
      ifelse(nchar(nm) < 1,
             ref,
             sub("([^\\{]+\\{)[^,]+", paste0("\\1", nm), ref))
    },
    refs,
    nms,
    SIMPLIFY = FALSE),
    nms)
  }

refs_to_file <-
  function(refs, file, append) {
    cat(paste(refs, collapse = "\n"),
        file = file,
        append = append)
  }

get_doi <-
  function(doi) {
    content(
      GET(
        url    = "http://www.doi2bib.org/",
        config = accept("application/x-bibtex"),
        path   = "doi2bib",
        query  = list(id = doi)
      ),
      as = "text",
      encoding = "UTF-8"
    )
  }

get_isbn <-
  function(isbn)
    xml_text(xml_find_all(
      content(
        GET(
          url    = "http://lead.to/",
          path   = "amazon/en",
          query  = list(key = isbn, op = "bt")
        ),
        as =  "parsed",
        encoding = "UTF-8"
      ),
      "//div[contains(@class,'lef3em')]"
    ))

get_identifier <- function(id) {
  if (grepl("/", id, fixed = TRUE))
    get_doi(id)
  else
    get_isbn(id)
}

#'@describeIn doi2bib Convert DOI to bibtex
setMethod("doi2bib",
          "character",
          function(..., file, append, quiet) {
            stopifnot(missing(file) || is.character(file))
            stopifnot(is.logical(quiet))
            stopifnot(has_connection())

            dois <- c(...)

            refs <- lapply(dois, get_identifier)

            nms <- names(dois)

            if (!is.null(nms)) {
              refs <- replace_citekeys(refs, nms)
            }

            if (!quiet)
              message(paste(refs, collapse = "\n"))

            if (!missing(file)) {
              refs_to_file(refs, file, append)
            }

            invisible(refs)

          })

# skip test if can't connect to doi2bib.org
has_connection <-
  function() {
    !httr::http_error("http://www.doi2bib.org/")
  }
