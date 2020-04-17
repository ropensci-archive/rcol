#' Classification
#'
#' @export
#' @param dataset_key (character/integer/numeric) dataset identifier
#' @param taxon_id (character/integer/numeric) taxon identifier
#' @param ... curl options passed on to [crul::verb-GET]
#' @examples \dontrun{
#' z <- cp_classification(dataset_key=1000, taxon_id=10)
#' z
#' cp_classification(dataset_key=1000, taxon_id=20)
#' cp_classification(dataset_key=3,
#'  taxon_id='709dfa66-43fe-4736-a774-59f821a2ee23')
#' }
cp_classification <- function(dataset_key, taxon_id, ...) {
  assert(dataset_key, c("character", "integer", "numeric"))
  assert(taxon_id, c("character", "integer", "numeric"))
  path <- sprintf("dataset/%s/taxon/%s/classification", dataset_key, taxon_id)
  tmp <- cp_GET(colplus_base(), path, ...)
  handle_taxon(tmp)
}
