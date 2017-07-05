Reproducible Plant Pathology
================

[![Last-changedate](https://img.shields.io/badge/last%20change-2017--07--05-brightgreen.svg)](https://github.com/phytopathology/Reproducible.Plant.Pathology/commits/master) [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.4.0-brightgreen.svg)](https://cran.r-project.org/) [![Licence](https://img.shields.io/github/license/mashape/apistatus.svg)](http://choosealicense.com/licenses/mit/) [![Travis-CI Build Status](https://travis-ci.org/phytopathology/Reproducible.Plant.Pathology.svg?branch=master)](https://travis-ci.org/phytopathology/Reproducible.Plant.Pathology)

Research compendium for a report on the reproducibility of research in plant pathology
--------------------------------------------------------------------------------------

### Compendium DOI:

<http://dx.doi.org/xxxxxxx>

The files at the URL above will generate the results as found in the publication. The files hosted at <https://github.com/phytopathology/Reproducible.Plant.Pathology> are the development versions and may have changed since the report was published.

### Authors of this repository:

Adam H Sparks (<adamhsparks@gmail.com>)
Emerson M Del Ponte (<delponte@ufv.br>)
Zachary Foster (<zacharyfoster1989@gmail.com>)
Niklaus J Grünwald (<grunwaln@science.oregonstate.edu>)

### Published in:

### Overview of contents

This repository is our research compendium that details our methodology for examining the state of reproducible research in plant pathology. The compendium contains all data, code, and text associated with the publication XXXX published in XXX. The `R markdown format` (`Rmd`) files in the `inst/paper/` directory contain details of how all the analyses reported in the paper were conducted. Detailed instructions on methods used and how to rerun the analysis to reproduce the results are found in the vignettes, in the `vingettes/` directory.

### The supplementary files

The `inst/` directory contains:

-   the manuscript as submitted (in MS Word format) and its `Rmd` source file (in the `paper/` directory)

-   supplementary information source files (in `Rmd` format) and executed versions

-   all the figures that are included in the paper (in the `figures/` directory)

### The external files

Much of the collaborative work was done outside of GitHub and R using Google Sheets. You can view the [article notes](https://drive.google.com/open?id=19gXobV4oPZeWZiQJAPNIrmqpfGQtpapXWcSxaXRw1-M) that we collected in the "article\_evaluations" tab. Where "template" and "article\_notes" are used in creating that tab and are explained the "Assigning Articles" vignette of this R package.

### The R package

This repository is organized as an R package. There is one R function, `doi2bib()`, that is used in this repository, along with the data, `assigned_article_notes.rda` that are located in `data` directory. We have used the R package structure to help manage dependencies, to take advantage of continuous integration for automated code testing and for file organisation.

To download the package source as you see it on GitHub, for offline browsing, use this line at the shell prompt (assuming you have Git installed on your computer):

    git clone https://github.com/phytopathology/Reproducible.Plant.Pathology.git

Once the download is complete, open the `Reproducible.Plant.Pathology.Rproj` in RStudio to begin working with the package and compendium files.

The package has a number of dependencies on other R packages, and programs outside of R. These are listed at the bottom of this README. Installing these can be time-consuming and complicated, so we've done two things to simplify access to the compendium. First is the `packrat/` directory, which contains the source code for all the packages we depend on. If all works well, these will be installed on your computer when you open `Reproducible.Plant.Pathology.Rproj` in RStudio. <!--- Second is our Docker image that includes all the necessary software, code and data to run our analysis. The Docker image may give a quicker entry point to the project, and is more self-contained, so might save some fiddling with installing things.   


### The Docker image 

A Docker image is a lightweight GNU/Linux virtual computer that can be run as a piece of software on Windows and OSX (and other Linux systems). To capture the complete computational environment used for this project we have a Dockerfile that specifies how to make the Docker image that we developed this project in. The Docker image includes all of the software dependencies needed to run the code in this project, as well as the R package and other compendium files. To launch the Docker image for this project, first, [install Docker](https://docs.docker.com/installation/) on your computer. At the Docker prompt, enter:

    docker run -dp 8787:8787 phytopathology/Reproducible.Plant.Pathology

This will start a server instance of RStudio. Then open your web browser at localhost:8787 or or run `docker-machine ip default` in the shell to find the correct IP address, and log in with rstudio/rstudio.

Once logged in, use the Files pane (bottom right) to navigate to `/` (the root directory), then open the folder for this project, and open the `.Rproj` file for this project. Once that's open, you'll see the `analysis/paper` directory in the Files pane where you can find the R markdown document, and knit them to produce the results in the paper. More information about using RStudio in Docker is avaiable at the [Rocker](https://github.com/rocker-org) [wiki](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image) pages.
 
We developed and tested the package on this Docker container, so this is the only platform that We're confident it works on, and so recommend to anyone wanting to use this package to generate the vignette, etc. 
--->

### Licenses

Manuscript: [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

Code: [MIT](http://opensource.org/licenses/MIT) year: 2017, copyright holder: Adam H Sparks

Data: [CC-0](http://creativecommons.org/publicdomain/zero/1.0/) attribution requested in reuse

### Dependencies

We used [RStudio](http://www.rstudio.com/products/rstudio/) on macOS and Ubuntu 16.04 LTS.

We also used [JabRef](http://www.jabref.org/) and [Google Sheets](https://www.google.com/sheets/about/).

### Contact

Adam H Sparks, Associate Professor, Centre for Crop Health University of Southern Queensland Toowoomba, Queensland 4350

(+61) (7) 4831 1948 e. <adam.sparks@usq.edu.au> <https://staffprofile.usq.edu.au/Profile/Adam-Sparks>

### Credits

This research compendium was based on <https://github.com/benmarwick/researchcompendium> but not forked from because it was already under development when I found Ben's.
