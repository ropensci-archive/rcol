#' Descisions
#' 
#' List of editorial decisions with optional filters.
#'
#' @export
#' @param dataset_key (character) The catalogue dataset the sector is attached
#' to. optional
#' @param subject_dataset_key (character) The source dataset the subject
#' belongs to. optional
#' @param user_key (character) The user that last modified the sector. optional
#' @param rank (character) The rank of the subject. optional. one of the 
#' rank types:
#' https://catalogueoflife.github.io/general/api/api.html#model-RankType 
#' @param mode (character) The sector mode, e.g. ATTACH. optional
#' @param broken (logical) If `TRUE` only show decisions which cannot be linked
#' to a source name usage. optional
#' @param start (integer) requested number of offset records. Default: 0
#' @param limit (integer) requested number of maximum records to be returned.
#' Default: 10; max: 1000
#' @param  (character) a dataset key to filter by. optional
#' @param ... curl options passed on to [crul::verb-GET]
#' @return list
#' @examples \dontrun{
#' x <- cp_decision()
#' x
#' }
cp_decision <- function(dataset_key = NULL,
  subject_dataset_key = NULL, user_key = NULL, rank = NULL, mode = NULL,
  broken = NULL, start = 0, limit = 10, ...) {

  assert(dataset_key, "character")
  assert(subject_dataset_key, "character")
  assert(user_key, "character")
  assert(rank, "character")
  assert(mode, "character")
  assert(broken, "logical")
  assert(start, c("numeric", "integer"))
  assert(limit, c("numeric", "integer"))
  args <- cc(list(datasetKey = dataset_key,
    subjectDatasetKey = subject_dataset_key, user_key = user_key,
    rank = rank, mode = mode, broken = as_log(broken), offset = start,
    limit = limit))
  tmp <- cp_GET(colplus_base(), "decision", query = args, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
