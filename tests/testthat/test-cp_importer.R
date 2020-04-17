test_that("cp_importer", {
  vcr::use_cassette("cp_importer", {
    x <- cp_importer()
    w <- cp_importer(rank = "genus")
  })

  expect_is(x, "list")
  expect_is(x$offset, "integer")
  expect_is(x$limit, "integer")
  expect_is(x$total, "integer")
  expect_is(x$last, "logical")
  expect_is(x$empty, "logical")
  expect_is(x$result, "list")

  expect_is(w, "list")
  expect_is(w$offset, "integer")
  expect_is(w$limit, "integer")
  expect_is(w$total, "integer")
  expect_is(w$last, "logical")
  expect_is(w$empty, "logical")
  expect_is(w$result, "list")
})

test_that("cp_importer fails well", {
  # dataset_key of wrong type
  expect_error(cp_importer(5), class = "error")
  # running of wrong type
  expect_error(cp_importer(running = 3), class = "error")
})

