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
  vcr::use_cassette("cp_ds_namesdiff_bad_key", {
    expect_error(cp_ds("{key}/namesdiff", key = 4),
      "successful imports must exist to provide a diff")
  })

  # does not exist
  vcr::use_cassette("cp_ds_tree_does_not_exist", {
    expect_error(cp_ds("{key}/tree", key = 2), "does not exist")
  })
})

