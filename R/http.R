colplus_base <- function() "https://api.catalogue.life"

cp_ua <- function() {
  versions <- c(paste0("r-curl/", utils::packageVersion("curl")),
    paste0("crul/", utils::packageVersion("crul")),
    sprintf("rOpenSci(colpluz/%s)", utils::packageVersion("colpluz")))
  paste0(versions, collapse = " ")
}
cp_ual <- list(`User-Agent` = cp_ua(), `X-USER-AGENT` = cp_ua())

cp_GET <- function(url, path = NULL, query = list(), headers = list(),
  opts = list(), parse = TRUE, ...) {
  
  cli <- crul::HttpClient$new(url,
    headers = c(headers, cp_ual), opts = c(opts, list(...)))
  out <- cli$get(path = path, query = query)
  return(cp_error_handle(out, parse = parse))
}

cp_POST <- function(url, path = NULL, query = list(), body = list(),
  headers = list(), opts = list(), parse = TRUE, ...) {
  
  cli <- crul::HttpClient$new(url,
    headers = c(headers, cp_ual, "Content-Type" = "text/plain"),
    opts = c(opts, list(...)))
  out <- cli$post(path = path, query = query, body = body)
  return(cp_error_handle(out, parse = parse))
}

cp_error_handle <- function(x, parse = TRUE) {
  if (x$status_code > 203) {
    txt <- tryCatch(x$parse("utf-8"), error = function(e) e)
    if (inherits(txt, "error")) x$raise_for_status()
    json <- tryCatch(jsonlite::fromJSON(txt), error = function(e) e)
    if (inherits(json, "error")) x$raise_for_status()
    stop(sprintf("%s %s: %s", x$status_http()$message, json$code, json$message),
      call. = FALSE)
  }
  txt <- x$parse("utf-8")
  jsonlite::fromJSON(txt, parse)
}
