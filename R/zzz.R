cc <- function(x) Filter(Negate(is.null), x)

`%||%` <- function(x, y) if (is.null(x) || length(x) == 0) y else x

as_log <- function(x) {
  if (is.null(x)) {
    x
  } else {
    if (x) "true" else "false"
  }
}

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!class(x) %in% y) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

cp_meta <- function(x) {
  meta_cols <- c("offset", "limit", "total", "last", "empty")
  x$meta <- tibble::as_tibble(x[names(x) %in% meta_cols])
  for (i in seq_along(meta_cols)) x[[ meta_cols[i] ]] <- NULL
  return(x)
}

# br <- function(x) {
#   (x <- data.table::setDF(
#     data.table::rbindlist(x, use.names = TRUE, fill = TRUE, idcol = "id")))
# }

# run_bind <- function(id, fun, ...) {
#   tibble::as_tibble(br(ccn(
#     stats::setNames(lapply(id, fun, ...), id)
#   )))
# }
