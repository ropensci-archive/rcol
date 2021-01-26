skip_on_cran()

ds_routes <- c(
"/dataset/{key}",
# "/dataset/{key}/import/{attempt}/tree",
# "/dataset/{key}/import/{attempt}/names",
# "/dataset/{key}/import/{attempt}/ids",
# "/dataset/{key}/import",
# "/dataset/{key}/import/{attempt}",
# "/dataset/{key}/diff/tree",
# "/dataset/{key}/diff/names",
# "/dataset/{key}/diff/ids",
# "/dataset/{key}/patch/{id}",
# "/dataset/{key}/patch",
# "/dataset/{key}/settings",
# "/dataset/{key}/editor",
"/dataset/{key}/latest",
"/dataset/{key}/assembly",
# "/dataset/{key}/logo",
"/dataset/{key}/source",
# "/dataset/{key}/source/{key}",
"/dataset/{key}/source/{key}/metrics",
"/dataset/{key}/decision",
# "/dataset/{key}/decision/{id}",
# "/dataset/{key}/duplicate",
"/dataset/{key}/estimate/{id}",
"/dataset/{key}/estimate",
# "/dataset/{key}/export",
# "/dataset/{key}/export/{taxonID}",
# "/dataset/{key}/export/css",
# "/dataset/{key}/legacy",
"/dataset/{key}/name/orphans",
"/dataset/{key}/name/{id}/relations",
"/dataset/{key}/name/{id}/group",
"/dataset/{key}/name/{id}/synonyms",
"/dataset/{key}/name/{id}/types",
"/dataset/{key}/name/{id}",
"/dataset/{key}/name",
"/dataset/{key}/nameusage/{id}",
# "/dataset/{key}/nameusage/search", # skip, requires query params
# "/dataset/{key}/nameusage/suggest", # skip, requires query params
# "/dataset/{key}/nameusage",
"/dataset/{key}/reference/orphans",
"/dataset/{key}/reference",
"/dataset/{key}/reference/{id}",
# "/dataset/{key}/sector/{key}/diff/tree",
# "/dataset/{key}/sector/{key}/diff/names",
# "/dataset/{key}/sector/{key}/diff/ids",
"/dataset/{key}/sector",
"/dataset/{key}/sector/{id}/sync",
# "/dataset/{key}/sector/{id}/sync/{attempt}/tree",
# "/dataset/{key}/sector/{id}/sync/{attempt}/names",
# "/dataset/{key}/sector/{id}/sync/{attempt}/ids",
# "/dataset/{key}/sector/{id}/sync/{attempt}",
"/dataset/{key}/sector/sync",
"/dataset/{key}/sector/{id}",
"/dataset/{key}/synonym/{id}",
"/dataset/{key}/synonym",
"/dataset/{key}/taxon/{id}/children",
"/dataset/{key}/taxon/{id}/synonyms",
"/dataset/{key}/taxon/{id}/classification",
# "/dataset/{key}/taxon/{id}/info",
"/dataset/{key}/taxon/{id}",
"/dataset/{key}/taxon",
"/dataset/{key}/tree/{id}/children",
"/dataset/{key}/tree/{id}",
"/dataset/{key}/tree",
# "/dataset/{key}/verbatim/{key}",
"/dataset/{key}/verbatim"
)

test_that("cp_ds_all_routes", {
  skip_on_ci()
  
  estimate <- list(datasetKey=3, key=3, id=68)
  namez <- list(datasetKey=3, key=3, id=0)
  taxon <- latest <- namez
  nameusage <- list(datasetKey=3, key=3, id='0000082e-d375-497a-838b-4312b253b9bd', q="poa")
  ref <- list(datasetKey=3, key=3, id='00000486-5f68-499f-bab6-403eaea47339')
  sector <- list(datasetKey=3, key=3, id=1131)
  syn <- list(datasetKey=3, key=3, id='000005d2-2ef3-4734-8612-577c95877c0e')
  params <- list(key=1005, datasetKey=3, key=3, id=230686, attempt=10, q="poa", id='00000486-5f68-499f-bab6-403eaea47339')
  out <- list()
  for (i in seq_along(ds_routes)) {
    route <- sub("/dataset/", "", ds_routes[i])
    pars <- if (grepl("latest", route)) latest else params
    pars <- if (grepl("estimate", route)) estimate else params
    pars <- if (grepl("name/|name$", route)) namez else pars
    pars <- if (grepl("nameusage", route)) nameusage else pars
    pars <- if (grepl("reference", route)) ref else pars
    pars <- if (grepl("sector", route)) sector else pars
    pars <- if (grepl("synonym$|synonym/", route)) syn else pars
    pars <- if (grepl("taxon$|taxon/|tree", route)) taxon else pars
    # out[[i]] <- cp_ds(route, .list = pars)
    # expect_true(inherits(cp_ds(route, .list = pars), c("list", "data.frame")))
    # cat(route, sep="\n")
    cp_ds(route, .list = pars)
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

