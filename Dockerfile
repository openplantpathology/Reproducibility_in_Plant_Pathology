# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.2.1
# required
MAINTAINER Adam Sparks adamhsparks@gmail.com

COPY --chown=rstudio . /home/rstudio/Reproducibility_in_Plant_Pathology

# go into the repo directory
RUN . /etc/environment \
  \
  # build this compendium package
  && R -e "devtools::install('home/rstudio/Reproducibility_in_Plant_Pathology', dep=TRUE)" \
  \
  # render the manuscript into an MS Word docx output
  && sudo R -e "source('/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/paper/knit_paper.R')" \
  \
  # render the supplementary materials into an MS Word docx output
  && sudo R -e "source('/home/rstudio/Reproducibility_in_Plant_Pathology/analysis/supplementary materials/knit_supplementary_materials.R')"
