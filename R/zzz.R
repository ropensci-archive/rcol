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

move_cols <- function(x, cols) {
  x[c(cols, names(x)[!names(x) %in% cols])]
}

bind <- function(x) {
  (x <- data.table::setDF(
    data.table::rbindlist(x, use.names = TRUE, fill = TRUE, idcol = "id")))
}

bindtbl <- function(x) tibble::as_tibble(bind(x))

handle_taxon <- function(x) {
  if (!length(x)) return(tibble::tibble())
  rmv <- c("created", "createdBy", "modified", "modifiedBy", "datasetKey",
    "id", "verbatimKey")
  for (i in rmv) x[[i]] <- NULL
  df <- cbind(x$name,
    x[names(x) %in% c("status", "parentId", "synonym", "taxon", "bareName")])
  first_cols <- c("scientificName", "rank", "id", "status")
  df <- move_cols(df, first_cols)
  return(tibble::as_tibble(df))
}
