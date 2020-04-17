#' Estimates
#' 
#' Species estimates are linked to a target taxon of a managed catalogue.
#'
#' @export
#' @param dataset_key (character) The catalogue dataset the sector is attached
#' to. optional
#' @param user_key (character) The user that last modified the sector. optional
#' @param rank (character) The rank of the subject. optional. one of the 
#' rank types:
#' https://catalogueoflife.github.io/general/api/api.html#model-RankType 
#' @param min (integer/numeric) the minimum number of estimated species
#' @param max (integer/numeric) the maximum number of estimated species
#' @param broken (logical) If `TRUE` only show decisions which cannot be linked
#' to a source name usage. optional
#' @param start (integer) requested number of offset records. Default: 0
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param  (character) a dataset key to filter by. optional
#' @param ... curl options passed on to [crul::verb-GET]
#' @return list
#' @examples \dontrun{
#' x <- cp_estimate()
#' x
#' }
cp_estimate <- function(dataset_key = NULL, user_key = NULL, rank = NULL,
  min = NULL, max = NULL, broken = NULL, start = 0, limit = 10, ...) {

  assert(dataset_key, "character")
  assert(user_key, "character")
  assert(rank, "character")
  assert(min, c("numeric", "integer"))
  assert(max, c("numeric", "integer"))
  assert(broken, "logical")
  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  args <- cc(list(datasetKey = dataset_key, user_key = user_key,
    rank = rank, min = min, max = max, broken = as_log(broken),
    offset = start, limit = limit))
  tmp <- cp_GET(colplus_base(), "estimate", query = args, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
