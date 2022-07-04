# Test that import_notes() returns expected results, a tibble with 49 cols
# and columns that are set to factor are factors. All other default as read.
test_that("import_notes returns expected results", {
  notes <- import_notes()
  expect_equal(ncol(notes), 21)
  expect_equal(class(notes$journal), "factor")
  expect_equal(class(notes$art_class), "factor")
  expect_equal(class(notes$art_class), "factor")
  expect_equal(class(notes$repro_inst), "factor")
  expect_equal(class(notes$open), "factor")
  expect_equal(class(notes$assignee), "factor")
})
