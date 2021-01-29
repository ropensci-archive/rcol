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
#' @return a named list, with slots `offset` (integer), `limit` (integer),
#' `total` (integer), `result` (list), `empty` (boolean),
#' and `last` (boolean). The `result` slot is a list itself, with any
#' number of results as named lists
#' @examples
#' if (cp_up("/importer?limit=1")) {
#' cp_importer(limit = 1)
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
  cp_GET(col_base(), "importer", query = args, parse = FALSE, ...)
}
