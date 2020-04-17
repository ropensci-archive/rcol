#' Datasets API route catch all method
#' 
#' @export
#' @param route (character) an API route. the `/dataset` route
#' part is added internally; so just include the route following that.
#' required.
#' @param ... named parameters, passed on to [glue::glue()]. required.
#' param names must match `\\{key\\}` given in the `route`
#' @details There are A LOT of datasets API routes. Instead of making
#' an R function for each route, we have R functions for some of the
#' "more important" routes, then `cp_ds()` will allow you to make
#' requests to the remainder of the datasets API routes.
#' @section Not supported dataset routes:
#' Some dataset routes do not return JSON so we don't support those. 
#' Thus far, the only route we don't support is `/dataset/\\{key\\}/logo`
#' @examples
#' cp_ds(route = "{key}/namesdiff", key = "1000")
#' cp_ds(route = "{key}/reference", key = "1000")
#' cp_ds(route = "{key}/tree", key = "1000")
#' cp_ds(route = "{key}/tree", key = "1014")
cp_ds <- function(route, ...) {
  route <- file.path("dataset", route)
  if (grepl("logo", route)) stop("logo route not supported", call.=FALSE)
  path <- glue::glue(route, ...)
  cp_GET(colplus_base(), path)
}
