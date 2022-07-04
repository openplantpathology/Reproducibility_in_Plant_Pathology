# Test that import_interrater_scores() returns expected results, a df with 12 cols
test_that("import_inter-rater_scores returns expected results", {
  scores <- import_interrater_scores()
  expect_equal(ncol(scores), 12)
})
