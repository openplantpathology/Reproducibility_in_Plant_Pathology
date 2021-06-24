# test diversities table -------------------------------------------------------

test_that("workflow_dia() returns an rsvg_pdf object", {
  expect_type(capture.output(workflow_dia()),
              "character")
          })
