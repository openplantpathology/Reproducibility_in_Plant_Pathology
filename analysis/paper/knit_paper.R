# knits the paper using knitr, reimports the document to replace
#  "Table: Table ..." with "Table: ..."
#  Saves updated docx file

library("rmarkdown")
library("officer")
library("here")

# Step 1. Knit Rmd file
render(input = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.Rmd",
       output_file = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.docx")

# Step 2: Import .docx file
paper <-
  read_docx(path = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.docx")

# Step 3: Replace "Table: Table ..." with "Table ..."
paper <-
  body_replace_all_text(x = paper,
                        old_value = "Table: Table ",
                        new_value = "Table ")

# Step 4: Replace .docx file with updated version
print(x = paper, target = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.docx")
