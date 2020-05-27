#' Datasets API route catch all method
#' 
#' @export
#' @param route (character) an API route. the `/dataset` route
#' part is added internally; so just include the route following that.
#' required.
#' @param ... named parameters, passed on to [glue::glue()]. required.
#' param names must match must match names given in the `route`. For
#' example, if you have `route = \\{key\\}/name\\{id\\}`, then you need
#' to pass in a `key` and an `id` parameter. The names in the route 
#' (here, key and id) don't have to match the names in the API route you
#' are trying to use - they just need to match the named parameters you
#' pass in. Having said that, it may be easier to remember what you're
#' doing if you match the names to the route parts.
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
#' cp_ds(route = "{key}/name/{id}", key = 1005, id = 100003)
cp_ds <- function(route, ...) {
  route <- file.path("dataset", route)
  if (grepl("logo", route)) stop("logo route not supported", call.=FALSE)
  path <- glue::glue(route, ...)
  cp_GET(colplus_base(), path)
}
