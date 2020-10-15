ds_routes <- c(
"/dataset/{key}",
# "/dataset/{key}/import/{attempt}/tree",
# "/dataset/{key}/import/{attempt}/names",
# "/dataset/{key}/import/{attempt}/ids",
# "/dataset/{key}/import",
# "/dataset/{key}/import/{attempt}",
# "/dataset/{datasetKey}/diff/tree",
# "/dataset/{datasetKey}/diff/names",
# "/dataset/{datasetKey}/diff/ids",
# "/dataset/{datasetKey}/patch/{id}",
# "/dataset/{datasetKey}/patch",
# "/dataset/{datasetKey}/settings",
# "/dataset/{datasetKey}/editor",
"/dataset/{datasetKey}/latest",
"/dataset/{datasetKey}/assembly",
# "/dataset/{datasetKey}/logo",
"/dataset/{datasetKey}/source",
# "/dataset/{datasetKey}/source/{key}",
"/dataset/{datasetKey}/source/{key}/metrics",
"/dataset/{datasetKey}/decision",
"/dataset/{datasetKey}/decision/{id}",
# "/dataset/{datasetKey}/duplicate",
"/dataset/{datasetKey}/estimate/{id}",
"/dataset/{datasetKey}/estimate",
# "/dataset/{datasetKey}/export",
# "/dataset/{datasetKey}/export/{taxonID}",
# "/dataset/{datasetKey}/export/css",
# "/dataset/{datasetKey}/legacy",
"/dataset/{datasetKey}/name/orphans",
"/dataset/{datasetKey}/name/{id}/relations",
"/dataset/{datasetKey}/name/{id}/group",
"/dataset/{datasetKey}/name/{id}/synonyms",
"/dataset/{datasetKey}/name/{id}/types",
"/dataset/{datasetKey}/name/{id}",
"/dataset/{datasetKey}/name",
"/dataset/{datasetKey}/nameusage/{id}",
# "/dataset/{datasetKey}/nameusage/search", # skip, requires query params
# "/dataset/{datasetKey}/nameusage/suggest", # skip, requires query params
# "/dataset/{datasetKey}/nameusage",
"/dataset/{datasetKey}/reference/orphans",
"/dataset/{datasetKey}/reference",
"/dataset/{datasetKey}/reference/{id}",
# "/dataset/{datasetKey}/sector/{key}/diff/tree",
# "/dataset/{datasetKey}/sector/{key}/diff/names",
# "/dataset/{datasetKey}/sector/{key}/diff/ids",
"/dataset/{datasetKey}/sector",
"/dataset/{datasetKey}/sector/{id}/sync",
# "/dataset/{datasetKey}/sector/{id}/sync/{attempt}/tree",
# "/dataset/{datasetKey}/sector/{id}/sync/{attempt}/names",
# "/dataset/{datasetKey}/sector/{id}/sync/{attempt}/ids",
# "/dataset/{datasetKey}/sector/{id}/sync/{attempt}",
"/dataset/{datasetKey}/sector/sync",
"/dataset/{datasetKey}/sector/{id}",
"/dataset/{datasetKey}/synonym/{id}",
"/dataset/{datasetKey}/synonym",
"/dataset/{datasetKey}/taxon/{id}/children",
"/dataset/{datasetKey}/taxon/{id}/synonyms",
"/dataset/{datasetKey}/taxon/{id}/classification",
# "/dataset/{datasetKey}/taxon/{id}/info",
"/dataset/{datasetKey}/taxon/{id}",
"/dataset/{datasetKey}/taxon",
"/dataset/{datasetKey}/tree/{id}/children",
"/dataset/{datasetKey}/tree/{id}",
"/dataset/{datasetKey}/tree",
"/dataset/{datasetKey}/verbatim/{key}",
"/dataset/{datasetKey}/verbatim"
)

test_that("cp_ds_all_routes", {
  estimate <- list(datasetKey=3, id=68)
  namez <- list(datasetKey=3, id=0)
  nameusage <- list(datasetKey=3, id='44f73e4c-3ead-43ab-b63c-984e111b9f2b', q="poa")
  ref <- list(datasetKey=3, id='00000486-5f68-499f-bab6-403eaea47339')
  sector <- list(datasetKey=3, id=1131)
  syn <- list(datasetKey=3, id='0000001b-4a37-4fbe-9996-760ca91c5096')
  taxon <- list(datasetKey=3, id=0)
  params <- list(key=1005, datasetKey=3, id=230686, attempt=10, q="poa", id='00000486-5f68-499f-bab6-403eaea47339')
  out <- list()
  for (i in seq_along(ds_routes[31:36])) {
    route <- sub("/dataset/", "", ds_routes[31:36][i])
    pars <- if (grepl("estimate", route)) estimate else params
    pars <- if (grepl("name/|name$", route)) namez else pars
    pars <- if (grepl("nameusage", route)) nameusage else pars
    pars <- if (grepl("reference", route)) ref else pars
    pars <- if (grepl("sector", route)) sector else pars
    pars <- if (grepl("synonym$|synonym/", route)) syn else pars
    pars <- if (grepl("taxon$|taxon/|tree", route)) taxon else pars
    # out[[i]] <- cp_ds(route, .list = pars)
    expect_true(inherits(cp_ds(route, .list = pars), c("list", "data.frame")))
  }
})

test_that("cp_ds", {
  vcr::use_cassette("cp_ds", {
    x <- cp_ds("{key}/name", key = "1014")
  })

  expect_is(x, "list")
  expect_is(x$offset, "integer")
  expect_is(x$limit, "integer")
  expect_is(x$total, "integer")
  expect_is(x$last, "logical")
  expect_is(x$result, "data.frame")
})

test_that("cp_ds fails well", {
  # route not given
  expect_error(cp_ds(), class = "error")
  # no inputs given to route
  expect_error(cp_ds("{key}/namesdiff"), class = "error")
  # specific named "key" not given
  expect_error(cp_ds("{key}/namesdiff", foo = "bar"), class = "error")
  # logo route not supported
  expect_error(cp_ds("{key}/logo"), "logo route not supported")

  # requires HTTP requests
  # bad key
  
  # vcr::use_cassette("cp_ds_namesdiff_bad_key", {
  #   expect_error(cp_ds("{key}/namesdiff", key = 4),
  #     "successful imports must exist to provide a diff")
  # })

  # does not exist
  vcr::use_cassette("cp_ds_tree_does_not_exist", {
    expect_error(cp_ds("{key}/tree", key = 2), "does not exist")
  })
})

