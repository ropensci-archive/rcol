#' Classification
#'
#' @export
#' @param dataset_key (character/integer/numeric) dataset identifier
#' @param taxon_id (character/integer/numeric) taxon identifier
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' z <- cp_classification(dataset_key=1000, taxon_id=10, verbose=TRUE)
#' z
#' cp_classification(dataset_key=1000, taxon_id=20, verbose=TRUE)
#' cp_classification(dataset_key=3,
#'  taxon_id="6565450e-1cf2-4dc2-acbb-db728e42e635", verbose=TRUE)
#' }
cp_classification <- function(dataset_key, taxon_id, ...) {
  assert(dataset_key, c("character", "integer", "numeric"))
  assert(taxon_id, c("character", "integer", "numeric"))
  path <- sprintf("dataset/%s/taxon/%s/classification", dataset_key, taxon_id)
  tmp <- cp_GET(col_base(), path, ...)
  handle_taxon(tmp)
}
