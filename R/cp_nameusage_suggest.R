#' Name Usage: Suggest
#'
#' @export
#' @param q (character) main query string. required
#' @param datasetKey (character) dataset key. required
#' @param vernaculars (logical) Whether or not to include vernacular names
#' in the suggestions (default: `FALSE`)
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a tibble
#' @examples \dontrun{
#' cp_nameusage_suggest(q="Apis", datasetKey = 3)
#' }
cp_nameusage_suggest <- function(q, datasetKey, vernaculars = FALSE, limit = 10,
  ...) {

  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, datasetKey = datasetKey, vernaculars = vernaculars,
    limit = limit))
  tmp <- cp_GET(colplus_base(), "nameusage/suggest", query = args, ...)
  return(tibble::as_tibble(tmp$suggestions))
}
