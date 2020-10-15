#' Children
#'
#' @export
#' @param dataset_key (character/integer/numeric) dataset identifier
#' @param taxon_id (character/integer/numeric) taxon identifier
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' z <- cp_children(dataset_key=1000, taxon_id='1')
#' z
#' z$result
#' z$result$scientificName
#' z$result$created
#' }
cp_children <- function(dataset_key, taxon_id, ...) {
  assert(dataset_key, c("character", "integer", "numeric"))
  assert(taxon_id, c("character", "integer", "numeric"))
  path <- sprintf("dataset/%s/taxon/%s/children", dataset_key, taxon_id)
  tmp <- cp_GET(colplus_base(), path, ...)
  tmp$result <- handle_taxon(tmp$result)
  tmp <- cp_meta(tmp)
  return(tmp)
}
