context("cp_dataset")

skip_on_cran()

test_that("cp_dataset", {

  vcr::use_cassette("cp_dataset", {
    x <- cp_dataset(dataset_keys = 1000)
    w <- cp_dataset(dataset_keys = c(3, 1000, 1014))
  }, preserve_exact_body_bytes = TRUE)

  expect_is(x, "list")
  expect_named(x, NULL)
  expect_named(x[[1]])
  expect_equal(length(x), 1)
  
  expect_is(w, "list")
  expect_named(w, NULL)
  expect_named(w[[1]])
  expect_equal(length(w), 3)
})

test_that("cp_dataset fails well", {
  # dataset_keys not given
  expect_error(cp_dataset(), class = "error")
  # wrong class type
  expect_error(cp_dataset(as.factor(5)), "must be of class")
})


context("cp_datasets")
test_that("cp_datasets", {
  vcr::use_cassette("cp_datasets", {
    x <- cp_datasets(limit = 5)
  }, preserve_exact_body_bytes = TRUE)

  expect_is(x, "list")
  expect_named(x, c("result", "meta"))
  expect_is(x$meta, "data.frame")
  expect_is(x$result, "data.frame")
  # more important columns should be to the left
  expect_equal(names(x$result)[1:3], c("title", "key", "alias"))
})
test_that("cp_datasets fails well", {
  # wrong class type
  expect_error(cp_datasets(q = 5), class = "error")
  expect_error(cp_datasets(limit = "adf"), class = "error")
  expect_error(cp_datasets(start = "adf"), class = "error")
})
