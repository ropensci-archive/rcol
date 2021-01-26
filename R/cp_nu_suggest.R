#' Name Usage: Suggest
#'
#' @export
#' @param q (character) main query string. required
#' @param dataset_key (character) a dataset key. required
#' @param fuzzy (logical) Whether or not to do fuzzy search (default: `FALSE`)
#' @param min_rank,max_rank (character) See rank options in [cp_name_match()]
#' @param sort (character) one of name, taxonomic, index_name_id, native,
#' relevance
#' @param reverse (logical) reverse order i assume (default: `FALSE`)
#' @param accepted (logical) limit to accepted names (default: `FALSE`)
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a tibble
#' @examples
#' if (cp_up("/dataset/3/nameusage/suggest?q=Apis")) {
#' cp_nu_suggest(q="Apis", 3)
#' }
cp_nu_suggest <- function(q, dataset_key, fuzzy = FALSE, min_rank = NULL,
  max_rank = NULL, sort = NULL, reverse = FALSE, accepted = FALSE,
  limit = 10, ...) {

  assert(q, "character")
  assert(fuzzy, "logical")
  assert(min_rank, "character")
  assert(max_rank, "character")
  assert(sort, "character")
  assert(reverse, "logical")
  assert(accepted, "logical")
  assert(limit, c("numeric", "integer"))
  args <- cc(list(q = q, fuzzy = as_log(fuzzy), minRank = tou(min_rank),
    maxRank = tou(max_rank), sortBy = sort, reverse = as_log(reverse),
    accepted = as_log(accepted), limit = limit))
  tmp <- cp_GET(col_base(),
    sprintf("dataset/%s/nameusage/suggest", dataset_key), query = args, ...)
  return(tibble::as_tibble(tmp$suggestions))
}
