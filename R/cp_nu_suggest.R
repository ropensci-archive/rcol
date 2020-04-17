#' Name Usage: Suggest
#'
#' @export
#' @param q (character) main query string. required
#' @param dataset_key (character/integer/numeric) dataset key. required
#' @param vernaculars (logical) Whether or not to include vernacular names
#' in the suggestions (default: `FALSE`)
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a tibble
#' @examples \dontrun{
#' cp_nu_suggest(q="Apis", dataset_key = 3)
#' }
cp_nu_suggest <- function(q, dataset_key, vernaculars = FALSE, limit = 10,
  ...) {

  assert(q, "character")
  assert(dataset_key, c("character", "integer", "numeric"))
  assert(vernaculars, "logical")
  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, datasetKey = dataset_key,
    vernaculars = as_log(vernaculars), limit = limit))
  tmp <- cp_GET(colplus_base(), "nameusage/suggest", query = args, ...)
  return(tibble::as_tibble(tmp$suggestions))
}
