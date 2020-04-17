test_that("cp_parser", {
  vcr::use_cassette("cp_parser", {
    x <- cp_parser(names = "Apis mellifera")
    w <- cp_parser(names = c("Apis mellifera", "Homo sapiens var. sapiens"))
  })

  expect_is(x, "data.frame")
  expect_is(x$scientificName, "character")
  expect_is(x$rank, "character")
  expect_equal(NROW(x), 1)

  expect_is(w, "data.frame")
  expect_is(w$scientificName, "character")
  expect_is(w$rank, "character")
  expect_equal(NROW(w), 2) 
})

test_that("cp_parser fails well", {
  # names is required
  expect_error(cp_parser(), class = "error")
  # names of wrong type
  expect_error(cp_parser(names = 3), class = "error")
})

