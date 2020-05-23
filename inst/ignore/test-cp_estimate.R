test_that("cp_estimate", {
  vcr::use_cassette("cp_estimate", {
    x <- cp_estimate()
    w <- cp_estimate(rank = "genus")
  })

  expect_is(x, "list")
  expect_is(x$meta$offset, "integer")
  expect_is(x$meta$limit, "integer")
  expect_is(x$meta$total, "integer")
  expect_is(x$meta$last, "logical")
  expect_is(x$meta$empty, "logical")
  expect_is(x$result, "data.frame")

  expect_is(w, "list")
  expect_is(w$meta$offset, "integer")
  expect_is(w$meta$limit, "integer")
  expect_is(w$meta$total, "integer")
  expect_is(w$meta$last, "logical")
  expect_is(w$meta$empty, "logical")
  expect_is(w$result, "data.frame")
  # rank matches query value
  expect_equal(unique(w$result$target$rank), "genus")
})

test_that("cp_estimate fails well", {
  # dataset_key of wrong type
  expect_error(cp_estimate(5), class = "error")
  # broken of wrong type
  expect_error(cp_estimate(broken = 3), class = "error")
})

