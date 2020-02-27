#' Name Parser
#' 
#' @export
#' @param names (character) one or more scientific names to parse
#' @param ... curl options passed on to [crul::verb-GET]
#' @return tibble, with one row for each parsed name
#' @examples \dontrun{
#' cp_parser(names = "Apis mellifera")
#' cp_parser(names = c("Apis mellifera", "Homo sapiens var. sapiens"))
#' }
cp_parser <- function(names, ...) {
  assert(names, "character")
  args <- unlist(lapply(names, function(z) list(name = z)), FALSE)
  tmp <- cp_GET(colplus_base(), "parser/name", query = args, ...)
  return(tibble::as_tibble(tmp$name))
}
