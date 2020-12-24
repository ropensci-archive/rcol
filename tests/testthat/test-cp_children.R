skip_on_cran()

test_that("cp_children", {
  vcr::use_cassette("cp_children", {
    x <- cp_children(dataset_key=1000, taxon_id=1)
  })

  expect_is(x, "list")
  expect_named(x, c("result", "meta"))
  expect_is(x$result, "data.frame")
  expect_is(x$meta, "data.frame")
  # more important columns should be to the left
  expect_equal(names(x$result)[1:4],
    c("scientificName", "rank", "id", "status"))
})

test_that("cp_children fails well", {
  # dataset_key not given
  expect_error(cp_children(), class = "error")
  # taxon_id not given
  expect_error(cp_children(1000), class = "error")
  # dataset_key not correct type
  expect_error(cp_children(as.factor(1000)), class = "error")
  # taxon_id not correct type
  expect_error(cp_children(1000, as.factor(1000)), class = "error")
})
