#' Name Parser
#' 
#' @export
#' @param names (character) one or more scientific names to parse
#' @param ... curl options passed on to [crul::verb-POST]
#' @return tibble, with one row for each parsed name
#' @examples \dontrun{
#' cp_parser(names = "Apis mellifera")
#' cp_parser(names = c("Apis mellifera", "Homo sapiens var. sapiens"))
#' }
cp_parser <- function(names, ...) {
  assert(names, "character")
  names <- paste(names, collapse="\n")
  tmp <- cp_POST(colplus_base(), "parser/name", body = names, ...)
  return(tibble::as_tibble(tmp))
}
