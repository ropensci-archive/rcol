test_that("cp_name_match", {
  vcr::use_cassette("cp_name_match", {
    x <- cp_name_match(q="Apis", rank = "genus")
    z <- cp_name_match(q="Apis mellifer")
  })
  expect_is(x, "list")
  expect_is(x$name, "list")
  # no match
  expect_named(z, "type")
  expect_equal(z$type, "none")
})

test_that("cp_name_match fails well", {
  # q of wrong type
  expect_error(cp_name_match(5), class = "error")
  # rank of wrong type
  expect_error(cp_name_match(rank = 3), class = "error")
})

