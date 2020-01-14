#' Name Usage: Suggest
#'
#' @export
#' @param q (character) main query string
#' @param datasetKey (character) dataset key
#' @param vernaculars (logical) Whether or not to include vernacular names
#' in the suggestions (default: `FALSE`)
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param ... curl options passed on to [crul::verb-GET]
cp_nameusage_suggest <- function(q = NULL, datasetKey = NULL,
  vernaculars = FALSE, limit = 10, ...) {

  stop("AFAICT this route isn't working yet")

  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, datasetKey = datasetKey, vernaculars = vernaculars,
    limit = limit))
  tmp <- cp_GET(colplus_base(), "nameusage/suggest", query = args, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
