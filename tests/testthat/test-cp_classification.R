test_that("cp_classification", {
  vcr::use_cassette("cp_classification", {
    x <- cp_classification(dataset_key=3, 
      taxon_id='709dfa66-43fe-4736-a774-59f821a2ee23')
  })

  expect_is(x, "data.frame")
  expect_is(x$scientificName, "character")
  # more important columns should be to the left
  expect_equal(names(x)[1:4],
    c("scientificName", "rank", "id", "status"))
})

test_that("cp_classification fails well", {
  # dataset_key not given
  expect_error(cp_classification(), class = "error")
  # taxon_id not given
  expect_error(cp_classification(1000), class = "error")
  # dataset_key not correct type
  expect_error(cp_classification(as.factor(1000)), class = "error")
  # taxon_id not correct type
  expect_error(cp_classification(1000, as.factor(1000)), class = "error")
})
