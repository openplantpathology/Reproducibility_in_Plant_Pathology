# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.6.2

# required
MAINTAINER Adam Sparks adamhsparks@gmail.com

COPY --chown=rstudio . /home/rstudio/Reproducibility_in_Plant_Pathology

# go into the repo directory
RUN . /etc/environment \
  \
 # build this compendium package
  && R -e "devtools::install('home/rstudio/Reproducibility_in_Plant_Pathology', dep=TRUE)" \
  \
 # build static documentation of pkgdown site
  \
  && R -e "pkgdown::build_site('/home/rstudio/Reproducibility_in_Plant_Pathology')"
