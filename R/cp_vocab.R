#' CoL+ Vocabularies
#'
#' @export
#' @template args
#' @param vocab (character) a vocabulary name
#' @return character vector of words
#' @references https://catalogueoflife.github.io/general/api/api.html#vocabs
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
