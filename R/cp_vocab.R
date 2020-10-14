#' CoL+ Vocabularies
#'
#' @export
#' @param vocab (character) a vocabulary name
#' @param ... curl options passed on to [crul::verb-GET]
#' @return character vector of words
#' @examples \dontrun{
#' cp_vocab("rank")
#' cp_vocab("datasetorigin")
#' cp_vocab("datasettype")
#' cp_vocab("matchtype")
#' cp_vocab("taxonomicstatus")
#' }
cp_vocab <- function(vocab, ...) {
  assert(vocab, "character")
  cp_GET(colplus_base(), file.path("vocab", vocab), ...)$name
}
