# knits the paper using knitr

library("rmarkdown")

# Knit Rmd file for manuscript
render(input = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.Rmd",
       output_file = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/paper.docx")

# Knit Rmd file for supplementary materials
render(input = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/supplementary materials.Rmd",
       output_file = "/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/supplementary-materials.docx")

