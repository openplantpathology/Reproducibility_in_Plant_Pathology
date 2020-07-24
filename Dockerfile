# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.0.0

# required
MAINTAINER Adam Sparks adamhsparks@gmail.com

COPY --chown=rstudio . /home/rstudio/Reproducibility_in_Plant_Pathology

# go into the repo directory
RUN . /etc/environment \

  # build this compendium package
  && R -e "devtools::install('home/rstudio/Reproducibility_in_Plant_Pathology', dep=TRUE)" \

  # make project directory writable to save images and other output
  && sudo chmod a+rwx -R Reproducibility_in_Plant_Pathology \

 # render the manuscript into a MS Word docx output
  && sudo R -e "setwd('/Reproducibility_in_Plant_Pathology/analysis/paper')" \
  && sudo R -e "source('knit_paper.R')"
