context("import_notes()")

# Test that import_notes() returns expected results, a tibble with 47 cols
# and columns that are set to factor are factors. All other default as read.
test_that("import_notes returns expected results", {
  notes <- import_notes()
  expect_true(tibble::is_tibble(notes))
  expect_equal(ncol(notes), 48)
  expect_equal(class(notes$journal), "factor")
  expect_equal(class(notes$art_class), "factor")
  expect_equal(class(notes$art_class), "factor")
  expect_equal(class(notes$repro_inst), "factor")
  expect_equal(class(notes$open), "factor")
  expect_equal(class(notes$assignee), "factor")
})
