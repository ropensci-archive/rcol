test_that("colp_search", {
  vcr::use_cassette("colp_search", {
    x <- colp_search(q = "Apis")
  })

  expect_is(x, "list")
})
