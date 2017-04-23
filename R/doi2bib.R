#' Convert doi to bibtex
#'
#' Convert a digital object identifier (doi) string into a bibtex entry using
#' the web service <http://www.doi2bib.org>.
#'
#' @param doi The character string of the doi.
#' @return a bibtex entry as a character string.
#'
#' @examples
#' doi2bib("10.4454/jpp.fa.2012.002")
#'
#' @note
#' Original script from William Keith Morris,
#' <https://gist.github.com/wkmor1/ae2cc96acad472d49c35>.  Documented for use
#' in an R package by Adam H Sparks
#'
#' @author William Keith Morris <wkmor1@gmail.com> and Adam H Sparks
#'
#' @name doi2bib
#' @rdname doi2bib-methods
#' @exportMethod doi2bib

setGeneric("doi2bib",
           function(doi) {
             standardGeneric("doi2bib")
           })

#' @rdname doi2bib-methods
#' @aliases doi2bib,ANY-method
setMethod("doi2bib",
          c(doi = "character"),
          function(doi) {
            httr::content(
              httr::GET(
                url    = "http://www.doi2bib.org/",
                config = httr::accept("application/x-bibtex"),
                path   = "doi2bib",
                query  = list(id = doi)
              ),
              as = "text"
            )
          })
