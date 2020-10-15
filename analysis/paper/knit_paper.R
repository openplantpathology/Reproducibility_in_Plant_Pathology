# knits the paper using knitr

library("rmarkdown")

# Knit Rmd file
render(input = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.Rmd",
       output_file = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.docx")
