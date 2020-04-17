test_that("cp_nu_search", {
  vcr::use_cassette("cp_nu_search", {
    x <- cp_nu_search(q = "Apis")
  })

  expect_is(x, "list")
})
