# test diversities table -------------------------------------------------------

test_that("table_of_journals() returns a pander object of journals surveyed", {
  googlesheets4::gs4_deauth()
  rrpp <- googlesheets4::read_sheet(
  "https://docs.google.com/spreadsheets/d/19gXobV4oPZeWZiQJAPNIrmqpfGQtpapXWcSxaXRw1-M"
  )

  expect_type(capture.output(table_of_journals(rrpp)),
              "character")
})
