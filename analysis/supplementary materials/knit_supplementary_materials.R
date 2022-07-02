# knits the paper using knitr

library("rmarkdown")

# Knit Rmd file
render(input = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/supplementary materials/supplementary materials.Rmd",
       output_file = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/supplementary materials/supplementary-materials.docx")
