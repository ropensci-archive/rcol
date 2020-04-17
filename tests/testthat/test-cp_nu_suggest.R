test_that("cp_nu_suggest", {
  vcr::use_cassette("cp_nu_suggest", {
    x <- cp_nu_suggest(q="Apis", dataset_key = 3)
  })

  expect_is(x, "data.frame")
  expect_is(x$match, "character")
  expect_is(x$rank, "character")
  expect_is(x$score, "numeric")
  expect_is(x$suggestion, "character")
})

test_that("cp_nu_suggest fails well", {
  # dataset_key of wrong type
  expect_error(cp_nu_suggest(5), class = "error")
  # broken of wrong type
  expect_error(cp_nu_suggest(broken = 3), class = "error")
})

