skip_on_cran()

test_that("cp_vocab", {
  vcr::use_cassette("cp_vocab", {
    x <- cp_vocab("rank")
  })

  expect_is(x, "character")
  expect_true(any(grepl("species", x)))
  expect_gt(length(x), 10)
})

test_that("cp_vocab fails well", {
  # dataset_key not given
  expect_error(cp_vocab(), class = "error")
  # taxon_id not given
  expect_error(cp_vocab(1000), class = "error")
})
