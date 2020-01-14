test_that("cp_nameusage_search", {
  vcr::use_cassette("cp_nameusage_search", {
    x <- cp_nameusage_search(q = "Apis")
  })

  expect_is(x, "list")
})
