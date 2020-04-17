test_that("cp_decision", {
  vcr::use_cassette("cp_decision", {
    x <- cp_decision()
    w <- cp_decision(rank = "genus")
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
  expect_equal(unique(w$result$subject$rank), "genus")
})

test_that("cp_decision fails well", {
  # dataset_key of wrong type
  expect_error(cp_decision(5), class = "error")
  # broken of wrong type
  expect_error(cp_decision(broken = 3), class = "error")
})

