# knits the paper using knitr, reimports the document to replace
#  "Table: Table ..." with "Table: ..."
#  Saves updated docx file

library("knitr")
library("officer")
library("here")

# Step 1. Knit Rmd file
knit(input = here("analysis/paper/paper.Rmd"))

# Step 2: Import .docx file
paper <- read_docx(path = here("analysis/paper/paper.docx"))

# Step 3: Replace "Table: Table ..." with "Table ..."
paper <-
  body_replace_all_text(x = paper,
                        old_value = "Table: Table ",
                        new_value = "Table ")

# Step 4: Replace .docx file with updated version
print(x = paper,
      target = here("analysis/paper/paper.docx"))
