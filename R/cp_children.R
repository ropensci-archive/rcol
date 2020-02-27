#' Children
#'
#' @export
#' @param dataset_key (character) dataset identifier
#' @param taxon_id (character) taxon identifier
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' z <- cp_children(dataset_key=1000, taxon_id='1')
#' z$result
#' z$result$
#' }
cp_children <- function(dataset_key, taxon_id, ...) {
  assert(dataset_key, c("integer", "numeric"))
  assert(taxon_id, "character")
  path <- sprintf("dataset/%s/taxon/%s/children", dataset_key, taxon_id)
  tmp <- cp_GET(colplus_base(), path, ...)
  tmp$result <- tibble::as_tibble(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
