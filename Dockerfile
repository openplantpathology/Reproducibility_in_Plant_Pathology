# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.4.4

# required
MAINTAINER Adam Sparks adamhsparks@gmail.com

COPY --chown=rstudio . /home/rstudio/Reproducibility_in_Plant_Pathology

# go into the repo directory
RUN . /etc/environment \
  \
  # build this compendium package
  && R -e "devtools::install('home/rstudio/Reproducibility_in_Plant_Pathology', dep=TRUE)" \
  \
 # render the manuscript into a docx, you'll need to edit this if you've
 # customised the location and name of your main Rmd file
  && R -e "rmarkdown::render('home/rstudio/Reproducibility_in_Plant_Pathology/inst/paper/Sparks_et_al-main_text.Rmd')"
