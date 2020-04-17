#' Importer metrics
#'
#' @export
#' @template args
#' @param dataset_key (character) a dataset key to filter by. optional
#' @param state (character) filter listed import metrics by their state,
#' e.g. the last failed import. one of: downloading, processing, inserting,
#' unchanged, finished, canceled, failed. optional
#' @param running (logical) if only a list of running imports should
#' be returned. default: `FALSE`. optional
#' @return list
#' @examples \dontrun{
#' cp_importer()
#' }
cp_importer <- function(dataset_key = NULL, state = NULL, running = FALSE,
  start = 0, limit = 10, ...) {

  assert(dataset_key, "character")
  assert(state, "character")
  assert(running, "logical")
  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  args <- cc(list(datasetKey = dataset_key, state = state, running = running,
    offset = start, limit = limit))
  cp_GET(colplus_base(), "importer", query = args, parse = FALSE, ...)
}
